import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/delete_playlist_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_playlist_use_case_test.mocks.dart';

@GenerateMocks([PlaylistRepository])
void main() {
  late DeletePlaylistUseCase useCase;
  late MockPlaylistRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaylistRepository();
    useCase = DeletePlaylistUseCase(mockRepository);
  });

  group('DeletePlaylistUseCase', () {
    test('should delete playlist successfully', () async {
      // Arrange
      const playlistId = 'playlist1';
      when(
        mockRepository.deletePlaylist(any),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(playlistId);

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.deletePlaylist(playlistId));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when deletion fails', () async {
      // Arrange
      const playlistId = 'playlist1';
      final failure = DatabaseFailure('Failed to delete playlist');
      when(
        mockRepository.deletePlaylist(any),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(playlistId);

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.deletePlaylist(playlistId));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
