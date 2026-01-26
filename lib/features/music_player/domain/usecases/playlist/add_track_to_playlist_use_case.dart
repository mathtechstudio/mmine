import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Use case for adding a track to a playlist.
///
/// This use case adds a specific track to the end of a playlist. If the
/// track already exists in the playlist, it will be replaced at its
/// current position.
///
/// Parameters:
/// - [params]: [AddTrackToPlaylistParams] containing:
///   - playlistId: The ID of the playlist
///   - trackId: The ID of the track to add
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., playlist or track not found)
///
/// Example:
/// ```dart
/// final useCase = AddTrackToPlaylistUseCase(repository);
/// final params = AddTrackToPlaylistParams(
///   playlistId: 'playlist-123',
///   trackId: 'track-456',
/// );
/// final result = await useCase(params);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Track added to playlist'),
/// );
/// ```
class AddTrackToPlaylistUseCase
    implements UseCase<void, AddTrackToPlaylistParams> {
  final PlaylistRepository repository;

  AddTrackToPlaylistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTrackToPlaylistParams params) async {
    return await repository.addTrackToPlaylist(
      params.playlistId,
      params.trackId,
    );
  }
}

/// Parameters for adding a track to a playlist.
///
/// Contains the playlist ID and track ID needed to identify which track
/// to add to which playlist.
class AddTrackToPlaylistParams {
  final String playlistId;
  final String trackId;

  const AddTrackToPlaylistParams({
    required this.playlistId,
    required this.trackId,
  });
}
