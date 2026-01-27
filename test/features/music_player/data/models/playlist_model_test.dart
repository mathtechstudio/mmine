import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart'
    as db;
import 'package:mmine/features/music_player/data/models/playlist_model.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';

void main() {
  group('PlaylistModel', () {
    final now = DateTime.now();

    test('should create Playlist entity from Drift playlist', () {
      // Arrange
      final driftPlaylist = db.Playlist(
        id: '1',
        name: 'My Playlist',
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );
      final trackIds = ['track1', 'track2', 'track3'];

      // Act
      final playlist = PlaylistModel.fromDrift(driftPlaylist, trackIds);

      // Assert
      expect(playlist.id, driftPlaylist.id);
      expect(playlist.name, driftPlaylist.name);
      expect(playlist.trackIds, trackIds);
      expect(playlist.trackCount, 3);
      // ignore: unnecessary_type_check
      expect(playlist is Playlist, true);
    });

    test('should handle empty track list', () {
      // Arrange
      final driftPlaylist = db.Playlist(
        id: '1',
        name: 'Empty Playlist',
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );
      final trackIds = <String>[];

      // Act
      final playlist = PlaylistModel.fromDrift(driftPlaylist, trackIds);

      // Assert
      expect(playlist.trackIds, isEmpty);
      expect(playlist.trackCount, 0);
    });

    test('should convert timestamps correctly', () {
      // Arrange
      final createdAt = DateTime(2024, 1, 1);
      final updatedAt = DateTime(2024, 1, 2);
      final driftPlaylist = db.Playlist(
        id: '1',
        name: 'Test Playlist',
        createdAt: createdAt.millisecondsSinceEpoch,
        updatedAt: updatedAt.millisecondsSinceEpoch,
      );

      // Act
      final playlist = PlaylistModel.fromDrift(driftPlaylist, []);

      // Assert
      expect(
        playlist.createdAt.millisecondsSinceEpoch,
        createdAt.millisecondsSinceEpoch,
      );
      expect(
        playlist.updatedAt.millisecondsSinceEpoch,
        updatedAt.millisecondsSinceEpoch,
      );
    });
  });
}
