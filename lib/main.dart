import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/data/datasources/file_system_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/local_database_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/metadata_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/permission_data_source.dart';
import 'package:mmine/features/music_player/data/repositories/audio_repository_impl.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_albums_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_artists_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_tracks_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_tracks_by_album_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_tracks_by_artist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/scan_directory_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/search_tracks_use_case.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/library_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mmine - Lossless Music Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    final database = AppDatabase();
    final permissionDataSource = PermissionDataSource();
    final metadataDataSource = MetadataDataSource();
    final fileSystemDataSource = FileSystemDataSource();
    final localDatabaseDataSource = LocalDatabaseDataSource(database);
    final audioRepository = AudioRepositoryImpl(
      fileSystemDataSource: fileSystemDataSource,
      metadataDataSource: metadataDataSource,
      databaseDataSource: localDatabaseDataSource,
      permissionDataSource: permissionDataSource,
    );

    return BlocProvider(
      create: (context) => LibraryBloc(
        getAllTracks: GetAllTracksUseCase(audioRepository),
        getAllArtists: GetAllArtistsUseCase(audioRepository),
        getAllAlbums: GetAllAlbumsUseCase(audioRepository),
        getTracksByArtist: GetTracksByArtistUseCase(audioRepository),
        getTracksByAlbum: GetTracksByAlbumUseCase(audioRepository),
        scanDirectory: ScanDirectoryUseCase(audioRepository),
        searchTracks: SearchTracksUseCase(audioRepository),
      ),
      child: const LibraryPage(),
    );
  }
}
