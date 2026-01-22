import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/data/datasources/audio_player_data_source.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class PlaybackRepositoryImpl implements PlaybackRepository {
  final AudioPlayerDataSource audioPlayerDataSource;
  final _stateController = StreamController<PlaybackState>.broadcast();

  PlaybackState _currentState = const PlaybackState();

  PlaybackRepositoryImpl({required this.audioPlayerDataSource}) {
    _initializeStateStream();
  }

  void _initializeStateStream() {
    audioPlayerDataSource.playingStream.listen((isPlaying) {
      _updateState(_currentState.copyWith(isPlaying: isPlaying));
    });

    audioPlayerDataSource.positionStream.listen((position) {
      _updateState(_currentState.copyWith(position: position));
    });

    audioPlayerDataSource.durationStream.listen((duration) {
      if (duration != null) {
        _updateState(_currentState.copyWith(duration: duration));
      }
    });
  }

  void _updateState(PlaybackState newState) {
    _currentState = newState;
    _stateController.add(_currentState);
  }

  @override
  Future<Either<Failure, void>> play(AudioTrack track) async {
    try {
      await audioPlayerDataSource.play(track.filePath);
      _updateState(
        _currentState.copyWith(currentTrack: track, isPlaying: true),
      );
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to play track: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> pause() async {
    try {
      await audioPlayerDataSource.pause();
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to pause: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> resume() async {
    try {
      await audioPlayerDataSource.resume();
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to resume: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> stop() async {
    try {
      await audioPlayerDataSource.stop();
      _updateState(
        _currentState.copyWith(
          currentTrack: null,
          isPlaying: false,
          position: Duration.zero,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to stop: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> seekTo(Duration position) async {
    try {
      await audioPlayerDataSource.seek(position);
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to seek: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> skipToNext() async {
    try {
      if (!_currentState.hasNext) {
        return Left(PlaybackFailure('No next track in queue'));
      }
      final nextIndex = _currentState.currentIndex + 1;
      final nextTrack = _currentState.queue[nextIndex];
      await audioPlayerDataSource.play(nextTrack.filePath);
      _updateState(
        _currentState.copyWith(
          currentTrack: nextTrack,
          currentIndex: nextIndex,
          isPlaying: true,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to skip to next: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> skipToPrevious() async {
    try {
      if (!_currentState.hasPrevious) {
        return Left(PlaybackFailure('No previous track in queue'));
      }
      final previousIndex = _currentState.currentIndex - 1;
      final previousTrack = _currentState.queue[previousIndex];
      await audioPlayerDataSource.play(previousTrack.filePath);
      _updateState(
        _currentState.copyWith(
          currentTrack: previousTrack,
          currentIndex: previousIndex,
          isPlaying: true,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        PlaybackFailure('Failed to skip to previous: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setVolume(double volume) async {
    try {
      await audioPlayerDataSource.setVolume(volume);
      _updateState(_currentState.copyWith(volume: volume));
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to set volume: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> setSpeed(double speed) async {
    try {
      await audioPlayerDataSource.setSpeed(speed);
      _updateState(_currentState.copyWith(speed: speed));
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to set speed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> setRepeatMode(RepeatMode mode) async {
    try {
      _updateState(_currentState.copyWith(repeatMode: mode));
      return const Right(null);
    } catch (e) {
      return Left(
        PlaybackFailure('Failed to set repeat mode: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setShuffleEnabled(bool enabled) async {
    try {
      _updateState(_currentState.copyWith(shuffleEnabled: enabled));
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to set shuffle: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> setQueue(
    List<AudioTrack> tracks,
    int startIndex,
  ) async {
    try {
      if (tracks.isEmpty) {
        return Left(PlaybackFailure('Queue cannot be empty'));
      }
      if (startIndex < 0 || startIndex >= tracks.length) {
        return Left(PlaybackFailure('Invalid start index'));
      }
      final startTrack = tracks[startIndex];
      await audioPlayerDataSource.play(startTrack.filePath);
      _updateState(
        _currentState.copyWith(
          queue: tracks,
          currentIndex: startIndex,
          currentTrack: startTrack,
          isPlaying: true,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to set queue: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> addToQueue(List<AudioTrack> tracks) async {
    try {
      if (tracks.isEmpty) {
        return Left(PlaybackFailure('Cannot add empty list to queue'));
      }
      final updatedQueue = List<AudioTrack>.from(_currentState.queue)
        ..addAll(tracks);
      _updateState(_currentState.copyWith(queue: updatedQueue));
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to add to queue: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> playNext(List<AudioTrack> tracks) async {
    try {
      if (tracks.isEmpty) {
        return Left(PlaybackFailure('Cannot add empty list to play next'));
      }
      final updatedQueue = List<AudioTrack>.from(_currentState.queue);
      final insertIndex = _currentState.currentIndex + 1;
      updatedQueue.insertAll(insertIndex, tracks);
      _updateState(_currentState.copyWith(queue: updatedQueue));
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to play next: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromQueue(int index) async {
    try {
      if (index < 0 || index >= _currentState.queue.length) {
        return Left(PlaybackFailure('Invalid queue index'));
      }
      if (index == _currentState.currentIndex) {
        return Left(PlaybackFailure('Cannot remove currently playing track'));
      }
      final updatedQueue = List<AudioTrack>.from(_currentState.queue)
        ..removeAt(index);
      var newCurrentIndex = _currentState.currentIndex;
      if (index < _currentState.currentIndex) {
        newCurrentIndex--;
      }
      _updateState(
        _currentState.copyWith(
          queue: updatedQueue,
          currentIndex: newCurrentIndex,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        PlaybackFailure('Failed to remove from queue: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reorderQueue(int oldIndex, int newIndex) async {
    try {
      if (oldIndex < 0 || oldIndex >= _currentState.queue.length) {
        return Left(PlaybackFailure('Invalid old index'));
      }
      if (newIndex < 0 || newIndex >= _currentState.queue.length) {
        return Left(PlaybackFailure('Invalid new index'));
      }
      if (oldIndex == _currentState.currentIndex ||
          newIndex == _currentState.currentIndex) {
        return Left(PlaybackFailure('Cannot reorder currently playing track'));
      }
      final updatedQueue = List<AudioTrack>.from(_currentState.queue);
      final track = updatedQueue.removeAt(oldIndex);
      updatedQueue.insert(newIndex, track);
      var newCurrentIndex = _currentState.currentIndex;
      if (oldIndex < _currentState.currentIndex &&
          newIndex >= _currentState.currentIndex) {
        newCurrentIndex--;
      } else if (oldIndex > _currentState.currentIndex &&
          newIndex <= _currentState.currentIndex) {
        newCurrentIndex++;
      }
      _updateState(
        _currentState.copyWith(
          queue: updatedQueue,
          currentIndex: newCurrentIndex,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to reorder queue: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearQueue() async {
    try {
      await stop();
      _updateState(
        _currentState.copyWith(
          queue: const [],
          currentIndex: 0,
          currentTrack: null,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(PlaybackFailure('Failed to clear queue: ${e.toString()}'));
    }
  }

  @override
  Stream<PlaybackState> get playbackStateStream => _stateController.stream;

  Future<void> dispose() async {
    await _stateController.close();
    await audioPlayerDataSource.dispose();
  }
}
