import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for skipping to the next track in the queue.
///
/// This use case advances playback to the next track in the queue.
/// If there is no next track, playback behavior depends on the repeat mode:
/// - RepeatMode.off: Playback stops
/// - RepeatMode.all: Returns to the first track
/// - RepeatMode.one: Restarts the current track
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = SkipToNextUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Skipped to next track'),
/// );
/// ```
class SkipToNextUseCase implements UseCase<void, NoParams> {
  final PlaybackRepository repository;

  SkipToNextUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.skipToNext();
  }
}
