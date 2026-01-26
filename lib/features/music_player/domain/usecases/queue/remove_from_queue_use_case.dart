import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for removing a track from the playback queue by index.
///
/// This use case removes a specific track from the queue without affecting
/// the currently playing track (unless the removed track is currently playing).
///
/// Parameters:
/// - [index]: The 0-based index of the track to remove from the queue
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., invalid index)
///
/// Example:
/// ```dart
/// final useCase = RemoveFromQueueUseCase(repository);
/// final result = await useCase(3);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Track removed from queue'),
/// );
/// ```
class RemoveFromQueueUseCase implements UseCase<void, int> {
  final PlaybackRepository repository;

  RemoveFromQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int index) async {
    return await repository.removeFromQueue(index);
  }
}
