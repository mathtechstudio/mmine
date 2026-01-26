import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/// Database table definition for audio tracks.
///
/// Stores metadata for all audio files in the library including:
/// - File information (path, size, format)
/// - Track metadata (title, artist, album, year, genre)
/// - Audio quality (bit depth, sample rate)
/// - Album art path
/// - Date added timestamp
class Tracks extends Table {
  TextColumn get id => text()();
  TextColumn get filePath => text().unique()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get album => text()();
  TextColumn get albumArtist => text().nullable()();
  IntColumn get year => integer().nullable()();
  TextColumn get genre => text().nullable()();
  IntColumn get trackNumber => integer().nullable()();
  IntColumn get durationMs => integer()();
  TextColumn get format => text()();
  IntColumn get bitDepth => integer()();
  IntColumn get sampleRate => integer()();
  IntColumn get fileSize => integer()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get dateAdded => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Database table definition for playlists.
///
/// Stores playlist metadata including:
/// - Unique ID
/// - Playlist name
/// - Creation and update timestamps
class Playlists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Database table definition for playlist-track associations.
///
/// Stores the many-to-many relationship between playlists and tracks,
/// including the position/order of tracks within each playlist.
class PlaylistTracks extends Table {
  TextColumn get playlistId => text()();
  TextColumn get trackId => text()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, trackId};
}

/// Database table definition for application settings.
///
/// Stores key-value pairs for application configuration and preferences.
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

/// Main application database using Drift ORM.
///
/// This database manages all persistent data for the music player including:
/// - Audio track metadata and library
/// - User-created playlists
/// - Playlist-track associations
/// - Application settings
///
/// The database uses SQLite as the underlying storage engine and is
/// located in the application documents directory.
@DriftDatabase(tables: [Tracks, Playlists, PlaylistTracks, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Database schema version.
  ///
  /// Increment this when making schema changes to trigger migrations.
  @override
  int get schemaVersion => 1;

  /// Opens a connection to the SQLite database.
  ///
  /// The database file is stored in the application documents directory
  /// with the name 'music_player.db'.
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'music_player.db'));
      return NativeDatabase(file);
    });
  }
}
