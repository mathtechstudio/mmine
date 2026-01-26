import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for adding tracks to play immediately after the current track.
///
/// This use case inserts one or more tracks at the front of the queue,
/// right after the currently playing track. This is useful for "play next"
/// functionality where users want to prioritize certain tracks.
///
/// Parameters:
/// - [tracks]: List of [AudioTrack] objects to play next
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = PlayNextUseCase(repository);
/// final result = await useCase([track1, track2]);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Tracks will play next'),
/// );
/// ```
class PlayNextUseCase implements UseCase<void, List<AudioTrack>> {
  final PlaybackRepository repository;

  PlayNextUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(List<AudioTrack> tracks) async {
    return await repository.playNext(tracks);
  }
}
