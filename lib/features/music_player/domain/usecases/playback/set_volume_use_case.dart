import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for setting the playback volume.
///
/// This use case controls the audio output volume level.
///
/// Parameters:
/// - [volume]: The volume level (0.0 to 1.0)
///   - 0.0 = muted
///   - 0.5 = half volume
///   - 1.0 = maximum volume
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails or volume is out of range
///
/// Example:
/// ```dart
/// final useCase = SetVolumeUseCase(repository);
/// final result = await useCase(0.7);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Volume set to 70%'),
/// );
/// ```
class SetVolumeUseCase {
  final PlaybackRepository repository;

  SetVolumeUseCase(this.repository);

  Future<Either<Failure, void>> call(double volume) async {
    return await repository.setVolume(volume);
  }
}
