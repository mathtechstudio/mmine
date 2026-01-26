import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/widgets/track_list_tile.dart';

void main() {
  group('TrackListTile Widget', () {
    final now = DateTime.now();
    final testTrack = AudioTrack(
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

    testWidgets('should display track information', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TrackListTile(track: testTrack, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Song'), findsOneWidget);
      expect(find.textContaining('Test Artist'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      // Arrange
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TrackListTile(
              track: testTrack,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, true);
    });

    testWidgets('should display duration', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TrackListTile(track: testTrack, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('3:30'), findsOneWidget);
    });

    testWidgets('should display format badge', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TrackListTile(track: testTrack, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('FLAC'), findsOneWidget);
    });
  });
}
