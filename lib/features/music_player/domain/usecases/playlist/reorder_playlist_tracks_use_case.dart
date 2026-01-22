import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

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
