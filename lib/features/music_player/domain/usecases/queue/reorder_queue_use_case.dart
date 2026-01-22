import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class ReorderQueueUseCase implements UseCase<void, ReorderQueueParams> {
  final PlaybackRepository repository;

  ReorderQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ReorderQueueParams params) async {
    return await repository.reorderQueue(params.oldIndex, params.newIndex);
  }
}

class ReorderQueueParams {
  final int oldIndex;
  final int newIndex;

  const ReorderQueueParams({required this.oldIndex, required this.newIndex});
}
