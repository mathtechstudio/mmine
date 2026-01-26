import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

/// Audio service handler for media notifications and lock screen controls.
///
/// This class integrates the audio player with the platform's media session,
/// enabling:
/// - Media notifications with album art and playback controls
/// - Lock screen controls
/// - Bluetooth/headset controls
/// - Android Auto and CarPlay integration
///
/// The handler automatically syncs the player state with the media session,
/// updating the notification and lock screen controls in real-time.
///
/// Example usage:
/// ```dart
/// final handler = AudioServiceHandler(audioPlayer);
/// await handler.updateQueueWithTracks(tracks, 0);
/// await handler.play();
/// ```
class AudioServiceHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;
  final _queue = <MediaItem>[];
  int _currentIndex = 0;

  /// Creates an [AudioServiceHandler] with the given audio player.
  ///
  /// Automatically initializes listeners for player state changes.
  AudioServiceHandler(this._player) {
    _init();
  }

  /// Initializes listeners for player state and position changes.
  ///
  /// Sets up:
  /// - Playback state synchronization
  /// - Media controls (play, pause, skip)
  /// - Position updates
  /// - Queue index tracking
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

  /// Updates the playback queue with the given tracks.
  ///
  /// Parameters:
  /// - [tracks]: List of audio tracks to add to the queue
  /// - [startIndex]: Index of the track to start playing (0-based)
  ///
  /// This method:
  /// 1. Clears the existing queue
  /// 2. Converts tracks to media items
  /// 3. Updates the media session queue
  /// 4. Sets the current media item
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

  /// Converts an [AudioTrack] to a [MediaItem] for the media session.
  ///
  /// The media item includes:
  /// - Track metadata (title, artist, album)
  /// - Duration
  /// - Album art URI
  /// - Audio quality information (bit depth, sample rate, format)
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

  /// Starts or resumes playback.
  ///
  /// This method is called by the media session when the user taps the play
  /// button in the notification or lock screen.
  @override
  Future<void> play() async {
    await _player.play();
  }

  /// Pauses playback.
  ///
  /// This method is called by the media session when the user taps the pause
  /// button in the notification or lock screen.
  @override
  Future<void> pause() async {
    await _player.pause();
  }

  /// Seeks to the specified position in the current track.
  ///
  /// This method is called by the media session when the user seeks using
  /// the notification or lock screen controls.
  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Skips to the next track in the queue.
  ///
  /// This method is called by the media session when the user taps the next
  /// button in the notification or lock screen.
  @override
  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
  }

  /// Skips to the previous track in the queue.
  ///
  /// This method is called by the media session when the user taps the
  /// previous button in the notification or lock screen.
  @override
  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
  }

  /// Skips to a specific track in the queue by index.
  ///
  /// This method is called by the media session when the user selects a
  /// track from the queue in the notification.
  ///
  /// Parameters:
  /// - [index]: The 0-based index of the track to skip to
  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < _queue.length) {
      await _player.seek(Duration.zero, index: index);
      _currentIndex = index;
      mediaItem.add(_queue[index]);
    }
  }

  /// Stops playback and clears the media session.
  ///
  /// This method is called by the media session when the user dismisses
  /// the notification or when the app is closed.
  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }
}
