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
  /// Returns a default value based on the audio format:
  /// - FLAC: 24-bit (default assumption)
  /// - WAV: 16-bit (default assumption)
  /// - ALAC: 16-bit (default assumption)
  int _extractBitDepth(String filePath, AudioMetadata metadata) {
    final extension = p.extension(filePath).toLowerCase();

    // Try to get from metadata if available
    if (metadata is VorbisMetadata) {
      // FLAC uses Vorbis comments
      // Check if there's bit depth info in comments
      // For now, use default
    }

    // Default based on format
    if (extension == '.flac') {
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
  /// Attempts to extract the sample rate from the metadata.
  /// Returns 44100 Hz (CD quality) as the default if not available.
  int _extractSampleRate(String filePath, AudioMetadata metadata) {
    // audio_metadata_reader doesn't expose sample rate directly
    // Default to 44.1kHz
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
