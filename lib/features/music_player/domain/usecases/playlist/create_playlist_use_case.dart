import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

class CreatePlaylistUseCase implements UseCase<Playlist, String> {
  final PlaylistRepository repository;

  CreatePlaylistUseCase(this.repository);

  @override
  Future<Either<Failure, Playlist>> call(String name) async {
    return await repository.createPlaylist(name);
  }
}
