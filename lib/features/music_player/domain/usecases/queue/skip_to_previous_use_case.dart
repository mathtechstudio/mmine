import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for skipping to the previous track in the queue.
///
/// This use case returns playback to the previous track in the queue.
/// If playback has progressed beyond a few seconds, it may restart the
/// current track instead of going to the previous one (platform-dependent).
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = SkipToPreviousUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Skipped to previous track'),
/// );
/// ```
class SkipToPreviousUseCase implements UseCase<void, NoParams> {
  final PlaybackRepository repository;

  SkipToPreviousUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.skipToPrevious();
  }
}
