import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class SetSpeedUseCase {
  final PlaybackRepository repository;

  SetSpeedUseCase(this.repository);

  Future<Either<Failure, void>> call(double speed) async {
    return await repository.setSpeed(speed);
  }
}
