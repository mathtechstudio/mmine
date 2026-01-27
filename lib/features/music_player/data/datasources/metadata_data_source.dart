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

  /// Cache for audio info to avoid reading the same file multiple times.
  final Map<String, Map<String, int?>> _audioInfoCache = {};

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
      final info = _getOrReadFlacInfo(filePath);
      return info['bitDepth'] ?? 24;
    } else if (extension == '.wav') {
      final info = _getOrReadWavInfo(filePath);
      return info['bitDepth'] ?? 16;
    } else if (extension == '.m4a') {
      final info = _getOrReadAlacInfo(filePath);
      return info['bitDepth'] ?? 16;
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
      final info = _getOrReadFlacInfo(filePath);
      return info['sampleRate'] ?? 44100;
    } else if (extension == '.wav') {
      final info = _getOrReadWavInfo(filePath);
      return info['sampleRate'] ?? 44100;
    } else if (extension == '.m4a') {
      final info = _getOrReadAlacInfo(filePath);
      return info['sampleRate'] ?? 44100;
    }

    return 44100; // Default fallback
  }

  /// Gets or reads FLAC audio info from cache.
  Map<String, int?> _getOrReadFlacInfo(String filePath) {
    if (_audioInfoCache.containsKey(filePath)) {
      return _audioInfoCache[filePath]!;
    }
    final info = _readFlacInfo(filePath);
    _audioInfoCache[filePath] = info;
    return info;
  }

  /// Gets or reads WAV audio info from cache.
  Map<String, int?> _getOrReadWavInfo(String filePath) {
    if (_audioInfoCache.containsKey(filePath)) {
      return _audioInfoCache[filePath]!;
    }
    final info = _readWavInfo(filePath);
    _audioInfoCache[filePath] = info;
    return info;
  }

  /// Gets or reads ALAC audio info from cache.
  Map<String, int?> _getOrReadAlacInfo(String filePath) {
    if (_audioInfoCache.containsKey(filePath)) {
      return _audioInfoCache[filePath]!;
    }
    final info = _readAlacInfo(filePath);
    _audioInfoCache[filePath] = info;
    return info;
  }

  /// Reads both bit depth and sample rate from FLAC STREAMINFO block.
  ///
  /// FLAC STREAMINFO is located at bytes 18-21 in the file.
  /// Sample rate is stored in bits 16-35, bit depth in bits 36-40.
  /// Opens the file once and reads all necessary data.
  Map<String, int?> _readFlacInfo(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return {'bitDepth': null, 'sampleRate': null};
      }

      raf = file.openSync();

      // Check file size
      if (raf.lengthSync() < 42) {
        return {'bitDepth': null, 'sampleRate': null};
      }

      // Read and check FLAC signature (4 bytes)
      final signature = raf.readSync(4);
      if (signature[0] != 0x66 ||
          signature[1] != 0x4C ||
          signature[2] != 0x61 ||
          signature[3] != 0x43) {
        return {'bitDepth': null, 'sampleRate': null};
      }

      // Seek to position 18 and read 4 bytes for both sample rate and bit depth
      raf.setPositionSync(18);
      final metadataBytes = raf.readSync(4); // bytes 18, 19, 20, 21

      // Sample rate: 20 bits starting at byte 18
      // Formula: (byte18 << 12) | (byte19 << 4) | ((byte20 & 0xF0) >> 4)
      final sampleRate =
          (metadataBytes[0] << 12) |
          (metadataBytes[1] << 4) |
          ((metadataBytes[2] & 0xF0) >> 4);

      // Bits per sample: 5 bits starting at bit 4 of byte 20
      // Formula: ((byte20 & 0x01) << 4) | ((byte21 & 0xF0) >> 4)
      final bitsPerSample =
          ((metadataBytes[2] & 0x01) << 4) | ((metadataBytes[3] & 0xF0) >> 4);
      final bitDepth =
          bitsPerSample + 1; // Add 1 because it's stored as (bps - 1)

      return {'bitDepth': bitDepth, 'sampleRate': sampleRate};
    } catch (e) {
      return {'bitDepth': null, 'sampleRate': null};
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads both bit depth and sample rate from WAV fmt chunk.
  ///
  /// WAV files have a RIFF header followed by fmt chunk.
  /// Bit depth is at offset 34, sample rate at offset 24.
  /// Opens the file once and reads all necessary data.
  Map<String, int?> _readWavInfo(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return {'bitDepth': null, 'sampleRate': null};
      }

      raf = file.openSync();

      // Check file size
      if (raf.lengthSync() < 44) {
        return {'bitDepth': null, 'sampleRate': null};
      }

      // Read and check RIFF signature
      final riffBytes = raf.readSync(4);
      final riffSignature = String.fromCharCodes(riffBytes);

      // Seek to WAVE signature (offset 8)
      raf.setPositionSync(8);
      final waveBytes = raf.readSync(4);
      final waveSignature = String.fromCharCodes(waveBytes);

      if (riffSignature != 'RIFF' || waveSignature != 'WAVE') {
        return {'bitDepth': null, 'sampleRate': null};
      }

      // Read sample rate (offset 24, 4 bytes)
      raf.setPositionSync(24);
      final sampleRateBytes = raf.readSync(4);
      final sampleRate =
          sampleRateBytes[0] |
          (sampleRateBytes[1] << 8) |
          (sampleRateBytes[2] << 16) |
          (sampleRateBytes[3] << 24);

      // Read bit depth (offset 34, 2 bytes)
      raf.setPositionSync(34);
      final bitDepthBytes = raf.readSync(2);
      final bitDepth = bitDepthBytes[0] | (bitDepthBytes[1] << 8);

      return {'bitDepth': bitDepth, 'sampleRate': sampleRate};
    } catch (e) {
      return {'bitDepth': null, 'sampleRate': null};
    } finally {
      raf?.closeSync();
    }
  }

  /// Reads both bit depth and sample rate from ALAC (M4A) file.
  ///
  /// ALAC files use MP4 container with alac atom.
  /// This is a simplified parser that searches for the alac atom.
  /// Opens the file once and reads all necessary data.
  Map<String, int?> _readAlacInfo(String filePath) {
    RandomAccessFile? raf;
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        return {'bitDepth': null, 'sampleRate': null};
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
            // Sample rate is at offset +32 from 'alac' (4 bytes, big-endian)
            if (i + 35 < bytesRead) {
              final bitDepth = buffer[i + 25];
              final sampleRate =
                  (buffer[i + 32] << 24) |
                  (buffer[i + 33] << 16) |
                  (buffer[i + 34] << 8) |
                  buffer[i + 35];
              return {'bitDepth': bitDepth, 'sampleRate': sampleRate};
            }
          }
        }

        position += chunkSize;
      }

      return {'bitDepth': null, 'sampleRate': null};
    } catch (e) {
      return {'bitDepth': null, 'sampleRate': null};
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
