import 'package:drift/drift.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:uuid/uuid.dart';

class PlaylistDataSource {
  final AppDatabase database;
  final _uuid = const Uuid();

  PlaylistDataSource(this.database);

  Future<List<Playlist>> getAllPlaylists() async {
    return await database.select(database.playlists).get();
  }

  Future<Playlist?> getPlaylistById(String id) async {
    return await (database.select(
      database.playlists,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

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

  Future<void> deletePlaylist(String id) async {
    await (database.delete(
      database.playlists,
    )..where((tbl) => tbl.id.equals(id))).go();
    await (database.delete(
      database.playlistTracks,
    )..where((tbl) => tbl.playlistId.equals(id))).go();
  }

  Future<List<String>> getPlaylistTrackIds(String playlistId) async {
    final results =
        await (database.select(database.playlistTracks)
              ..where((tbl) => tbl.playlistId.equals(playlistId))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]))
            .get();
    return results.map((row) => row.trackId).toList();
  }

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
