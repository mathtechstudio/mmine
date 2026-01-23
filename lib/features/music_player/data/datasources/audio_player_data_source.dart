import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmine/features/music_player/data/datasources/audio_service_handler.dart';

class AudioPlayerDataSource {
  final AudioPlayer _player;
  AudioServiceHandler? _audioServiceHandler;

  AudioPlayerDataSource() : _player = AudioPlayer() {
    unawaited(_configureAudioSession());
  }

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

  Future<void> play(String filePath) async {
    await _player.setFilePath(filePath);
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed.clamp(0.5, 2.0));
  }

  Future<void> setPlaylist(List<String> filePaths, int startIndex) async {
    final audioSources = filePaths
        .map((path) => AudioSource.file(path))
        .toList();
    // ignore: deprecated_member_use
    await _player.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
      initialIndex: startIndex,
    );
  }

  AudioServiceHandler? get audioServiceHandler => _audioServiceHandler;

  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
  }

  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
  }

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Stream<bool> get playingStream => _player.playingStream;

  Stream<int?> get currentIndexStream => _player.currentIndexStream;

  bool get isPlaying => _player.playing;

  Duration get currentPosition => _player.position;

  Duration? get duration => _player.duration;

  int? get currentIndex => _player.currentIndex;

  double get volume => _player.volume;

  double get speed => _player.speed;

  bool get hasNext => _player.hasNext;

  bool get hasPrevious => _player.hasPrevious;

  Future<void> dispose() async {
    await _player.dispose();
  }
}
