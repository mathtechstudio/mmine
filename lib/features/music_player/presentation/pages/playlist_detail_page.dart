import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/track_list_tile.dart';

class PlaylistDetailPage extends StatefulWidget {
  final Playlist playlist;

  const PlaylistDetailPage({required this.playlist});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  List<AudioTrack> _tracks = [];

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  void _loadTracks() {
    final libraryState = context.read<LibraryBloc>().state;
    libraryState.maybeWhen(
      tracksLoaded: (tracks, activeFilter) {
        setState(() {
          _tracks = tracks
              .where((track) => widget.playlist.trackIds.contains(track.id))
              .toList();
        });
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.playlist.name),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.playlist_play,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_tracks.length} ${_tracks.length == 1 ? 'track' : 'tracks'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      if (_tracks.isNotEmpty) ...[
                        ElevatedButton.icon(
                          onPressed: () => _playAll(shuffle: false),
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play All'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () => _playAll(shuffle: true),
                          icon: const Icon(Icons.shuffle),
                          label: const Text('Shuffle'),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (_tracks.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No tracks in this playlist',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add tracks from the library',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverReorderableList(
              itemCount: _tracks.length,
              onReorder: _onReorder,
              itemBuilder: (context, index) {
                final track = _tracks[index];
                return ReorderableDragStartListener(
                  key: ValueKey(track.id),
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TrackListTile(
                            track: track,
                            onTap: () => _playTrack(index),
                          ),
                        ),
                        Icon(Icons.drag_handle, color: Colors.grey[400]),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          color: Colors.red,
                          onPressed: () => _removeTrack(track),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  void _playAll({required bool shuffle}) {
    if (_tracks.isEmpty) return;

    final tracks = shuffle ? (_tracks.toList()..shuffle()) : _tracks;
    context.read<PlaybackBloc>().add(
      PlaybackEvent.setQueueRequested(tracks, 0),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          shuffle ? 'Playing playlist (shuffled)' : 'Playing playlist',
        ),
      ),
    );
  }

  void _playTrack(int index) {
    context.read<PlaybackBloc>().add(
      PlaybackEvent.setQueueRequested(_tracks, index),
    );
  }

  void _removeTrack(AudioTrack track) {
    context.read<PlaylistBloc>().add(
      PlaylistEvent.removeTrackFromPlaylistRequested(
        widget.playlist.id,
        track.id,
      ),
    );
    setState(() {
      _tracks.removeWhere((t) => t.id == track.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed ${track.title} from playlist')),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    setState(() {
      final track = _tracks.removeAt(oldIndex);
      _tracks.insert(newIndex, track);
    });

    context.read<PlaylistBloc>().add(
      PlaylistEvent.reorderPlaylistTracksRequested(
        widget.playlist.id,
        oldIndex,
        newIndex,
      ),
    );
  }
}
