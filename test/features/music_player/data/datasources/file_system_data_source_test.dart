
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/data/datasources/file_system_data_source.dart';

void main() {
  late FileSystemDataSource dataSource;

  setUp(() {
    dataSource = FileSystemDataSource();
  });

  group('scanDirectory', () {
    test('should throw exception when directory does not exist', () async {
      // Arrange
      const nonExistentPath = '/non/existent/path';

      // Act & Assert
      expect(() => dataSource.scanDirectory(nonExistentPath), throwsException);
    });
  });

  group('validateAudioFormat', () {
    test('should return false for non-existent file', () async {
      // Arrange
      const nonExistentFile = '/non/existent/file.flac';

      // Act
      final result = await dataSource.validateAudioFormat(nonExistentFile);

      // Assert
      expect(result, false);
    });

    test('should return false for unsupported extension', () async {
      // Arrange
      const unsupportedFile = '/path/to/file.mp3';

      // Act
      final result = await dataSource.validateAudioFormat(unsupportedFile);

      // Assert
      expect(result, false);
    });
  });

  group('getFileSize', () {
    test('should throw exception for non-existent file', () async {
      // Arrange
      const nonExistentFile = '/non/existent/file.flac';

      // Act & Assert
      expect(() => dataSource.getFileSize(nonExistentFile), throwsException);
    });
  });

  group('getDateAdded', () {
    test('should throw exception for non-existent file', () async {
      // Arrange
      const nonExistentFile = '/non/existent/file.flac';

      // Act & Assert
      expect(() => dataSource.getDateAdded(nonExistentFile), throwsException);
    });
  });
}
