import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

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

class AddTrackToPlaylistParams {
  final String playlistId;
  final String trackId;

  const AddTrackToPlaylistParams({
    required this.playlistId,
    required this.trackId,
  });
}
