import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';

abstract class PlaybackRepository {
  Future<Either<Failure, void>> play(AudioTrack track);
  Future<Either<Failure, void>> pause();
  Future<Either<Failure, void>> resume();
  Future<Either<Failure, void>> stop();
  Future<Either<Failure, void>> seekTo(Duration position);
  Future<Either<Failure, void>> skipToNext();
  Future<Either<Failure, void>> skipToPrevious();
  Future<Either<Failure, void>> setVolume(double volume);
  Future<Either<Failure, void>> setSpeed(double speed);
  Future<Either<Failure, void>> setRepeatMode(RepeatMode mode);
  Future<Either<Failure, void>> setShuffleEnabled(bool enabled);
  Future<Either<Failure, void>> setQueue(
    List<AudioTrack> tracks,
    int startIndex,
  );
  Future<Either<Failure, void>> addToQueue(List<AudioTrack> tracks);
  Future<Either<Failure, void>> playNext(List<AudioTrack> tracks);
  Future<Either<Failure, void>> removeFromQueue(int index);
  Future<Either<Failure, void>> reorderQueue(int oldIndex, int newIndex);
  Future<Either<Failure, void>> clearQueue();
  Stream<PlaybackState> get playbackStateStream;
}
