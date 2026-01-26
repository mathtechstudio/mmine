import 'package:drift/drift.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/data/models/audio_track_model.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

/// Data source for local database operations using Drift.
///
/// This class provides methods for CRUD operations on audio tracks and
/// playlists stored in the local SQLite database. It uses the Drift
/// package for type-safe database operations.
///
/// The data source handles:
/// - Track storage and retrieval
/// - Playlist management
/// - Batch operations for performance
/// - Query operations (search, filter by artist/album)
class LocalDatabaseDataSource {
  final AppDatabase _database;

  /// Creates a [LocalDatabaseDataSource] with the given [_database].
  LocalDatabaseDataSource(this._database);

  // Track CRUD operations

  /// Inserts a single track into the database.
  ///
  /// If a track with the same ID already exists, it will be replaced.
  /// Uses [InsertMode.insertOrReplace] to handle conflicts.
  Future<void> insertTrack(AudioTrackModel track) async {
    await _database
        .into(_database.tracks)
        .insert(
          TracksCompanion(
            id: Value(track.id),
            filePath: Value(track.filePath),
            title: Value(track.title),
            artist: Value(track.artist),
            album: Value(track.album),
            albumArtist: Value(track.albumArtist),
            year: Value(track.year),
            genre: Value(track.genre),
            trackNumber: Value(track.trackNumber),
            durationMs: Value(track.duration.inMilliseconds),
            format: Value(track.format.name),
            bitDepth: Value(track.bitDepth),
            sampleRate: Value(track.sampleRate),
            fileSize: Value(track.fileSize),
            albumArtPath: Value(track.albumArtPath),
            dateAdded: Value(track.dateAdded.millisecondsSinceEpoch),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Inserts multiple tracks into the database in a single batch operation.
  ///
  /// This is more efficient than calling [insertTrack] multiple times.
  /// Uses batch operations to minimize database transactions.
  ///
  /// If tracks with the same IDs already exist, they will be replaced.
  Future<void> insertTracks(List<AudioTrackModel> tracks) async {
    await _database.batch((batch) {
      for (final track in tracks) {
        batch.insert(
          _database.tracks,
          TracksCompanion(
            id: Value(track.id),
            filePath: Value(track.filePath),
            title: Value(track.title),
            artist: Value(track.artist),
            album: Value(track.album),
            albumArtist: Value(track.albumArtist),
            year: Value(track.year),
            genre: Value(track.genre),
            trackNumber: Value(track.trackNumber),
            durationMs: Value(track.duration.inMilliseconds),
            format: Value(track.format.name),
            bitDepth: Value(track.bitDepth),
            sampleRate: Value(track.sampleRate),
            fileSize: Value(track.fileSize),
            albumArtPath: Value(track.albumArtPath),
            dateAdded: Value(track.dateAdded.millisecondsSinceEpoch),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<List<Track>> getAllTracks() async {
    return await _database.select(_database.tracks).get();
  }

  Future<Track?> getTrackById(String id) async {
    return await (_database.select(
      _database.tracks,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Track>> getTracksByArtist(String artist) async {
    return await (_database.select(_database.tracks)
          ..where((t) => t.artist.equals(artist))
          ..orderBy([(t) => OrderingTerm.asc(t.album)]))
        .get();
  }

  Future<List<Track>> getTracksByAlbum(String album) async {
    return await (_database.select(_database.tracks)
          ..where((t) => t.album.equals(album))
          ..orderBy([(t) => OrderingTerm.asc(t.trackNumber)]))
        .get();
  }

  Future<List<String>> getAllArtists() async {
    final query = _database.selectOnly(_database.tracks, distinct: true)
      ..addColumns([_database.tracks.artist])
      ..orderBy([OrderingTerm.asc(_database.tracks.artist)]);

    final results = await query.get();
    return results.map((row) => row.read(_database.tracks.artist)!).toList();
  }

  Future<List<String>> getAllAlbums() async {
    final query = _database.selectOnly(_database.tracks, distinct: true)
      ..addColumns([_database.tracks.album])
      ..orderBy([OrderingTerm.asc(_database.tracks.album)]);

    final results = await query.get();
    return results.map((row) => row.read(_database.tracks.album)!).toList();
  }

  Future<List<Track>> searchTracks(String query) async {
    final searchQuery = '%${query.toLowerCase()}%';

    return await (_database.select(_database.tracks)..where(
          (t) =>
              t.title.lower().like(searchQuery) |
              t.artist.lower().like(searchQuery) |
              t.album.lower().like(searchQuery) |
              t.genre.lower().like(searchQuery),
        ))
        .get();
  }

  Future<List<Track>> getTracksByFormat(AudioFormat format) async {
    return await (_database.select(
      _database.tracks,
    )..where((t) => t.format.equals(format.name))).get();
  }

  Future<void> deleteTrack(String id) async {
    await (_database.delete(
      _database.tracks,
    )..where((t) => t.id.equals(id))).go();
  }

  Future<void> clearAllTracks() async {
    await _database.delete(_database.tracks).go();
  }

  Future<int> getTrackCount() async {
    final query = _database.selectOnly(_database.tracks)
      ..addColumns([_database.tracks.id.count()]);

    final result = await query.getSingle();
    return result.read(_database.tracks.id.count()) ?? 0;
  }

  // Playlist operations
  Future<void> insertPlaylist(
    String id,
    String name,
    DateTime createdAt,
  ) async {
    await _database
        .into(_database.playlists)
        .insert(
          PlaylistsCompanion(
            id: Value(id),
            name: Value(name),
            createdAt: Value(createdAt.millisecondsSinceEpoch),
            updatedAt: Value(createdAt.millisecondsSinceEpoch),
          ),
        );
  }

  Future<List<Playlist>> getAllPlaylists() async {
    return await _database.select(_database.playlists).get();
  }

  Future<Playlist?> getPlaylistById(String id) async {
    return await (_database.select(
      _database.playlists,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  Future<void> updatePlaylist(
    String id,
    String name,
    DateTime updatedAt,
  ) async {
    await (_database.update(
      _database.playlists,
    )..where((p) => p.id.equals(id))).write(
      PlaylistsCompanion(
        name: Value(name),
        updatedAt: Value(updatedAt.millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> deletePlaylist(String id) async {
    await (_database.delete(
      _database.playlists,
    )..where((p) => p.id.equals(id))).go();
  }

  // Playlist-Track operations
  Future<void> addTrackToPlaylist(
    String playlistId,
    String trackId,
    int position,
  ) async {
    await _database
        .into(_database.playlistTracks)
        .insert(
          PlaylistTracksCompanion(
            playlistId: Value(playlistId),
            trackId: Value(trackId),
            position: Value(position),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> removeTrackFromPlaylist(
    String playlistId,
    String trackId,
  ) async {
    await (_database.delete(_database.playlistTracks)..where(
          (pt) => pt.playlistId.equals(playlistId) & pt.trackId.equals(trackId),
        ))
        .go();
  }

  Future<List<String>> getPlaylistTrackIds(String playlistId) async {
    final results =
        await (_database.select(_database.playlistTracks)
              ..where((pt) => pt.playlistId.equals(playlistId))
              ..orderBy([(pt) => OrderingTerm.asc(pt.position)]))
            .get();

    return results.map((pt) => pt.trackId).toList();
  }

  Future<void> reorderPlaylistTracks(
    String playlistId,
    List<String> trackIds,
  ) async {
    await _database.transaction(() async {
      // Delete all existing tracks for this playlist
      await (_database.delete(
        _database.playlistTracks,
      )..where((pt) => pt.playlistId.equals(playlistId))).go();

      // Insert tracks with new positions
      await _database.batch((batch) {
        for (var i = 0; i < trackIds.length; i++) {
          batch.insert(
            _database.playlistTracks,
            PlaylistTracksCompanion(
              playlistId: Value(playlistId),
              trackId: Value(trackIds[i]),
              position: Value(i),
            ),
          );
        }
      });
    });
  }

  // Settings operations
  Future<void> saveSetting(String key, String value) async {
    await _database
        .into(_database.settings)
        .insert(
          SettingsCompanion(key: Value(key), value: Value(value)),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<String?> getSetting(String key) async {
    final result = await (_database.select(
      _database.settings,
    )..where((s) => s.key.equals(key))).getSingleOrNull();

    return result?.value;
  }
}
