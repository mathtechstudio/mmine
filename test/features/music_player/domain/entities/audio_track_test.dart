import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

void main() {
  group('AudioTrack Entity', () {
    final now = DateTime.now();

    test('should create AudioTrack with all properties', () {
      // Arrange & Act
      final track = AudioTrack(
        id: '1',
        title: 'Test Song',
        artist: 'Test Artist',
        album: 'Test Album',
        filePath: '/path/to/song.flac',
        duration: const Duration(minutes: 3, seconds: 30),
        format: AudioFormat.flac,
        bitDepth: 24,
        sampleRate: 96000,
        fileSize: 10485760,
        dateAdded: now,
      );

      // Assert
      expect(track.id, '1');
      expect(track.title, 'Test Song');
      expect(track.artist, 'Test Artist');
      expect(track.album, 'Test Album');
      expect(track.filePath, '/path/to/song.flac');
      expect(track.duration, const Duration(minutes: 3, seconds: 30));
      expect(track.format, AudioFormat.flac);
      expect(track.bitDepth, 24);
      expect(track.sampleRate, 96000);
      expect(track.fileSize, 10485760);
      expect(track.dateAdded, now);
    });

    test('should support equality comparison', () {
      // Arrange
      final track1 = AudioTrack(
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

      final track2 = AudioTrack(
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

      // Assert
      expect(track1, equals(track2));
    });

    test('should support copyWith', () {
      // Arrange
      final track = AudioTrack(
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

      // Act
      final updatedTrack = track.copyWith(title: 'New Title');

      // Assert
      expect(updatedTrack.title, 'New Title');
      expect(updatedTrack.artist, 'Test Artist');
      expect(updatedTrack.id, '1');
    });

    test('should handle different audio formats', () {
      // Test FLAC
      final flacTrack = AudioTrack(
        id: '1',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        filePath: '/path/to/song.flac',
        duration: Duration.zero,
        format: AudioFormat.flac,
        bitDepth: 16,
        sampleRate: 44100,
        fileSize: 10485760,
        dateAdded: now,
      );
      expect(flacTrack.format, AudioFormat.flac);

      // Test WAV
      final wavTrack = flacTrack.copyWith(format: AudioFormat.wav);
      expect(wavTrack.format, AudioFormat.wav);

      // Test ALAC
      final alacTrack = flacTrack.copyWith(format: AudioFormat.alac);
      expect(alacTrack.format, AudioFormat.alac);
    });
  });
}
