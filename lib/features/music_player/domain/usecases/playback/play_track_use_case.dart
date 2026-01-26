import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for playing an audio track.
///
/// This use case handles the business logic for starting playback of a
/// specific audio track. It delegates the actual playback implementation
/// to the [PlaybackRepository].
///
/// Example usage:
/// ```dart
/// final result = await playTrackUseCase(audioTrack);
/// result.fold(
///   (failure) => print('Failed to play track: $failure'),
///   (_) => print('Track started playing'),
/// );
/// ```
class PlayTrackUseCase {
  final PlaybackRepository repository;

  /// Creates a [PlayTrackUseCase] with the given [repository].
  PlayTrackUseCase(this.repository);

  /// Plays the specified [track].
  ///
  /// Returns [Right] with void on success, or [Left] with a [Failure]
  /// if playback fails.
  Future<Either<Failure, void>> call(AudioTrack track) async {
    return await repository.play(track);
  }
}
