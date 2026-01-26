import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for pausing the currently playing audio.
///
/// This use case pauses playback while preserving the current position.
/// The playback can be resumed later from the same position using
/// [ResumePlaybackUseCase].
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., no track is playing)
///
/// Example:
/// ```dart
/// final useCase = PausePlaybackUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Failed to pause: $failure'),
///   (_) => print('Playback paused'),
/// );
/// ```
class PausePlaybackUseCase implements UseCase<void, NoParams> {
  final PlaybackRepository repository;

  PausePlaybackUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.pause();
  }
}
