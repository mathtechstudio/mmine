import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for setting the playback speed.
///
/// This use case allows adjusting the playback speed without changing the
/// pitch of the audio. Useful for audiobooks or when you want to listen
/// faster/slower.
///
/// Parameters:
/// - [speed]: The playback speed multiplier (typically 0.5 to 2.0)
///   - 0.5 = half speed
///   - 1.0 = normal speed
///   - 2.0 = double speed
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails or speed is out of range
///
/// Example:
/// ```dart
/// final useCase = SetSpeedUseCase(repository);
/// final result = await useCase(1.5);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Speed set to 1.5x'),
/// );
/// ```
class SetSpeedUseCase {
  final PlaybackRepository repository;

  SetSpeedUseCase(this.repository);

  Future<Either<Failure, void>> call(double speed) async {
    return await repository.setSpeed(speed);
  }
}
