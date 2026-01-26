import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/data/datasources/audio_player_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/data/datasources/file_system_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/local_database_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/metadata_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/permission_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/playlist_data_source.dart';
import 'package:mmine/features/music_player/data/repositories/audio_repository_impl.dart';
import 'package:mmine/features/music_player/data/repositories/playback_repository_impl.dart';
import 'package:mmine/features/music_player/data/repositories/playlist_repository_impl.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/add_single_file_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_albums_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_artists_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_tracks_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_tracks_by_album_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_tracks_by_artist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/scan_directory_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/search_tracks_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/pause_playback_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/play_track_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/resume_playback_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/seek_to_position_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/set_speed_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/set_volume_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/toggle_shuffle_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/add_track_to_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/create_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/delete_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/get_all_playlists_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/remove_track_from_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/reorder_playlist_tracks_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/add_to_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/clear_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/play_next_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/remove_from_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/reorder_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/set_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/skip_to_next_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/skip_to_previous_use_case.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/queue/queue_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/library_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    final playlistDataSource = PlaylistDataSource(database);

    final audioRepository = AudioRepositoryImpl(
      fileSystemDataSource: fileSystemDataSource,
      metadataDataSource: metadataDataSource,
      databaseDataSource: localDatabaseDataSource,
      permissionDataSource: permissionDataSource,
    );

    final playlistRepository = PlaylistRepositoryImpl(
      playlistDataSource: playlistDataSource,
    );

    final audioPlayerDataSource = AudioPlayerDataSource();
    final playbackRepository = PlaybackRepositoryImpl(
      audioPlayerDataSource: audioPlayerDataSource,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LibraryBloc(
            getAllTracks: GetAllTracksUseCase(audioRepository),
            getAllArtists: GetAllArtistsUseCase(audioRepository),
            getAllAlbums: GetAllAlbumsUseCase(audioRepository),
            getTracksByArtist: GetTracksByArtistUseCase(audioRepository),
            getTracksByAlbum: GetTracksByAlbumUseCase(audioRepository),
            scanDirectory: ScanDirectoryUseCase(audioRepository),
            addSingleFile: AddSingleFileUseCase(audioRepository),
            searchTracks: SearchTracksUseCase(audioRepository),
          ),
        ),
        BlocProvider(
          create: (context) => PlaybackBloc(
            playTrack: PlayTrackUseCase(playbackRepository),
            pausePlayback: PausePlaybackUseCase(playbackRepository),
            resumePlayback: ResumePlaybackUseCase(playbackRepository),
            seekToPosition: SeekToPositionUseCase(playbackRepository),
            setVolume: SetVolumeUseCase(playbackRepository),
            setSpeed: SetSpeedUseCase(playbackRepository),
            setQueue: SetQueueUseCase(playbackRepository),
            skipToNext: SkipToNextUseCase(playbackRepository),
            skipToPrevious: SkipToPreviousUseCase(playbackRepository),
            toggleShuffle: ToggleShuffleUseCase(playbackRepository),
            playbackRepository: playbackRepository,
          ),
        ),
        BlocProvider(
          create: (context) => QueueBloc(
            addToQueue: AddToQueueUseCase(playbackRepository),
            playNext: PlayNextUseCase(playbackRepository),
            removeFromQueue: RemoveFromQueueUseCase(playbackRepository),
            reorderQueue: ReorderQueueUseCase(playbackRepository),
            clearQueue: ClearQueueUseCase(playbackRepository),
            playbackRepository: playbackRepository,
          ),
        ),
        BlocProvider(
          create: (context) => PlaylistBloc(
            getAllPlaylists: GetAllPlaylistsUseCase(playlistRepository),
            createPlaylist: CreatePlaylistUseCase(playlistRepository),
            deletePlaylist: DeletePlaylistUseCase(playlistRepository),
            addTrackToPlaylist: AddTrackToPlaylistUseCase(playlistRepository),
            removeTrackFromPlaylist: RemoveTrackFromPlaylistUseCase(
              playlistRepository,
            ),
            reorderPlaylistTracks: ReorderPlaylistTracksUseCase(
              playlistRepository,
            ),
          ),
        ),
      ],
      child: const LibraryPage(),
    );
  }
}
