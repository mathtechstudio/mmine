import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmine/features/music_player/data/datasources/audio_service_handler.dart';

/// Data source for audio playback using just_audio package.
///
/// This class provides a wrapper around the just_audio [AudioPlayer] and
/// integrates with [AudioService] for media notifications and lock screen
/// controls.
///
/// Features:
/// - High-quality audio playback (FLAC, WAV, ALAC support)
/// - Media notifications with album art
/// - Lock screen controls
/// - Background playback
/// - Gapless playback support
/// - Volume and speed control
/// - Position seeking
///
/// The data source exposes streams for:
/// - Playing state changes
/// - Position updates
/// - Duration updates
/// - Buffering state
class AudioPlayerDataSource {
  final AudioPlayer _player;
  AudioServiceHandler? _audioServiceHandler;

  /// Creates an [AudioPlayerDataSource] and initializes the audio session.
  ///
  /// Automatically configures:
  /// - Default volume (1.0)
  /// - Default speed (1.0)
  /// - Audio service for media notifications
  AudioPlayerDataSource() : _player = AudioPlayer() {
    unawaited(_configureAudioSession());
  }

  /// Configures the audio session for high-quality playback.
  ///
  /// Sets up:
  /// - Initial volume and speed
  /// - Audio service for media notifications (if supported)
  ///
  /// Audio service initialization may fail on platforms that don't support it
  /// (e.g., desktop platforms). The player will continue to work without
  /// media notifications in this case.
  Future<void> _configureAudioSession() async {
    // Configure audio session for high-quality playback
    await _player.setVolume(1.0);
    await _player.setSpeed(1.0);

    // Initialize audio service for media notifications
    try {
      _audioServiceHandler = await AudioService.init(
        builder: () => AudioServiceHandler(_player),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.example.mmine.audio',
          androidNotificationChannelName: 'Mmine Audio Playback',
          androidNotificationOngoing: true,
          androidShowNotificationBadge: true,
          androidStopForegroundOnPause: true,
        ),
      );
    } catch (e) {
      // Audio service initialization failed, continue without it
      // This can happen on platforms that don't support audio service
    }
  }

  /// Plays an audio file from the given [filePath].
  ///
  /// Loads the audio file and starts playback immediately.
  /// Throws an exception if the file cannot be loaded or played.
  Future<void> play(String filePath) async {
    await _player.setFilePath(filePath);
    await _player.play();
  }

  /// Pauses the currently playing audio.
  ///
  /// The playback position is preserved and can be resumed later.
  Future<void> pause() async {
    await _player.pause();
  }

  /// Resumes playback from the current position.
  ///
  /// If no audio is loaded, this method has no effect.
  Future<void> resume() async {
    await _player.play();
  }

  /// Stops playback and resets the player.
  ///
  /// After stopping, the player returns to the idle state.
  Future<void> stop() async {
    await _player.stop();
  }

  /// Seeks to the specified [position] in the current audio.
  ///
  /// The [position] must be within the audio duration.
  /// If the position exceeds the duration, seeks to the end.
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Sets the playback volume.
  ///
  /// The [volume] is clamped to the range [0.0, 1.0] where:
  /// - 0.0 = muted
  /// - 1.0 = maximum volume
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  /// Sets the playback speed.
  ///
  /// The [speed] is clamped to the range [0.5, 2.0] where:
  /// - 0.5 = half speed
  /// - 1.0 = normal speed
  /// - 2.0 = double speed
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed.clamp(0.5, 2.0));
  }

  /// Sets a playlist of audio files and starts at the specified index.
  ///
  /// Parameters:
  /// - [filePaths]: List of file paths to audio files
  /// - [startIndex]: Index of the track to start playing (0-based)
  ///
  /// Throws an exception if any file path is invalid or if the start index
  /// is out of bounds.
  Future<void> setPlaylist(List<String> filePaths, int startIndex) async {
    final audioSources = filePaths
        .map((path) => AudioSource.file(path))
        .toList();

    await _player.setAudioSources(audioSources, initialIndex: startIndex);
  }

  /// Gets the audio service handler for media notifications.
  ///
  /// Returns null if audio service initialization failed (e.g., on desktop).
  AudioServiceHandler? get audioServiceHandler => _audioServiceHandler;

  /// Skips to the next track in the playlist.
  ///
  /// Does nothing if there is no next track.
  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
  }

  /// Skips to the previous track in the playlist.
  ///
  /// Does nothing if there is no previous track.
  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
  }

  /// Stream of playback position updates.
  ///
  /// Emits the current position periodically during playback.
  Stream<Duration> get positionStream => _player.positionStream;

  /// Stream of audio duration updates.
  ///
  /// Emits the total duration when audio is loaded.
  /// May emit null if duration is not yet available.
  Stream<Duration?> get durationStream => _player.durationStream;

  /// Stream of playing state changes.
  ///
  /// Emits true when playing, false when paused or stopped.
  Stream<bool> get playingStream => _player.playingStream;

  /// Stream of current track index changes in the playlist.
  ///
  /// Emits the index (0-based) when the current track changes.
  /// May emit null if no playlist is loaded.
  Stream<int?> get currentIndexStream => _player.currentIndexStream;

  /// Whether audio is currently playing.
  bool get isPlaying => _player.playing;

  /// The current playback position.
  Duration get currentPosition => _player.position;

  /// The total duration of the current audio.
  ///
  /// Returns null if no audio is loaded or duration is not yet available.
  Duration? get duration => _player.duration;

  /// The index of the current track in the playlist.
  ///
  /// Returns null if no playlist is loaded.
  int? get currentIndex => _player.currentIndex;

  /// The current volume level (0.0 to 1.0).
  double get volume => _player.volume;

  /// The current playback speed (0.5 to 2.0).
  double get speed => _player.speed;

  /// Whether there is a next track in the playlist.
  bool get hasNext => _player.hasNext;

  /// Whether there is a previous track in the playlist.
  bool get hasPrevious => _player.hasPrevious;

  /// Disposes the audio player and releases resources.
  ///
  /// Should be called when the player is no longer needed.
  Future<void> dispose() async {
    await _player.dispose();
  }
}
