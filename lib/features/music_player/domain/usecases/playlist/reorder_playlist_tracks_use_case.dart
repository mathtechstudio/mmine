import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Use case for reordering tracks within a playlist.
///
/// This use case moves a track from one position to another within a playlist,
/// updating all affected track positions accordingly.
///
/// Parameters:
/// - [params]: [ReorderPlaylistTracksParams] containing:
///   - playlistId: The ID of the playlist
///   - oldIndex: Current position of the track (0-based)
///   - newIndex: New position for the track (0-based)
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., invalid indices)
///
/// Example:
/// ```dart
/// final useCase = ReorderPlaylistTracksUseCase(repository);
/// final params = ReorderPlaylistTracksParams(
///   playlistId: 'playlist-123',
///   oldIndex: 2,
///   newIndex: 0,
/// );
/// final result = await useCase(params);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Track moved to top'),
/// );
/// ```
class ReorderPlaylistTracksUseCase
    implements UseCase<void, ReorderPlaylistTracksParams> {
  final PlaylistRepository repository;

  ReorderPlaylistTracksUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ReorderPlaylistTracksParams params) async {
    return await repository.reorderPlaylistTracks(
      params.playlistId,
      params.oldIndex,
      params.newIndex,
    );
  }
}

/// Parameters for reordering tracks within a playlist.
///
/// Contains the playlist ID and the old and new indices for the track
/// being moved.
class ReorderPlaylistTracksParams {
  final String playlistId;
  final int oldIndex;
  final int newIndex;

  const ReorderPlaylistTracksParams({
    required this.playlistId,
    required this.oldIndex,
    required this.newIndex,
  });
}
