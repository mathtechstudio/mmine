import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for resuming paused audio playback.
///
/// This use case resumes playback from the current position after it has
/// been paused. If no audio is loaded or the player is already playing,
/// this operation has no effect.
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = ResumePlaybackUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Failed to resume: $failure'),
///   (_) => print('Playback resumed'),
/// );
/// ```
class ResumePlaybackUseCase implements UseCase<void, NoParams> {
  final PlaybackRepository repository;

  ResumePlaybackUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.resume();
  }
}
