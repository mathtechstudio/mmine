import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Use case for removing a track from a playlist.
///
/// This use case removes a specific track from a playlist. After removal,
/// the remaining tracks are automatically reordered to maintain sequential
/// positions.
///
/// Parameters:
/// - [params]: [RemoveTrackFromPlaylistParams] containing:
///   - playlistId: The ID of the playlist
///   - trackId: The ID of the track to remove
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., playlist or track not found)
///
/// Example:
/// ```dart
/// final useCase = RemoveTrackFromPlaylistUseCase(repository);
/// final params = RemoveTrackFromPlaylistParams(
///   playlistId: 'playlist-123',
///   trackId: 'track-456',
/// );
/// final result = await useCase(params);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Track removed'),
/// );
/// ```
class RemoveTrackFromPlaylistUseCase
    implements UseCase<void, RemoveTrackFromPlaylistParams> {
  final PlaylistRepository repository;

  RemoveTrackFromPlaylistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
    RemoveTrackFromPlaylistParams params,
  ) async {
    return await repository.removeTrackFromPlaylist(
      params.playlistId,
      params.trackId,
    );
  }
}

/// Parameters for removing a track from a playlist.
///
/// Contains the playlist ID and track ID needed to identify which track
/// to remove from which playlist.
class RemoveTrackFromPlaylistParams {
  final String playlistId;
  final String trackId;

  const RemoveTrackFromPlaylistParams({
    required this.playlistId,
    required this.trackId,
  });
}
