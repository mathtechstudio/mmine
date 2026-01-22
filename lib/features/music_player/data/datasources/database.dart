import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

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

class Playlists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlaylistTracks extends Table {
  TextColumn get playlistId => text()();
  TextColumn get trackId => text()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, trackId};
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [Tracks, Playlists, PlaylistTracks, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'music_player.db'));
      return NativeDatabase(file);
    });
  }
}
