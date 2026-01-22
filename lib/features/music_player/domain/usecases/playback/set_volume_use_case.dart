import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class SetVolumeUseCase {
  final PlaybackRepository repository;

  SetVolumeUseCase(this.repository);

  Future<Either<Failure, void>> call(double volume) async {
    return await repository.setVolume(volume);
  }
}
