import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class SkipToPreviousUseCase implements UseCase<void, NoParams> {
  final PlaybackRepository repository;

  SkipToPreviousUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.skipToPrevious();
  }
}
