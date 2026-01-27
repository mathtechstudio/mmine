import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/data/datasources/metadata_data_source.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

void main() {
  late MetadataDataSource dataSource;

  setUp(() {
    dataSource = MetadataDataSource();
  });

  group('extractMetadata', () {
    test('should return default metadata for non-existent file', () async {
      // Arrange
      const nonExistentFile = '/non/existent/file.flac';

      // Act
      final result = await dataSource.extractMetadata(nonExistentFile);

      // Assert
      expect(result['title'], 'file');
      expect(result['artist'], 'Unknown Artist');
      expect(result['album'], 'Unknown Album');
      expect(result['bitDepth'], 16);
      expect(result['sampleRate'], 44100);
    });
  });

  group('extractAndSaveAlbumArt', () {
    test('should return null when album art data is null', () async {
      // Arrange
      const filePath = '/path/to/file.flac';

      // Act
      final result = await dataSource.extractAndSaveAlbumArt(filePath, null);

      // Assert
      expect(result, null);
    });

    test('should return null when album art data is empty', () async {
      // Arrange
      const filePath = '/path/to/file.flac';
      final emptyData = Uint8List(0);

      // Act
      final result = await dataSource.extractAndSaveAlbumArt(
        filePath,
        emptyData,
      );

      // Assert
      expect(result, null);
    });
  });

  group('getAudioFormat', () {
    test('should return FLAC format for .flac extension', () {
      // Arrange
      const filePath = '/path/to/file.flac';

      // Act
      final result = dataSource.getAudioFormat(filePath);

      // Assert
      expect(result, AudioFormat.flac);
    });

    test('should return WAV format for .wav extension', () {
      // Arrange
      const filePath = '/path/to/file.wav';

      // Act
      final result = dataSource.getAudioFormat(filePath);

      // Assert
      expect(result, AudioFormat.wav);
    });

    test('should return ALAC format for .m4a extension', () {
      // Arrange
      const filePath = '/path/to/file.m4a';

      // Act
      final result = dataSource.getAudioFormat(filePath);

      // Assert
      expect(result, AudioFormat.alac);
    });

    test('should throw exception for unsupported extension', () {
      // Arrange
      const filePath = '/path/to/file.mp3';

      // Act & Assert
      expect(() => dataSource.getAudioFormat(filePath), throwsException);
    });
  });
}
