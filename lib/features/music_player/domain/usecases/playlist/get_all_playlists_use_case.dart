import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

class GetAllPlaylistsUseCase implements UseCase<List<Playlist>, NoParams> {
  final PlaylistRepository repository;

  GetAllPlaylistsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Playlist>>> call(NoParams params) async {
    return await repository.getAllPlaylists();
  }
}
