import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for toggling shuffle mode on or off.
///
/// This use case enables or disables shuffle mode for the playback queue.
/// When shuffle is enabled, tracks are played in random order instead of
/// sequential order.
///
/// Parameters:
/// - [enabled]: true to enable shuffle, false to disable
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = ToggleShuffleUseCase(repository);
/// final result = await useCase(true);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Shuffle enabled'),
/// );
/// ```
class ToggleShuffleUseCase implements UseCase<void, bool> {
  final PlaybackRepository repository;

  ToggleShuffleUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(bool enabled) async {
    return await repository.setShuffleEnabled(enabled);
  }
}
