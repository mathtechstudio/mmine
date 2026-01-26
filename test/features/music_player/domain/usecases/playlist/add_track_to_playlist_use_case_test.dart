import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/add_track_to_playlist_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_track_to_playlist_use_case_test.mocks.dart';

@GenerateMocks([PlaylistRepository])
void main() {
  late AddTrackToPlaylistUseCase useCase;
  late MockPlaylistRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaylistRepository();
    useCase = AddTrackToPlaylistUseCase(mockRepository);
  });

  group('AddTrackToPlaylistUseCase', () {
    test('should add track to playlist successfully', () async {
      // Arrange
      const playlistId = 'playlist1';
      const trackId = 'track1';
      when(
        mockRepository.addTrackToPlaylist(any, any),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(
        AddTrackToPlaylistParams(playlistId: playlistId, trackId: trackId),
      );

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.addTrackToPlaylist(playlistId, trackId));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when adding track fails', () async {
      // Arrange
      const playlistId = 'playlist1';
      const trackId = 'track1';
      final failure = DatabaseFailure('Failed to add track');
      when(
        mockRepository.addTrackToPlaylist(any, any),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(
        AddTrackToPlaylistParams(playlistId: playlistId, trackId: trackId),
      );

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.addTrackToPlaylist(playlistId, trackId));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
