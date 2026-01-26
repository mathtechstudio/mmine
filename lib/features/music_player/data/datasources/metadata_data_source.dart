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
      debugPrint('Extracting metadata from: $filePath');

      final file = File(filePath);
      final metadata = readMetadata(file, getImage: true);

      debugPrint(
        'Metadata - Title: ${metadata.title}, Artist: ${metadata.artist}, Duration: ${metadata.duration}',
      );

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
      debugPrint('ERROR extracting metadata from $filePath: $e');
      return _getDefaultMetadata(filePath);
    }
  }

  /// Extracts bit depth from file metadata.
  ///
  /// Attempts to determine the bit depth based on file extension and metadata.
  /// For FLAC files, reads the STREAMINFO block to get actual bit depth.
  /// Returns a default value based on the audio format for other formats.
  int _extractBitDepth(String filePath, AudioMetadata metadata) {
    final extension = p.extension(filePath).toLowerCase();
    debugPrint('Extracting bit depth for: $filePath (extension: $extension)');

    // For FLAC files, try to read from STREAMINFO block
    if (extension == '.flac') {
      try {
        final bitDepth = _readFlacBitDepth(filePath);
        debugPrint('FLAC bit depth read result: $bitDepth');
        if (bitDepth != null) {
          debugPrint('Using FLAC bit depth: $bitDepth');
          return bitDepth;
        }
      } catch (e) {
        debugPrint('Error reading FLAC bit depth: $e');
      }
      debugPrint('Using default FLAC bit depth: 24');
      return 24; // Default assumption for FLAC
    } else if (extension == '.wav') {
      return 16; // Default assumption for WAV
    } else if (extension == '.m4a') {
      return 16; // Default assumption for ALAC
    }

    return 16; // Default fallback
  }

  /// Extracts sample rate from metadata.
  ///
  /// For FLAC files, reads the STREAMINFO block to get actual sample rate.
  /// Returns 44100 Hz (CD quality) as the default if not available.
  int _extractSampleRate(String filePath, AudioMetadata metadata) {
    final extension = p.extension(filePath).toLowerCase();
    debugPrint('Extracting sample rate for: $filePath (extension: $extension)');

    // For FLAC files, try to read from STREAMINFO block
    if (extension == '.flac') {
      try {
        final sampleRate = _readFlacSampleRate(filePath);
        debugPrint('FLAC sample rate read result: $sampleRate');
        if (sampleRate != null) {
          debugPrint('Using FLAC sample rate: $sampleRate Hz');
          return sampleRate;
        }
      } catch (e) {
        debugPrint('Error reading FLAC sample rate: $e');
      }
    }

    debugPrint('Using default sample rate: 44100 Hz');
    return 44100; // Default fallback
  }

  /// Reads bit depth from FLAC STREAMINFO block.
  ///
  /// FLAC STREAMINFO is located at bytes 18-21 in the file.
  /// Bit depth is stored in bits 36-40 of the STREAMINFO block.
  int? _readFlacBitDepth(String filePath) {
    try {
      debugPrint('Reading FLAC bit depth from: $filePath');
      final file = File(filePath);

      if (!file.existsSync()) {
        debugPrint('File does not exist: $filePath');
        return null;
      }

      final bytes = file.readAsBytesSync();
      debugPrint('File size: ${bytes.length} bytes');

      // Check FLAC signature
      if (bytes.length < 42) {
        debugPrint('File too small for FLAC: ${bytes.length} bytes');
        return null;
      }

      final signature = String.fromCharCodes(bytes.sublist(0, 4));
      debugPrint('File signature: $signature (expected: fLaC)');

      if (bytes[0] != 0x66 ||
          bytes[1] != 0x4C ||
          bytes[2] != 0x61 ||
          bytes[3] != 0x43) {
        debugPrint('Invalid FLAC signature');
        return null;
      }

      // STREAMINFO block starts at byte 8
      // Bit depth is at bytes 20-21 (bits 4-8 of byte 20)
      final byte20 = bytes[20];
      final byte21 = bytes[21];

      debugPrint(
        'Byte 20: 0x${byte20.toRadixString(16)}, Byte 21: 0x${byte21.toRadixString(16)}',
      );

      // Bits per sample: 5 bits starting at bit 4 of byte 20
      // Formula: ((byte20 & 0x01) << 4) | ((byte21 & 0xF0) >> 4)
      final bitsPerSample = ((byte20 & 0x01) << 4) | ((byte21 & 0xF0) >> 4);
      final bitDepth =
          bitsPerSample + 1; // Add 1 because it's stored as (bps - 1)

      debugPrint(
        'Calculated bit depth: $bitDepth (bitsPerSample: $bitsPerSample)',
      );

      return bitDepth;
    } catch (e) {
      debugPrint('Error reading FLAC bit depth: $e');
      return null;
    }
  }

  /// Reads sample rate from FLAC STREAMINFO block.
  ///
  /// FLAC STREAMINFO is located at bytes 18-21 in the file.R
  /// Sample rate is stored in bits 16-35 of the STREAMINFO block.
  int? _readFlacSampleRate(String filePath) {
    try {
      debugPrint('Reading FLAC sample rate from: $filePath');
      final file = File(filePath);

      if (!file.existsSync()) {
        debugPrint('File does not exist: $filePath');
        return null;
      }

      final bytes = file.readAsBytesSync();
      debugPrint('File size: ${bytes.length} bytes');

      // Check FLAC signature
      if (bytes.length < 42) {
        debugPrint('File too small for FLAC: ${bytes.length} bytes');
        return null;
      }

      final signature = String.fromCharCodes(bytes.sublist(0, 4));
      debugPrint('File signature: $signature (expected: fLaC)');

      if (bytes[0] != 0x66 ||
          bytes[1] != 0x4C ||
          bytes[2] != 0x61 ||
          bytes[3] != 0x43) {
        debugPrint('Invalid FLAC signature');
        return null;
      }

      // STREAMINFO block starts at byte 8
      // Sample rate is at bytes 18-20 (20 bits)
      final byte18 = bytes[18];
      final byte19 = bytes[19];
      final byte20 = bytes[20];

      debugPrint(
        'Byte 18: 0x${byte18.toRadixString(16)}, Byte 19: 0x${byte19.toRadixString(16)}, Byte 20: 0x${byte20.toRadixString(16)}',
      );

      // Sample rate: 20 bits starting at byte 18
      // Formula: (byte18 << 12) | (byte19 << 4) | ((byte20 & 0xF0) >> 4)
      final sampleRate =
          (byte18 << 12) | (byte19 << 4) | ((byte20 & 0xF0) >> 4);

      debugPrint('Calculated sample rate: $sampleRate Hz');

      return sampleRate;
    } catch (e) {
      debugPrint('Error reading FLAC sample rate: $e');
      return null;
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
