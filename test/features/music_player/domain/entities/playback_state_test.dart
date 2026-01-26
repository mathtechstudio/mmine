import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';

void main() {
  group('PlaybackState Entity', () {
    final now = DateTime.now();
    final testTrack = AudioTrack(
      id: '1',
      title: 'Test Song',
      artist: 'Test Artist',
      album: 'Test Album',
      filePath: '/path/to/song.flac',
      duration: const Duration(minutes: 3),
      format: AudioFormat.flac,
      bitDepth: 24,
      sampleRate: 96000,
      fileSize: 10485760,
      dateAdded: now,
    );

    test('should create default PlaybackState', () {
      // Arrange & Act
      const state = PlaybackState();

      // Assert
      expect(state.currentTrack, isNull);
      expect(state.queue, isEmpty);
      expect(state.currentIndex, 0);
      expect(state.isPlaying, false);
      expect(state.position, Duration.zero);
      expect(state.duration, Duration.zero);
      expect(state.volume, 1.0);
      expect(state.speed, 1.0);
      expect(state.repeatMode, RepeatMode.off);
      expect(state.shuffleEnabled, false);
    });

    test('should support copyWith', () {
      // Arrange
      const state = PlaybackState();

      // Act
      final newState = state.copyWith(isPlaying: true, volume: 0.5, speed: 1.5);

      // Assert
      expect(newState.isPlaying, true);
      expect(newState.volume, 0.5);
      expect(newState.speed, 1.5);
    });

    test('should calculate hasNext correctly', () {
      // Arrange
      final state = PlaybackState(
        queue: [testTrack, testTrack, testTrack],
        currentIndex: 1,
      );

      // Assert
      expect(state.hasNext, true);
    });

    test('should calculate hasNext as false when at end', () {
      // Arrange
      final state = PlaybackState(
        queue: [testTrack, testTrack],
        currentIndex: 1,
      );

      // Assert
      expect(state.hasNext, false);
    });

    test('should calculate hasPrevious correctly', () {
      // Arrange
      final state = PlaybackState(
        queue: [testTrack, testTrack, testTrack],
        currentIndex: 1,
      );

      // Assert
      expect(state.hasPrevious, true);
    });

    test('should calculate hasPrevious as false when at start', () {
      // Arrange
      final state = PlaybackState(
        queue: [testTrack, testTrack],
        currentIndex: 0,
      );

      // Assert
      expect(state.hasPrevious, false);
    });

    test('should handle empty queue', () {
      // Arrange
      const state = PlaybackState(queue: []);

      // Assert
      expect(state.hasNext, false);
      expect(state.hasPrevious, false);
    });

    test('should support all repeat modes', () {
      // Test off
      const stateOff = PlaybackState(repeatMode: RepeatMode.off);
      expect(stateOff.repeatMode, RepeatMode.off);

      // Test all
      const stateAll = PlaybackState(repeatMode: RepeatMode.all);
      expect(stateAll.repeatMode, RepeatMode.all);

      // Test one
      const stateOne = PlaybackState(repeatMode: RepeatMode.one);
      expect(stateOne.repeatMode, RepeatMode.one);
    });

    test('should handle shuffle state', () {
      // Arrange
      const state = PlaybackState(shuffleEnabled: true);

      // Assert
      expect(state.shuffleEnabled, true);
    });
  });
}
