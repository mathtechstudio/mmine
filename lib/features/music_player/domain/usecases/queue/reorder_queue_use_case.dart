import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for reordering tracks within the playback queue.
///
/// This use case moves a track from one position to another in the queue,
/// allowing users to customize the playback order.
///
/// Parameters:
/// - [params]: [ReorderQueueParams] containing:
///   - oldIndex: Current position of the track (0-based)
///   - newIndex: New position for the track (0-based)
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., invalid indices)
///
/// Example:
/// ```dart
/// final useCase = ReorderQueueUseCase(repository);
/// final params = ReorderQueueParams(oldIndex: 5, newIndex: 1);
/// final result = await useCase(params);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Queue reordered'),
/// );
/// ```
class ReorderQueueUseCase implements UseCase<void, ReorderQueueParams> {
  final PlaybackRepository repository;

  ReorderQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ReorderQueueParams params) async {
    return await repository.reorderQueue(params.oldIndex, params.newIndex);
  }
}

/// Parameters for reordering tracks within the playback queue.
///
/// Contains the old and new indices for the track being moved.
class ReorderQueueParams {
  final int oldIndex;
  final int newIndex;

  const ReorderQueueParams({required this.oldIndex, required this.newIndex});
}
