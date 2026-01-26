import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/widgets/audio_quality_badge.dart';

void main() {
  group('AudioQualityBadge Widget', () {
    final now = DateTime.now();

    testWidgets('should display FLAC format badge', (tester) async {
      // Arrange
      final track = AudioTrack(
        id: '1',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        filePath: '/path/to/song.flac',
        duration: Duration.zero,
        format: AudioFormat.flac,
        bitDepth: 24,
        sampleRate: 96000,
        fileSize: 1000,
        dateAdded: now,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AudioQualityBadge(track: track),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('FLAC'), findsOneWidget);
      expect(find.textContaining('24-bit'), findsOneWidget);
      expect(find.textContaining('96.0kHz'), findsOneWidget);
    });

    testWidgets('should display WAV format badge', (tester) async {
      // Arrange
      final track = AudioTrack(
        id: '1',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        filePath: '/path/to/song.wav',
        duration: Duration.zero,
        format: AudioFormat.wav,
        bitDepth: 16,
        sampleRate: 44100,
        fileSize: 1000,
        dateAdded: now,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AudioQualityBadge(track: track),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('WAV'), findsOneWidget);
      expect(find.textContaining('16-bit'), findsOneWidget);
      expect(find.textContaining('44.1kHz'), findsOneWidget);
    });

    testWidgets('should display ALAC format badge', (tester) async {
      // Arrange
      final track = AudioTrack(
        id: '1',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        filePath: '/path/to/song.m4a',
        duration: Duration.zero,
        format: AudioFormat.alac,
        bitDepth: 24,
        sampleRate: 48000,
        fileSize: 1000,
        dateAdded: now,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AudioQualityBadge(track: track),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('ALAC'), findsOneWidget);
      expect(find.textContaining('24-bit'), findsOneWidget);
      expect(find.textContaining('48.0kHz'), findsOneWidget);
    });
  });
}
