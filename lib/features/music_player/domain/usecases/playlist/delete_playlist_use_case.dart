import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

class DeletePlaylistUseCase implements UseCase<void, String> {
  final PlaylistRepository repository;

  DeletePlaylistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deletePlaylist(id);
  }
}
