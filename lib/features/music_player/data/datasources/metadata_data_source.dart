import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class MetadataDataSource {
  final _uuid = const Uuid();

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

  static Future<Map<String, dynamic>> _extractMetadataInIsolate(
    String filePath,
  ) async {
    try {
      final metadata = await MetadataRetriever.fromFile(File(filePath));

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

  static int _extractSampleRate(Metadata metadata) {
    // Try to extract sample rate from metadata
    // Default to 44.1kHz if not available
    // This would need proper implementation based on the metadata structure
    return 44100; // Default fallback
  }

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
