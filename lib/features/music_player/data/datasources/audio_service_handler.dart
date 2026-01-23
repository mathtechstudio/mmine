import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

class AudioServiceHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;
  final _queue = <MediaItem>[];
  int _currentIndex = 0;

  AudioServiceHandler(this._player) {
    _init();
  }

  void _init() {
    // Listen to player state changes
    _player.playbackEventStream.listen((event) {
      final playing = _player.playing;
      playbackState.add(
        playbackState.value.copyWith(
          controls: [
            MediaControl.skipToPrevious,
            if (playing) MediaControl.pause else MediaControl.play,
            MediaControl.skipToNext,
          ],
          systemActions: const {
            MediaAction.seek,
            MediaAction.seekForward,
            MediaAction.seekBackward,
          },
          androidCompactActionIndices: const [0, 1, 2],
          processingState: const {
            ProcessingState.idle: AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
          playing: playing,
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
          queueIndex: _currentIndex,
        ),
      );
    });

    // Listen to position changes
    _player.positionStream.listen((position) {
      playbackState.add(playbackState.value.copyWith(updatePosition: position));
    });

    // Listen to current index changes
    _player.currentIndexStream.listen((index) {
      if (index != null && index < _queue.length) {
        _currentIndex = index;
        mediaItem.add(_queue[index]);
      }
    });
  }

  Future<void> updateQueueWithTracks(
    List<AudioTrack> tracks,
    int startIndex,
  ) async {
    _queue.clear();
    _queue.addAll(tracks.map(_trackToMediaItem));
    _currentIndex = startIndex;

    queue.add(_queue);
    if (_queue.isNotEmpty && startIndex < _queue.length) {
      mediaItem.add(_queue[startIndex]);
    }
  }

  MediaItem _trackToMediaItem(AudioTrack track) {
    return MediaItem(
      id: track.id,
      album: track.album,
      title: track.title,
      artist: track.artist,
      duration: track.duration,
      artUri: track.albumArtPath != null ? Uri.file(track.albumArtPath!) : null,
      extras: {
        'bitDepth': track.bitDepth,
        'sampleRate': track.sampleRate,
        'format': track.format.name,
      },
    );
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < _queue.length) {
      await _player.seek(Duration.zero, index: index);
      _currentIndex = index;
      mediaItem.add(_queue[index]);
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }
}
