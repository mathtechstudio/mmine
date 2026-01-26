import 'package:drift/drift.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:uuid/uuid.dart';

/// Data source for playlist operations using Drift database.
///
/// This class provides CRUD operations for playlists and playlist tracks,
/// including:
/// - Creating, reading, updating, and deleting playlists
/// - Adding and removing tracks from playlists
/// - Reordering tracks within playlists
/// - Managing playlist timestamps
///
/// All operations are performed on the local SQLite database using Drift ORM.
///
/// Example usage:
/// ```dart
/// final dataSource = PlaylistDataSource(database);
/// final playlist = await dataSource.createPlaylist('My Favorites');
/// await dataSource.addTrackToPlaylist(playlist.id, trackId);
/// ```
class PlaylistDataSource {
  final AppDatabase database;
  final _uuid = const Uuid();

  /// Creates a [PlaylistDataSource] with the given database instance.
  PlaylistDataSource(this.database);

  /// Retrieves all playlists from the database.
  ///
  /// Returns a list of all playlists ordered by creation date.
  Future<List<Playlist>> getAllPlaylists() async {
    return await database.select(database.playlists).get();
  }

  /// Retrieves a playlist by its ID.
  ///
  /// Returns the playlist if found, null otherwise.
  Future<Playlist?> getPlaylistById(String id) async {
    return await (database.select(
      database.playlists,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Creates a new playlist with the given name.
  ///
  /// Generates a unique ID for the playlist and sets creation/update timestamps.
  ///
  /// Returns the created playlist.
  /// Throws an exception if the playlist creation fails.
  Future<Playlist> createPlaylist(String name) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final playlist = PlaylistsCompanion.insert(
      id: _uuid.v4(),
      name: name,
      createdAt: now,
      updatedAt: now,
    );
    await database.into(database.playlists).insert(playlist);
    return await getPlaylistById(playlist.id.value) ??
        (throw Exception('Failed to create playlist'));
  }

  /// Updates an existing playlist.
  ///
  /// Updates the playlist name and timestamp.
  /// The playlist ID cannot be changed.
  Future<void> updatePlaylist(Playlist playlist) async {
    await (database.update(
      database.playlists,
    )..where((tbl) => tbl.id.equals(playlist.id))).write(
      PlaylistsCompanion(
        name: Value(playlist.name),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  /// Deletes a playlist and all its tracks.
  ///
  /// This operation:
  /// 1. Removes the playlist from the playlists table
  /// 2. Removes all track associations from the playlist_tracks table
  ///
  /// Note: This does not delete the actual audio files, only the playlist
  /// and its track associations.
  Future<void> deletePlaylist(String id) async {
    await (database.delete(
      database.playlists,
    )..where((tbl) => tbl.id.equals(id))).go();
    await (database.delete(
      database.playlistTracks,
    )..where((tbl) => tbl.playlistId.equals(id))).go();
  }

  /// Retrieves the track IDs for a playlist in order.
  ///
  /// Returns a list of track IDs ordered by their position in the playlist.
  Future<List<String>> getPlaylistTrackIds(String playlistId) async {
    final results =
        await (database.select(database.playlistTracks)
              ..where((tbl) => tbl.playlistId.equals(playlistId))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]))
            .get();
    return results.map((row) => row.trackId).toList();
  }

  /// Adds a track to a playlist.
  ///
  /// The track is added at the end of the playlist.
  /// If the track already exists in the playlist, it will be replaced.
  ///
  /// Updates the playlist's timestamp after adding the track.
  Future<void> addTrackToPlaylist(String playlistId, String trackId) async {
    final existingTracks = await getPlaylistTrackIds(playlistId);
    final position = existingTracks.length;

    await database
        .into(database.playlistTracks)
        .insert(
          PlaylistTracksCompanion.insert(
            playlistId: playlistId,
            trackId: trackId,
            position: position,
          ),
          mode: InsertMode.insertOrReplace,
        );

    await _updatePlaylistTimestamp(playlistId);
  }

  /// Removes a track from a playlist.
  ///
  /// After removal, the remaining tracks are reordered to maintain
  /// sequential positions.
  ///
  /// Updates the playlist's timestamp after removing the track.
  Future<void> removeTrackFromPlaylist(
    String playlistId,
    String trackId,
  ) async {
    await (database.delete(database.playlistTracks)..where(
          (tbl) =>
              tbl.playlistId.equals(playlistId) & tbl.trackId.equals(trackId),
        ))
        .go();

    await _reorderPlaylistTracks(playlistId);
    await _updatePlaylistTimestamp(playlistId);
  }

  /// Reorders tracks within a playlist.
  ///
  /// Moves a track from [oldIndex] to [newIndex] and updates all track
  /// positions accordingly.
  ///
  /// Parameters:
  /// - [playlistId]: The ID of the playlist
  /// - [oldIndex]: The current position of the track (0-based)
  /// - [newIndex]: The new position for the track (0-based)
  ///
  /// Throws an exception if either index is out of bounds.
  /// Updates the playlist's timestamp after reordering.
  Future<void> reorderPlaylistTracks(
    String playlistId,
    int oldIndex,
    int newIndex,
  ) async {
    final trackIds = await getPlaylistTrackIds(playlistId);

    if (oldIndex < 0 ||
        oldIndex >= trackIds.length ||
        newIndex < 0 ||
        newIndex >= trackIds.length) {
      throw Exception('Invalid index for reordering');
    }

    final trackId = trackIds.removeAt(oldIndex);
    trackIds.insert(newIndex, trackId);

    await (database.delete(
      database.playlistTracks,
    )..where((tbl) => tbl.playlistId.equals(playlistId))).go();

    for (var i = 0; i < trackIds.length; i++) {
      await database
          .into(database.playlistTracks)
          .insert(
            PlaylistTracksCompanion.insert(
              playlistId: playlistId,
              trackId: trackIds[i],
              position: i,
            ),
          );
    }

    await _updatePlaylistTimestamp(playlistId);
  }

  /// Reorders all tracks in a playlist to maintain sequential positions.
  ///
  /// This is an internal method used after removing tracks to ensure
  /// positions are sequential (0, 1, 2, ...) without gaps.
  Future<void> _reorderPlaylistTracks(String playlistId) async {
    final trackIds = await getPlaylistTrackIds(playlistId);

    await (database.delete(
      database.playlistTracks,
    )..where((tbl) => tbl.playlistId.equals(playlistId))).go();

    for (var i = 0; i < trackIds.length; i++) {
      await database
          .into(database.playlistTracks)
          .insert(
            PlaylistTracksCompanion.insert(
              playlistId: playlistId,
              trackId: trackIds[i],
              position: i,
            ),
          );
    }
  }

  /// Updates the timestamp of a playlist to the current time.
  ///
  /// This is called after any modification to the playlist (add, remove, reorder).
  Future<void> _updatePlaylistTimestamp(String playlistId) async {
    await (database.update(
      database.playlists,
    )..where((tbl) => tbl.id.equals(playlistId))).write(
      PlaylistsCompanion(
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }
}
