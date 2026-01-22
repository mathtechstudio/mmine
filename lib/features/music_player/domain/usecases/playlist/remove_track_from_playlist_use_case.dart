import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

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

class RemoveTrackFromPlaylistParams {
  final String playlistId;
  final String trackId;

  const RemoveTrackFromPlaylistParams({
    required this.playlistId,
    required this.trackId,
  });
}
