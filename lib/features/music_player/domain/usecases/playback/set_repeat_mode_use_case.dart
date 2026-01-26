import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for setting the repeat mode for playback.
///
/// This use case controls how the player behaves when reaching the end of
/// the queue or a track.
///
/// Parameters:
/// - [mode]: The desired [RepeatMode]:
///   - [RepeatMode.off]: No repeat, stop at end of queue
///   - [RepeatMode.all]: Repeat entire queue
///   - [RepeatMode.one]: Repeat current track
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = SetRepeatModeUseCase(repository);
/// final result = await useCase(RepeatMode.all);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Repeat mode set to all'),
/// );
/// ```
class SetRepeatModeUseCase implements UseCase<void, RepeatMode> {
  final PlaybackRepository repository;

  SetRepeatModeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RepeatMode mode) async {
    return await repository.setRepeatMode(mode);
  }
}
