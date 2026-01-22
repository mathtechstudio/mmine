import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class SeekToPositionUseCase {
  final PlaybackRepository repository;

  SeekToPositionUseCase(this.repository);

  Future<Either<Failure, void>> call(Duration position) async {
    return await repository.seekTo(position);
  }
}
