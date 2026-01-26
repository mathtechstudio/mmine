import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';

/// Repository interface for managing audio playback operations.
///
/// This abstract class defines the contract for playback-related operations,
/// including play/pause controls, queue management, and playback settings.
///
/// All methods return [Either] with [Failure] on the left for errors and
/// void on the right for success.
///
/// The repository also provides a [playbackStateStream] that emits the current
/// playback state whenever it changes, allowing UI components to react to
/// playback events.
abstract class PlaybackRepository {
  /// Plays the specified [track].
  ///
  /// Starts playback of the given track. If another track is currently
  /// playing, it will be stopped first.
  Future<Either<Failure, void>> play(AudioTrack track);

  /// Pauses the current playback.
  ///
  /// The playback position is preserved and can be resumed later.
  Future<Either<Failure, void>> pause();

  /// Resumes playback from the current position.
  ///
  /// Only works if playback was previously paused.
  Future<Either<Failure, void>> resume();

  /// Stops playback and resets the player.
  ///
  /// The playback position is reset to the beginning.
  Future<Either<Failure, void>> stop();

  /// Seeks to the specified [position] in the current track.
  ///
  /// The [position] must be within the track's duration.
  Future<Either<Failure, void>> seekTo(Duration position);

  /// Skips to the next track in the queue.
  ///
  /// Behavior depends on the current repeat mode and queue state.
  Future<Either<Failure, void>> skipToNext();

  /// Skips to the previous track in the queue.
  ///
  /// If playback position is past a threshold, seeks to the beginning
  /// of the current track instead.
  Future<Either<Failure, void>> skipToPrevious();

  /// Sets the playback volume.
  ///
  /// The [volume] must be between 0.0 (muted) and 1.0 (maximum).
  Future<Either<Failure, void>> setVolume(double volume);

  /// Sets the playback speed.
  ///
  /// The [speed] is a multiplier where 1.0 is normal speed.
  /// Typical values range from 0.5 (half speed) to 2.0 (double speed).
  Future<Either<Failure, void>> setSpeed(double speed);

  /// Sets the repeat mode.
  ///
  /// See [RepeatMode] for available options.
  Future<Either<Failure, void>> setRepeatMode(RepeatMode mode);

  /// Enables or disables shuffle mode.
  ///
  /// When enabled, tracks are played in random order.
  Future<Either<Failure, void>> setShuffleEnabled(bool enabled);

  /// Sets the playback queue.
  ///
  /// Replaces the current queue with [tracks] and starts playing from
  /// [startIndex].
  Future<Either<Failure, void>> setQueue(
    List<AudioTrack> tracks,
    int startIndex,
  );

  /// Adds tracks to the end of the queue.
  ///
  /// The [tracks] are appended to the current queue.
  Future<Either<Failure, void>> addToQueue(List<AudioTrack> tracks);

  /// Adds tracks to play next.
  ///
  /// The [tracks] are inserted after the currently playing track.
  Future<Either<Failure, void>> playNext(List<AudioTrack> tracks);

  /// Removes a track from the queue.
  ///
  /// Removes the track at the specified [index] from the queue.
  Future<Either<Failure, void>> removeFromQueue(int index);

  /// Reorders tracks in the queue.
  ///
  /// Moves the track from [oldIndex] to [newIndex].
  Future<Either<Failure, void>> reorderQueue(int oldIndex, int newIndex);

  /// Clears all tracks from the queue.
  ///
  /// Stops playback and removes all tracks from the queue.
  Future<Either<Failure, void>> clearQueue();

  /// Stream of playback state changes.
  ///
  /// Emits a new [PlaybackState] whenever the playback state changes,
  /// including position updates, track changes, and setting changes.
  Stream<PlaybackState> get playbackStateStream;
}
