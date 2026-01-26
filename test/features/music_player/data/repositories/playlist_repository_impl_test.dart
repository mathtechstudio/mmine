import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart'
    as db;
import 'package:mmine/features/music_player/data/datasources/playlist_data_source.dart';
import 'package:mmine/features/music_player/data/repositories/playlist_repository_impl.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'playlist_repository_impl_test.mocks.dart';

@GenerateMocks([PlaylistDataSource])
void main() {
  late PlaylistRepositoryImpl repository;
  late MockPlaylistDataSource mockPlaylistDataSource;

  setUp(() {
    mockPlaylistDataSource = MockPlaylistDataSource();
    repository = PlaylistRepositoryImpl(
      playlistDataSource: mockPlaylistDataSource,
    );
  });

  db.Playlist createMockDatabasePlaylist({
    String id = '1',
    String name = 'Test Playlist',
  }) {
    return db.Playlist(
      id: id,
      name: name,
      createdAt: DateTime(2024, 1, 1).millisecondsSinceEpoch,
      updatedAt: DateTime(2024, 1, 1).millisecondsSinceEpoch,
    );
  }

  Playlist createMockDomainPlaylist({
    String id = '1',
    String name = 'Test Playlist',
    List<String> trackIds = const [],
  }) {
    return Playlist(
      id: id,
      name: name,
      trackIds: trackIds,
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 1),
    );
  }

  group('getAllPlaylists', () {
    test('should return all playlists with track IDs', () async {
      final mockPlaylist = createMockDatabasePlaylist();
      final trackIds = ['track1', 'track2', 'track3'];

      when(
        mockPlaylistDataSource.getAllPlaylists(),
      ).thenAnswer((_) async => [mockPlaylist]);
      when(
        mockPlaylistDataSource.getPlaylistTrackIds(mockPlaylist.id),
      ).thenAnswer((_) async => trackIds);

      final result = await repository.getAllPlaylists();

      expect(result.isRight(), true);
      result.fold((_) => fail('Should not return failure'), (playlists) {
        expect(playlists.length, 1);
        expect(playlists[0].name, 'Test Playlist');
      });

      verify(mockPlaylistDataSource.getAllPlaylists()).called(1);
      verify(
        mockPlaylistDataSource.getPlaylistTrackIds(mockPlaylist.id),
      ).called(1);
    });

    test('should return empty list when no playlists exist', () async {
      when(
        mockPlaylistDataSource.getAllPlaylists(),
      ).thenAnswer((_) async => []);

      final result = await repository.getAllPlaylists();

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not return failure'),
        (playlists) => expect(playlists, isEmpty),
      );
    });

    test('should return DatabaseFailure on error', () async {
      when(
        mockPlaylistDataSource.getAllPlaylists(),
      ).thenThrow(Exception('Database error'));

      final result = await repository.getAllPlaylists();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('getPlaylistById', () {
    test('should return playlist when found', () async {
      const playlistId = '1';
      final mockPlaylist = createMockDatabasePlaylist(id: playlistId);
      final trackIds = ['track1', 'track2'];

      when(
        mockPlaylistDataSource.getPlaylistById(playlistId),
      ).thenAnswer((_) async => mockPlaylist);
      when(
        mockPlaylistDataSource.getPlaylistTrackIds(playlistId),
      ).thenAnswer((_) async => trackIds);

      final result = await repository.getPlaylistById(playlistId);

      expect(result.isRight(), true);
      result.fold((_) => fail('Should not return failure'), (playlist) {
        expect(playlist.id, playlistId);
        expect(playlist.name, 'Test Playlist');
      });
    });

    test('should return DatabaseFailure when playlist not found', () async {
      when(
        mockPlaylistDataSource.getPlaylistById(any),
      ).thenAnswer((_) async => null);

      final result = await repository.getPlaylistById('1');

      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<DatabaseFailure>());
        expect((failure as DatabaseFailure).message, contains('not found'));
      }, (_) => fail('Should return failure'));
    });
  });

  group('createPlaylist', () {
    test('should create playlist successfully', () async {
      const name = 'New Playlist';
      final mockPlaylist = createMockDatabasePlaylist(name: name);

      when(
        mockPlaylistDataSource.createPlaylist(name),
      ).thenAnswer((_) async => mockPlaylist);

      final result = await repository.createPlaylist(name);

      expect(result.isRight(), true);
      result.fold((_) => fail('Should not return failure'), (playlist) {
        expect(playlist.name, name);
      });

      verify(mockPlaylistDataSource.createPlaylist(name)).called(1);
    });

    test('should trim whitespace from playlist name', () async {
      const name = '  Trimmed Playlist  ';
      const trimmedName = 'Trimmed Playlist';
      final mockPlaylist = createMockDatabasePlaylist(name: trimmedName);

      when(
        mockPlaylistDataSource.createPlaylist(trimmedName),
      ).thenAnswer((_) async => mockPlaylist);

      final result = await repository.createPlaylist(name);

      expect(result.isRight(), true);
      verify(mockPlaylistDataSource.createPlaylist(trimmedName)).called(1);
    });

    test('should return DatabaseFailure when name is empty', () async {
      final result = await repository.createPlaylist('');

      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<DatabaseFailure>());
        expect(
          (failure as DatabaseFailure).message,
          contains('cannot be empty'),
        );
      }, (_) => fail('Should return failure'));

      verifyNever(mockPlaylistDataSource.createPlaylist(any));
    });
  });

  group('updatePlaylist', () {
    test('should update playlist successfully', () async {
      final mockDbPlaylist = createMockDatabasePlaylist();
      final domainPlaylist = createMockDomainPlaylist(name: 'Updated Name');

      when(
        mockPlaylistDataSource.getPlaylistById(domainPlaylist.id),
      ).thenAnswer((_) async => mockDbPlaylist);
      when(
        mockPlaylistDataSource.updatePlaylist(any),
      ).thenAnswer((_) async => {});

      final result = await repository.updatePlaylist(domainPlaylist);

      expect(result.isRight(), true);
      verify(
        mockPlaylistDataSource.getPlaylistById(domainPlaylist.id),
      ).called(1);
      verify(mockPlaylistDataSource.updatePlaylist(any)).called(1);
    });

    test('should return DatabaseFailure when playlist not found', () async {
      final domainPlaylist = createMockDomainPlaylist();

      when(
        mockPlaylistDataSource.getPlaylistById(domainPlaylist.id),
      ).thenAnswer((_) async => null);

      final result = await repository.updatePlaylist(domainPlaylist);

      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<DatabaseFailure>());
        expect((failure as DatabaseFailure).message, contains('not found'));
      }, (_) => fail('Should return failure'));

      verifyNever(mockPlaylistDataSource.updatePlaylist(any));
    });
  });

  group('deletePlaylist', () {
    test('should delete playlist successfully', () async {
      const playlistId = '1';
      when(
        mockPlaylistDataSource.deletePlaylist(playlistId),
      ).thenAnswer((_) async => {});

      final result = await repository.deletePlaylist(playlistId);

      expect(result.isRight(), true);
      verify(mockPlaylistDataSource.deletePlaylist(playlistId)).called(1);
    });

    test('should return DatabaseFailure on error', () async {
      when(
        mockPlaylistDataSource.deletePlaylist(any),
      ).thenThrow(Exception('Database error'));

      final result = await repository.deletePlaylist('1');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('addTrackToPlaylist', () {
    test('should add track to playlist successfully', () async {
      const playlistId = '1';
      const trackId = 'track1';

      when(
        mockPlaylistDataSource.addTrackToPlaylist(playlistId, trackId),
      ).thenAnswer((_) async => {});

      final result = await repository.addTrackToPlaylist(playlistId, trackId);

      expect(result.isRight(), true);
      verify(
        mockPlaylistDataSource.addTrackToPlaylist(playlistId, trackId),
      ).called(1);
    });

    test('should return DatabaseFailure on error', () async {
      when(
        mockPlaylistDataSource.addTrackToPlaylist(any, any),
      ).thenThrow(Exception('Database error'));

      final result = await repository.addTrackToPlaylist('1', 'track1');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('removeTrackFromPlaylist', () {
    test('should remove track from playlist successfully', () async {
      const playlistId = '1';
      const trackId = 'track1';

      when(
        mockPlaylistDataSource.removeTrackFromPlaylist(playlistId, trackId),
      ).thenAnswer((_) async => {});

      final result = await repository.removeTrackFromPlaylist(
        playlistId,
        trackId,
      );

      expect(result.isRight(), true);
      verify(
        mockPlaylistDataSource.removeTrackFromPlaylist(playlistId, trackId),
      ).called(1);
    });

    test('should return DatabaseFailure on error', () async {
      when(
        mockPlaylistDataSource.removeTrackFromPlaylist(any, any),
      ).thenThrow(Exception('Database error'));

      final result = await repository.removeTrackFromPlaylist('1', 'track1');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });

  group('reorderPlaylistTracks', () {
    test('should reorder tracks successfully', () async {
      const playlistId = '1';
      const oldIndex = 0;
      const newIndex = 2;

      when(
        mockPlaylistDataSource.reorderPlaylistTracks(
          playlistId,
          oldIndex,
          newIndex,
        ),
      ).thenAnswer((_) async => {});

      final result = await repository.reorderPlaylistTracks(
        playlistId,
        oldIndex,
        newIndex,
      );

      expect(result.isRight(), true);
      verify(
        mockPlaylistDataSource.reorderPlaylistTracks(
          playlistId,
          oldIndex,
          newIndex,
        ),
      ).called(1);
    });

    test('should return DatabaseFailure on error', () async {
      when(
        mockPlaylistDataSource.reorderPlaylistTracks(any, any, any),
      ).thenThrow(Exception('Database error'));

      final result = await repository.reorderPlaylistTracks('1', 0, 2);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });
}
