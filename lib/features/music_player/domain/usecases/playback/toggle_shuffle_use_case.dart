import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class ToggleShuffleUseCase implements UseCase<void, bool> {
  final PlaybackRepository repository;

  ToggleShuffleUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(bool enabled) async {
    return await repository.setShuffleEnabled(enabled);
  }
}
