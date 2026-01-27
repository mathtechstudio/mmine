import 'dart:io';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/foundation.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Data source for extracting metadata from audio files.
///
/// This class handles the extraction of metadata (title, artist, album, etc.)
/// from audio files using the audio_metadata_reader package.
///
/// The data source also handles album art extraction and caching.
class MetadataDataSource {
  final _uuid = const Uuid();

  /// Extracts metadata from an audio file at the given [filePath].
  ///
  /// Returns a map containing:
  /// - title: Track title (or filename if not available)
  /// - artist: Artist name (or 'Unknown Artist')
  /// - album: Album name (or 'Unknown Album')
  /// - albumArtist: Album artist name (optional)
  /// - year: Release year (optional)
  /// - genre: Genre (optional)
  /// - trackNumber: Track number in album (optional)
  /// - duration: Track duration
  /// - bitDepth: Bit depth (16 or 24)
  /// - sampleRate: Sample rate in Hz
  /// - albumArt: Album art bytes (optional)
  Future<Map<String, dynamic>> extractMetadata(String filePath) async {
    try {
      final file = File(filePath);
      final metadata = readMetadata(file, getImage: true);

      // Extract album art
      Uint8List? albumArtBytes;
      if (metadata.pictures.isNotEmpty) {
        albumArtBytes = metadata.pictures.first.bytes;
      }

      // Parse duration - metadata.duration is already a Duration
      Duration duration = metadata.duration ?? Duration.zero;

      // Extract year
      int? year;
      if (metadata.year != null) {
        year = metadata.year!.year;
      }

      // Extract genre
      String? genre;
      if (metadata.genres.isNotEmpty) {
        genre = metadata.genres.first;
      }

      return {
        'title': metadata.title ?? p.basenameWithoutExtension(filePath),
        'artist': metadata.artist ?? 'Unknown Artist',
        'album': metadata.album ?? 'Unknown Album',
        'albumArtist': null, // audio_metadata_reader doesn't have albumArtist
        'year': year,
        'genre': genre,
        'trackNumber': metadata.trackNumber,
        'duration': duration,
        'bitDepth': _extractBitDepth(filePath, metadata),
        'sampleRate': _extractSampleRate(filePath, metadata),
        'albumArt': albumArtBytes,
      };
    } catch (e) {
      return _getDefaultMetadata(filePath);
    }
  }

  /// Extracts bit depth from file metadata.
  ///
  /// Attempts to determine the bit depth based on file extension and metadata.
  /// For FLAC files, reads the STREAMINFO block to get actual bit depth.
  /// For WAV files, reads the fmt chunk to get actual bit depth.
  /// For ALAC (M4A) files, attempts to read from stsd atom.
  /// Returns a default value based on the audio format for other formats.
  int _extractBitDepth(String filePath, AudioMetadata metadata) {
    final extension = p.extension(filePath).toLowerCase();

    if (extension == '.flac') {
      try {
        final bitDepth = _readFlacBitDepth(filePath);
        if (bitDepth != null) {
          return bitDepth;
        }
      } catch (e) {
        // Fall through to default
      }
      return 24;
    } else if (extension == '.wav') {
      try {
        final bitDepth = _readWavBitDepth(filePath);
        if (bitDepth != null) {
          return bitDepth;
        }
      } catch (e) {
        // Fall through to default
      }
      return 16;
    } else if (extension == '.m4a') {
      try {
        final bitDepth = _readAlacBitDepth(filePath);
        if (bitDepth != null) {
          return bitDepth;
        }
      } catch (e) {
        // Fall through to default
      }
      return 16;
    }

    return 16; // Default fallback
  }

  /// Extracts sample rate from metadata.
  ///
  /// For FLAC files, reads the STREAMINFO block to get actual sample rate.
  /// For WAV files, reads the fmt chunk to get actual sample rate.
  /// For ALAC (M4A) files, attempts to read from stsd atom.
  /// Returns 44100 Hz (CD quality) as the default if not available.
  int _extractSampleRate(String filePath, AudioMetadata metadata) {
    final extension = p.extension(filePath).toLowerCase();

    if (extension == '.flac') {
      try {
        final sampleRate = _readFlacSampleRate(filePath);
        if (sampleRate != null) {
          return sampleRate;
        }
      } catch (e) {
        // Fall through to default
      }
    } else if (extension == '.wav') {
      try {
        final sampleRate = _readWavSampleRate(filePath);
        if (sampleRate != null) {
          return sampleRate;
        }
      } catch (e) {
        // Fall through to default
      }
    } else if (extension == '.m4a') {
      try {
        final sampleRate = _readAlacSampleRate(filePath);
        if (sampleRate != null) {
          return sampleRate;
        }
      } catch (e) {
        // Fall through to default
      }
    }

    return 44100; // Default fallback
  }

  /// Reads bit depth from FLAC STREAMINFO block.
  ///
  /// FLAC STREAMINFO is located at bytes 18-21 in the file.
  /// Bit depth is stored in bits 36-40 of the STREAMINFO block.
  int? _readFlacBitDepth(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      raf = file.openSync();

      // Check file size
      if (raf.lengthSync() < 42) {
        return null;
      }

      // Read and check FLAC signature (4 bytes)
      final signature = raf.readSync(4);
      if (signature[0] != 0x66 ||
          signature[1] != 0x4C ||
          signature[2] != 0x61 ||
          signature[3] != 0x43) {
        return null;
      }

      // Seek to bit depth position (bytes 20-21)
      raf.setPositionSync(20);
      final bytes = raf.readSync(2);

      // Bits per sample: 5 bits starting at bit 4 of byte 20
      // Formula: ((byte20 & 0x01) << 4) | ((byte21 & 0xF0) >> 4)
      final bitsPerSample = ((bytes[0] & 0x01) << 4) | ((bytes[1] & 0xF0) >> 4);
      final bitDepth =
          bitsPerSample + 1; // Add 1 because it's stored as (bps - 1)

      return bitDepth;
    } catch (e) {
      return null;
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads sample rate from FLAC STREAMINFO block.
  ///
  /// FLAC STREAMINFO is located at bytes 18-21 in the file.
  /// Sample rate is stored in bits 16-35 of the STREAMINFO block.
  int? _readFlacSampleRate(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      raf = file.openSync();

      // Check file size
      if (raf.lengthSync() < 42) {
        return null;
      }

      // Read and check FLAC signature (4 bytes)
      final signature = raf.readSync(4);
      if (signature[0] != 0x66 ||
          signature[1] != 0x4C ||
          signature[2] != 0x61 ||
          signature[3] != 0x43) {
        return null;
      }

      // Seek to sample rate position (bytes 18-20)
      raf.setPositionSync(18);
      final bytes = raf.readSync(3);

      // Sample rate: 20 bits starting at byte 18
      // Formula: (byte18 << 12) | (byte19 << 4) | ((byte20 & 0xF0) >> 4)
      final sampleRate =
          (bytes[0] << 12) | (bytes[1] << 4) | ((bytes[2] & 0xF0) >> 4);

      return sampleRate;
    } catch (e) {
      return null;
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads bit depth from WAV fmt chunk.
  ///
  /// WAV files have a RIFF header followed by fmt chunk.
  /// Bit depth is stored at offset 34 (2 bytes, little-endian).
  int? _readWavBitDepth(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      raf = file.openSync();

      // Check file size
      if (raf.lengthSync() < 44) {
        return null;
      }

      // Read and check RIFF signature
      final riffBytes = raf.readSync(4);
      final riffSignature = String.fromCharCodes(riffBytes);

      // Seek to WAVE signature (offset 8)
      raf.setPositionSync(8);
      final waveBytes = raf.readSync(4);
      final waveSignature = String.fromCharCodes(waveBytes);

      if (riffSignature != 'RIFF' || waveSignature != 'WAVE') {
        return null;
      }

      // Seek to bit depth position (offset 34)
      raf.setPositionSync(34);
      final bytes = raf.readSync(2);

      // Bit depth is 2 bytes, little-endian
      final bitDepth = bytes[0] | (bytes[1] << 8);

      return bitDepth;
    } catch (e) {
      return null;
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads sample rate from WAV fmt chunk.
  ///
  /// WAV files have a RIFF header followed by fmt chunk.
  /// Sample rate is stored at offset 24 (4 bytes, little-endian).
  int? _readWavSampleRate(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      raf = file.openSync();

      // Check file size
      if (raf.lengthSync() < 44) {
        return null;
      }

      // Read and check RIFF signature
      final riffBytes = raf.readSync(4);
      final riffSignature = String.fromCharCodes(riffBytes);

      // Seek to WAVE signature (offset 8)
      raf.setPositionSync(8);
      final waveBytes = raf.readSync(4);
      final waveSignature = String.fromCharCodes(waveBytes);

      if (riffSignature != 'RIFF' || waveSignature != 'WAVE') {
        return null;
      }

      // Seek to sample rate position (offset 24)
      raf.setPositionSync(24);
      final bytes = raf.readSync(4);

      // Sample rate is 4 bytes, little-endian
      final sampleRate =
          bytes[0] | (bytes[1] << 8) | (bytes[2] << 16) | (bytes[3] << 24);

      return sampleRate;
    } catch (e) {
      return null;
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads bit depth from ALAC (M4A) file.
  ///
  /// ALAC files use MP4 container with alac atom.
  /// This is a simplified parser that looks for the alac atom.
  int? _readAlacBitDepth(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      raf = file.openSync();
      final fileLength = raf.lengthSync();

      // Read file in chunks to search for 'alac' atom
      const chunkSize = 8192;
      final buffer = List<int>.filled(chunkSize + 36, 0);
      int position = 0;

      while (position < fileLength) {
        raf.setPositionSync(position);
        final bytesRead = raf.readIntoSync(buffer, 0, chunkSize + 36);

        if (bytesRead < 36) break;

        // Search for 'alac' atom in current chunk
        for (int i = 0; i < bytesRead - 36; i++) {
          if (buffer[i] == 0x61 &&
              buffer[i + 1] == 0x6C &&
              buffer[i + 2] == 0x61 &&
              buffer[i + 3] == 0x63) {
            // Found 'alac' atom
            // Bit depth is at offset +25 from 'alac' (1 byte)
            if (i + 25 < bytesRead) {
              return buffer[i + 25];
            }
          }
        }

        position += chunkSize;
      }

      return null;
    } catch (e) {
      return null;
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads sample rate from ALAC (M4A) file.
  ///
  /// ALAC files use MP4 container with alac atom.
  /// This is a simplified parser that looks for the alac atom.
  int? _readAlacSampleRate(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return null;
      }

      raf = file.openSync();
      final fileLength = raf.lengthSync();

      // Read file in chunks to search for 'alac' atom
      const chunkSize = 8192;
      final buffer = List<int>.filled(chunkSize + 36, 0);
      int position = 0;

      while (position < fileLength) {
        raf.setPositionSync(position);
        final bytesRead = raf.readIntoSync(buffer, 0, chunkSize + 36);

        if (bytesRead < 36) break;

        // Search for 'alac' atom in current chunk
        for (int i = 0; i < bytesRead - 36; i++) {
          if (buffer[i] == 0x61 &&
              buffer[i + 1] == 0x6C &&
              buffer[i + 2] == 0x61 &&
              buffer[i + 3] == 0x63) {
            // Found 'alac' atom
            // Sample rate is at offset +32 from 'alac' (4 bytes, big-endian)
            if (i + 35 < bytesRead) {
              final sampleRate =
                  (buffer[i + 32] << 24) |
                  (buffer[i + 33] << 16) |
                  (buffer[i + 34] << 8) |
                  buffer[i + 35];
              return sampleRate;
            }
          }
        }

        position += chunkSize;
      }

      return null;
    } catch (e) {
      return null;
    } finally {
      raf?.closeSync();
    }
  }

  /// Returns default metadata when extraction fails.
  ///
  /// Creates a metadata map with default values based on the filename.
  /// Used as a fallback when metadata extraction fails.
  Map<String, dynamic> _getDefaultMetadata(String filePath) {
    return {
      'title': p.basenameWithoutExtension(filePath),
      'artist': 'Unknown Artist',
      'album': 'Unknown Album',
      'albumArtist': null,
      'year': null,
      'genre': null,
      'trackNumber': null,
      'duration': Duration.zero,
      'bitDepth': 16,
      'sampleRate': 44100,
      'albumArt': null,
    };
  }

  /// Extracts and saves album art to local storage.
  ///
  /// Takes the album art data from metadata and saves it as a file in the
  /// application's documents directory. The file is named with a UUID to
  /// avoid conflicts.
  ///
  /// Returns the path to the saved album art file, or null if:
  /// - No album art data is provided
  /// - The album art data is empty
  /// - Saving fails
  Future<String?> extractAndSaveAlbumArt(
    String filePath,
    Uint8List? albumArtData,
  ) async {
    if (albumArtData == null || albumArtData.isEmpty) {
      return null;
    }

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final albumArtDir = Directory('${appDir.path}/album_art');

      if (!await albumArtDir.exists()) {
        await albumArtDir.create(recursive: true);
      }

      final fileName = '${_uuid.v4()}.jpg';
      final file = File('${albumArtDir.path}/$fileName');

      await file.writeAsBytes(albumArtData);

      return file.path;
    } catch (e) {
      debugPrint('Error saving album art: $e');
      return null;
    }
  }

  AudioFormat getAudioFormat(String filePath) {
    final extension = p.extension(filePath).toLowerCase();

    switch (extension) {
      case '.flac':
        return AudioFormat.flac;
      case '.wav':
        return AudioFormat.wav;
      case '.m4a':
        return AudioFormat.alac;
      default:
        throw Exception('Unsupported audio format: $extension');
    }
  }
}
