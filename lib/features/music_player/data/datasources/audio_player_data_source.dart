import 'dart:async';

import 'package:just_audio/just_audio.dart';

class AudioPlayerDataSource {
  final AudioPlayer _player;

  AudioPlayerDataSource() : _player = AudioPlayer() {
    unawaited(_configureAudioSession());
  }

  Future<void> _configureAudioSession() async {
    // Configure audio session for high-quality playback
    await _player.setVolume(1.0);
    await _player.setSpeed(1.0);
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

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Stream<bool> get playingStream => _player.playingStream;

  bool get isPlaying => _player.playing;

  Duration get currentPosition => _player.position;

  Duration? get duration => _player.duration;

  double get volume => _player.volume;

  double get speed => _player.speed;

  Future<void> dispose() async {
    await _player.dispose();
  }
}
