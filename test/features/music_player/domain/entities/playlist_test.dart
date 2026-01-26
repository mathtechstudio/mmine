import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';

void main() {
  group('Playlist Entity', () {
    final now = DateTime.now();

    test('should create Playlist with all properties', () {
      // Arrange & Act
      final playlist = Playlist(
        id: '1',
        name: 'My Playlist',
        trackIds: ['track1', 'track2', 'track3'],
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(playlist.id, '1');
      expect(playlist.name, 'My Playlist');
      expect(playlist.trackIds, ['track1', 'track2', 'track3']);
      expect(playlist.trackCount, 3);
      expect(playlist.createdAt, now);
      expect(playlist.updatedAt, now);
    });

    test('should support equality comparison', () {
      // Arrange
      final playlist1 = Playlist(
        id: '1',
        name: 'My Playlist',
        trackIds: ['track1', 'track2'],
        createdAt: now,
        updatedAt: now,
      );

      final playlist2 = Playlist(
        id: '1',
        name: 'My Playlist',
        trackIds: ['track1', 'track2'],
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(playlist1, equals(playlist2));
    });

    test('should support copyWith', () {
      // Arrange
      final playlist = Playlist(
        id: '1',
        name: 'My Playlist',
        trackIds: ['track1'],
        createdAt: now,
        updatedAt: now,
      );

      // Act
      final updatedPlaylist = playlist.copyWith(name: 'New Name');

      // Assert
      expect(updatedPlaylist.name, 'New Name');
      expect(updatedPlaylist.id, '1');
      expect(updatedPlaylist.trackIds, ['track1']);
    });

    test('should calculate track count correctly', () {
      // Arrange
      final emptyPlaylist = Playlist(
        id: '1',
        name: 'Empty',
        trackIds: [],
        createdAt: now,
        updatedAt: now,
      );

      final fullPlaylist = Playlist(
        id: '2',
        name: 'Full',
        trackIds: ['1', '2', '3', '4', '5'],
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(emptyPlaylist.trackCount, 0);
      expect(fullPlaylist.trackCount, 5);
    });

    test('should handle empty track list', () {
      // Arrange & Act
      final playlist = Playlist(
        id: '1',
        name: 'Empty Playlist',
        trackIds: [],
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(playlist.trackIds, isEmpty);
      expect(playlist.trackCount, 0);
    });
  });
}
