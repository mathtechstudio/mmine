import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class RemoveFromQueueUseCase implements UseCase<void, int> {
  final PlaybackRepository repository;

  RemoveFromQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int index) async {
    return await repository.removeFromQueue(index);
  }
}
