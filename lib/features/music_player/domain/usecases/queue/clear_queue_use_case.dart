import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for clearing the entire playback queue.
///
/// This use case removes all tracks from the playback queue and stops
/// playback. The player returns to an idle state.
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = ClearQueueUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Queue cleared'),
/// );
/// ```
class ClearQueueUseCase implements UseCase<void, NoParams> {
  final PlaybackRepository repository;

  ClearQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearQueue();
  }
}
