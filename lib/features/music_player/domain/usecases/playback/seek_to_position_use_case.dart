import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for seeking to a specific position in the current track.
///
/// This use case allows jumping to any position within the currently playing
/// audio track. The position must be within the track's duration.
///
/// Parameters:
/// - [position]: The target position as a [Duration]
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., no track playing, invalid position)
///
/// Example:
/// ```dart
/// final useCase = SeekToPositionUseCase(repository);
/// final result = await useCase(Duration(seconds: 30));
/// result.fold(
///   (failure) => print('Seek failed: $failure'),
///   (_) => print('Seeked to 30 seconds'),
/// );
/// ```
class SeekToPositionUseCase {
  final PlaybackRepository repository;

  SeekToPositionUseCase(this.repository);

  Future<Either<Failure, void>> call(Duration position) async {
    return await repository.seekTo(position);
  }
}
