import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for setting the playback queue.
///
/// This use case replaces the current playback queue with a new list of
/// tracks and optionally starts playing from a specific index.
///
/// This is typically used when:
/// - Playing an album or playlist
/// - Starting playback from a search result
/// - Replacing the queue with a new selection
///
/// Example usage:
/// ```dart
/// final params = SetQueueParams(
///   tracks: albumTracks,
///   startIndex: 0,
/// );
/// final result = await setQueueUseCase(params);
/// ```
class SetQueueUseCase implements UseCase<void, SetQueueParams> {
  final PlaybackRepository repository;

  /// Creates a [SetQueueUseCase] with the given [repository].
  SetQueueUseCase(this.repository);

  /// Sets the playback queue with the given [params].
  ///
  /// Returns [Right] with void on success, or [Left] with a [Failure]
  /// if the operation fails.
  @override
  Future<Either<Failure, void>> call(SetQueueParams params) async {
    return await repository.setQueue(params.tracks, params.startIndex);
  }
}

/// Parameters for [SetQueueUseCase].
///
/// Contains the list of tracks to set as the queue and the index
/// of the track to start playing from.
class SetQueueParams {
  /// The list of tracks to set as the playback queue.
  final List<AudioTrack> tracks;

  /// The index of the track to start playing from (0-based).
  final int startIndex;

  /// Creates [SetQueueParams] with the given [tracks] and [startIndex].
  const SetQueueParams({required this.tracks, required this.startIndex});
}
