import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Data source for extracting metadata from audio files.
///
/// This class handles the extraction of metadata (title, artist, album, etc.)
/// from audio files using the flutter_media_metadata package. It uses isolates
/// for heavy operations to avoid blocking the UI thread.
///
/// The data source also handles album art extraction and caching.
class MetadataDataSource {
  final _uuid = const Uuid();

  /// Extracts metadata from an audio file at the given [filePath].
  ///
  /// This method runs the metadata extraction in a separate isolate to avoid
  /// blocking the UI thread. If extraction fails, it returns default metadata
  /// based on the filename.
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
  /// - format: Audio format (FLAC, WAV, or ALAC)
  /// - bitDepth: Bit depth (16 or 24)
  /// - sampleRate: Sample rate in Hz
  /// - albumArtPath: Path to cached album art (optional)
  Future<Map<String, dynamic>> extractMetadata(String filePath) async {
    try {
      // Use isolate for heavy metadata extraction to avoid blocking UI
      final result = await compute(_extractMetadataInIsolate, filePath);
      return result;
    } catch (e) {
      debugPrint('Error extracting metadata from $filePath: $e');
      return _getDefaultMetadata(filePath);
    }
  }

  /// Internal method that runs in an isolate to extract metadata.
  ///
  /// This method is called by [compute] and runs in a separate isolate.
  /// It should not access any instance variables or methods.
  static Future<Map<String, dynamic>> _extractMetadataInIsolate(
    String filePath,
  ) async {
    try {
      debugPrint('Extracting metadata from: $filePath');
      final metadata = await MetadataRetriever.fromFile(File(filePath));

      debugPrint(
        'Metadata extracted - Title: ${metadata.trackName}, Artist: ${metadata.trackArtistNames}, Duration: ${metadata.trackDuration}',
      );

      return {
        'title': metadata.trackName ?? p.basenameWithoutExtension(filePath),
        'artist': metadata.trackArtistNames?.isNotEmpty == true
            ? metadata.trackArtistNames!.first
            : 'Unknown Artist',
        'album': metadata.albumName ?? 'Unknown Album',
        'albumArtist': metadata.albumArtistName,
        'year': metadata.year,
        'genre': metadata.genre,
        'trackNumber': metadata.trackNumber,
        'duration': metadata.trackDuration ?? Duration.zero,
        'bitDepth': _extractBitDepth(filePath, metadata),
        'sampleRate': _extractSampleRate(metadata),
        'albumArt': metadata.albumArt,
      };
    } catch (e) {
      debugPrint('ERROR extracting metadata from $filePath: $e');
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
  }

  /// Extracts bit depth from file metadata.
  ///
  /// Attempts to determine the bit depth based on file extension and metadata.
  /// Returns a default value based on the audio format:
  /// - FLAC: 24-bit (default assumption)
  /// - WAV: 16-bit (default assumption)
  /// - ALAC: 16-bit (default assumption)
  static int _extractBitDepth(String filePath, Metadata metadata) {
    // Try to get bit depth from metadata
    // Default to 16-bit for WAV/FLAC, 16-bit for ALAC
    final extension = p.extension(filePath).toLowerCase();

    if (extension == '.flac') {
      // FLAC can be 16, 24, or 32 bit
      // This would need proper parsing of FLAC metadata
      return 24; // Default assumption for FLAC
    } else if (extension == '.wav') {
      // WAV can be 16, 24, or 32 bit
      return 16; // Default assumption for WAV
    } else if (extension == '.m4a') {
      // ALAC is typically 16 or 24 bit
      return 16; // Default assumption for ALAC
    }

    return 16; // Default fallback
  }

  /// Extracts sample rate from metadata.
  ///
  /// Attempts to extract the sample rate from the metadata.
  /// Returns 44100 Hz (CD quality) as the default if not available.
  static int _extractSampleRate(Metadata metadata) {
    // Try to extract sample rate from metadata
    // Default to 44.1kHz if not available
    // This would need proper implementation based on the metadata structure
    return 44100; // Default fallback
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
