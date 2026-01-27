import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/data/datasources/file_system_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/local_database_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/metadata_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/permission_data_source.dart';
import 'package:mmine/features/music_player/data/repositories/audio_repository_impl.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'audio_repository_impl_test.mocks.dart';

@GenerateMocks([
  FileSystemDataSource,
  MetadataDataSource,
  LocalDatabaseDataSource,
  PermissionDataSource,
])
void main() {
  late AudioRepositoryImpl repository;
  late MockFileSystemDataSource mockFileSystemDataSource;
  late MockMetadataDataSource mockMetadataDataSource;
  late MockLocalDatabaseDataSource mockDatabaseDataSource;
  late MockPermissionDataSource mockPermissionDataSource;

  setUp(() {
    mockFileSystemDataSource = MockFileSystemDataSource();
    mockMetadataDataSource = MockMetadataDataSource();
    mockDatabaseDataSource = MockLocalDatabaseDataSource();
    mockPermissionDataSource = MockPermissionDataSource();

    repository = AudioRepositoryImpl(
      fileSystemDataSource: mockFileSystemDataSource,
      metadataDataSource: mockMetadataDataSource,
      databaseDataSource: mockDatabaseDataSource,
      permissionDataSource: mockPermissionDataSource,
    );
  });

  Track createMockTrack({
    String id = '1',
    String title = 'Test Song',
    String artist = 'Test Artist',
    String album = 'Test Album',
  }) {
    return Track(
      id: id,
      filePath: '/path/to/song.flac',
      title: title,
      artist: artist,
      album: album,
      albumArtist: null,
      year: null,
      genre: null,
      trackNumber: null,
      durationMs: 180000,
      format: 'FLAC',
      bitDepth: 24,
      sampleRate: 96000,
      fileSize: 1024000,
      albumArtPath: null,
      dateAdded: DateTime(2024, 1, 1).millisecondsSinceEpoch,
    );
  }

  group('scanDirectory', () {
    const testPath = '/test/path';
    final testFile = File('/test/path/song.flac');
    final testMetadata = {
      'title': 'Test Song',
      'artist': 'Test Artist',
      'album': 'Test Album',
      'albumArtist': 'Test Album Artist',
      'year': 2024,
      'genre': 'Test Genre',
      'trackNumber': 1,
      'duration': const Duration(minutes: 3),
      'bitDepth': 24,
      'sampleRate': 96000,
    };

    test('should return tracks when scanning succeeds', () async {
      // Arrange
      when(
        mockPermissionDataSource.checkStoragePermission(),
      ).thenAnswer((_) async => true);
      when(mockDatabaseDataSource.getAllTracks()).thenAnswer((_) async => []);
      when(
        mockFileSystemDataSource.scanDirectory(testPath),
      ).thenAnswer((_) async => [testFile]);
      when(
        mockFileSystemDataSource.validateAudioFormat(testFile.path),
      ).thenAnswer((_) async => true);
      when(
        mockMetadataDataSource.extractMetadata(testFile.path),
      ).thenAnswer((_) async => testMetadata);
      when(
        mockFileSystemDataSource.getFileSize(testFile.path),
      ).thenAnswer((_) async => 1024000);
      when(
        mockFileSystemDataSource.getDateAdded(testFile.path),
      ).thenAnswer((_) async => DateTime(2024, 1, 1));
      when(
        mockMetadataDataSource.getAudioFormat(testFile.path),
      ).thenReturn(AudioFormat.flac);
      when(
        mockDatabaseDataSource.insertTracks(any),
      ).thenAnswer((_) async => {});

      // Act
      final result = await repository.scanDirectory(testPath);

      // Assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not return failure'), (tracks) {
        expect(tracks.length, 1);
        expect(tracks[0].title, 'Test Song');
        expect(tracks[0].artist, 'Test Artist');
        expect(tracks[0].format, AudioFormat.flac);
      });

      verify(mockPermissionDataSource.checkStoragePermission()).called(1);
      verify(mockFileSystemDataSource.scanDirectory(testPath)).called(1);
      verify(mockDatabaseDataSource.insertTracks(any)).called(1);
    });

    test('should request permission when not granted', () async {
      // Arrange
      when(
        mockPermissionDataSource.checkStoragePermission(),
      ).thenAnswer((_) async => false);
      when(
        mockPermissionDataSource.requestStoragePermission(),
      ).thenAnswer((_) async => true);
      when(
        mockFileSystemDataSource.scanDirectory(testPath),
      ).thenAnswer((_) async => []);

      // Act
      final result = await repository.scanDirectory(testPath);

      // Assert
      expect(result.isRight(), true);
      verify(mockPermissionDataSource.checkStoragePermission()).called(1);
      verify(mockPermissionDataSource.requestStoragePermission()).called(1);
    });

    test(
      'should return PermissionDeniedFailure when permission denied',
      () async {
        // Arrange
        when(
          mockPermissionDataSource.checkStoragePermission(),
        ).thenAnswer((_) async => false);
        when(
          mockPermissionDataSource.requestStoragePermission(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await repository.scanDirectory(testPath);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<PermissionDeniedFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );

    test('should return empty list when no files found', () async {
      // Arrange
      when(
        mockPermissionDataSource.checkStoragePermission(),
      ).thenAnswer((_) async => true);
      when(
        mockFileSystemDataSource.scanDirectory(testPath),
      ).thenAnswer((_) async => []);

      // Act
      final result = await repository.scanDirectory(testPath);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (tracks) => expect(tracks, isEmpty),
      );
    });

    test('should skip invalid format files', () async {
      // Arrange
      when(
        mockPermissionDataSource.checkStoragePermission(),
      ).thenAnswer((_) async => true);
      when(mockDatabaseDataSource.getAllTracks()).thenAnswer((_) async => []);
      when(
        mockFileSystemDataSource.scanDirectory(testPath),
      ).thenAnswer((_) async => [testFile]);
      when(
        mockFileSystemDataSource.validateAudioFormat(testFile.path),
      ).thenAnswer((_) async => false);

      // Act
      final result = await repository.scanDirectory(testPath);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (tracks) => expect(tracks, isEmpty),
      );
    });

    test('should save album art when available', () async {
      // Arrange
      final albumArt = Uint8List.fromList([1, 2, 3]);
      final metadataWithArt = Map<String, dynamic>.from(testMetadata);
      metadataWithArt['albumArt'] = albumArt;

      when(
        mockPermissionDataSource.checkStoragePermission(),
      ).thenAnswer((_) async => true);
      when(mockDatabaseDataSource.getAllTracks()).thenAnswer((_) async => []);
      when(
        mockFileSystemDataSource.scanDirectory(testPath),
      ).thenAnswer((_) async => [testFile]);
      when(
        mockFileSystemDataSource.validateAudioFormat(testFile.path),
      ).thenAnswer((_) async => true);
      when(
        mockMetadataDataSource.extractMetadata(testFile.path),
      ).thenAnswer((_) async => metadataWithArt);
      when(
        mockFileSystemDataSource.getFileSize(testFile.path),
      ).thenAnswer((_) async => 1024000);
      when(
        mockFileSystemDataSource.getDateAdded(testFile.path),
      ).thenAnswer((_) async => DateTime(2024, 1, 1));
      when(
        mockMetadataDataSource.getAudioFormat(testFile.path),
      ).thenReturn(AudioFormat.flac);
      when(
        mockMetadataDataSource.extractAndSaveAlbumArt(testFile.path, any),
      ).thenAnswer((_) async => '/path/to/art.jpg');
      when(
        mockDatabaseDataSource.insertTracks(any),
      ).thenAnswer((_) async => {});

      // Act
      final result = await repository.scanDirectory(testPath);

      // Assert
      expect(result.isRight(), true);
      verify(
        mockMetadataDataSource.extractAndSaveAlbumArt(testFile.path, any),
      ).called(1);
    });

    test('should return UnknownFailure on unexpected error', () async {
      // Arrange
      when(
        mockPermissionDataSource.checkStoragePermission(),
      ).thenThrow(Exception('Unexpected error'));

      // Act
      final result = await repository.scanDirectory(testPath);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('getAllTracks', () {
    test('should return all tracks from database', () async {
      // Arrange
      final mockTrack = createMockTrack();

      when(
        mockDatabaseDataSource.getAllTracks(),
      ).thenAnswer((_) async => [mockTrack]);

      // Act
      final result = await repository.getAllTracks();

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should not return failure'), (tracks) {
        expect(tracks.length, 1);
        expect(tracks[0].title, 'Test Song');
      });
    });

    test('should return DatabaseFailure on error', () async {
      // Arrange
      when(
        mockDatabaseDataSource.getAllTracks(),
      ).thenThrow(Exception('Database error'));

      // Act
      final result = await repository.getAllTracks();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('getTracksByArtist', () {
    test('should return tracks by artist', () async {
      // Arrange
      const artist = 'Test Artist';
      final mockTrack = createMockTrack(artist: artist);

      when(
        mockDatabaseDataSource.getTracksByArtist(artist),
      ).thenAnswer((_) async => [mockTrack]);

      // Act
      final result = await repository.getTracksByArtist(artist);

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should not return failure'), (tracks) {
        expect(tracks.length, 1);
        expect(tracks[0].artist, artist);
      });
    });

    test('should return DatabaseFailure on error', () async {
      // Arrange
      when(
        mockDatabaseDataSource.getTracksByArtist(any),
      ).thenThrow(Exception('Database error'));

      // Act
      final result = await repository.getTracksByArtist('Test Artist');

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('getTracksByAlbum', () {
    test('should return tracks by album', () async {
      // Arrange
      const album = 'Test Album';
      final mockTrack = createMockTrack(album: album);

      when(
        mockDatabaseDataSource.getTracksByAlbum(album),
      ).thenAnswer((_) async => [mockTrack]);

      // Act
      final result = await repository.getTracksByAlbum(album);

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should not return failure'), (tracks) {
        expect(tracks.length, 1);
        expect(tracks[0].album, album);
      });
    });
  });

  group('getTrackById', () {
    test('should return track when found', () async {
      // Arrange
      const trackId = '1';
      final mockTrack = createMockTrack(id: trackId);

      when(
        mockDatabaseDataSource.getTrackById(trackId),
      ).thenAnswer((_) async => mockTrack);

      // Act
      final result = await repository.getTrackById(trackId);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (track) => expect(track.id, trackId),
      );
    });

    test('should return FileNotFoundFailure when track not found', () async {
      // Arrange
      when(
        mockDatabaseDataSource.getTrackById(any),
      ).thenAnswer((_) async => null);

      // Act
      final result = await repository.getTrackById('1');

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<FileNotFoundFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('getAllArtists', () {
    test('should return all artists', () async {
      // Arrange
      final artists = ['Artist 1', 'Artist 2', 'Artist 3'];
      when(
        mockDatabaseDataSource.getAllArtists(),
      ).thenAnswer((_) async => artists);

      // Act
      final result = await repository.getAllArtists();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (returnedArtists) => expect(returnedArtists, artists),
      );
    });
  });

  group('getAllAlbums', () {
    test('should return all albums', () async {
      // Arrange
      final albums = ['Album 1', 'Album 2', 'Album 3'];
      when(
        mockDatabaseDataSource.getAllAlbums(),
      ).thenAnswer((_) async => albums);

      // Act
      final result = await repository.getAllAlbums();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (returnedAlbums) => expect(returnedAlbums, albums),
      );
    });
  });

  group('searchTracks', () {
    test('should return matching tracks', () async {
      // Arrange
      const query = 'test';
      final mockTrack = createMockTrack();

      when(
        mockDatabaseDataSource.searchTracks(query),
      ).thenAnswer((_) async => [mockTrack]);

      // Act
      final result = await repository.searchTracks(query);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (tracks) => expect(tracks.length, 1),
      );
    });
  });

  group('deleteTrack', () {
    test('should delete track successfully', () async {
      // Arrange
      const trackId = '1';
      when(
        mockDatabaseDataSource.deleteTrack(trackId),
      ).thenAnswer((_) async => {});

      // Act
      final result = await repository.deleteTrack(trackId);

      // Assert
      expect(result.isRight(), true);
      verify(mockDatabaseDataSource.deleteTrack(trackId)).called(1);
    });

    test('should return DatabaseFailure on error', () async {
      // Arrange
      when(
        mockDatabaseDataSource.deleteTrack(any),
      ).thenThrow(Exception('Database error'));

      // Act
      final result = await repository.deleteTrack('1');

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('clearLibrary', () {
    test('should clear library successfully', () async {
      // Arrange
      when(mockDatabaseDataSource.clearAllTracks()).thenAnswer((_) async => {});

      // Act
      final result = await repository.clearLibrary();

      // Assert
      expect(result.isRight(), true);
      verify(mockDatabaseDataSource.clearAllTracks()).called(1);
    });

    test('should return DatabaseFailure on error', () async {
      // Arrange
      when(
        mockDatabaseDataSource.clearAllTracks(),
      ).thenThrow(Exception('Database error'));

      // Act
      final result = await repository.clearLibrary();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });
}
