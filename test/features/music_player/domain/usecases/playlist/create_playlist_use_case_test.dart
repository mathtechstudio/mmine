import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/create_playlist_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_playlist_use_case_test.mocks.dart';

@GenerateMocks([PlaylistRepository])
void main() {
  late CreatePlaylistUseCase useCase;
  late MockPlaylistRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaylistRepository();
    useCase = CreatePlaylistUseCase(mockRepository);
  });

  final now = DateTime.now();
  final testPlaylist = Playlist(
    id: '1',
    name: 'Test Playlist',
    trackIds: [],
    createdAt: now,
    updatedAt: now,
  );

  group('CreatePlaylistUseCase', () {
    test('should create playlist successfully', () async {
      // Arrange
      when(
        mockRepository.createPlaylist(any),
      ).thenAnswer((_) async => Right(testPlaylist));

      // Act
      final result = await useCase('Test Playlist');

      // Assert
      expect(result, Right(testPlaylist));
      verify(mockRepository.createPlaylist('Test Playlist'));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when creation fails', () async {
      // Arrange
      final failure = DatabaseFailure('Failed to create playlist');
      when(
        mockRepository.createPlaylist(any),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase('Test Playlist');

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.createPlaylist('Test Playlist'));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle empty playlist name', () async {
      // Arrange
      when(
        mockRepository.createPlaylist(any),
      ).thenAnswer((_) async => Right(testPlaylist));

      // Act
      await useCase('');

      // Assert
      verify(mockRepository.createPlaylist(''));
    });
  });
}
