import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/track_list_tile.dart';

class ArtistDetailPage extends StatefulWidget {
  final String artist;

  const ArtistDetailPage({required this.artist});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(
      LibraryEvent.loadTracksByArtistRequested(widget.artist),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.artist)),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          return state.when(
            initial: _buildEmpty,
            loading: _buildLoading,
            scanning: (path) => _buildLoading(),
            tracksLoaded: (tracks, filter) => _buildTracksList(tracks),
            artistsLoaded: (artists) => _buildEmpty(),
            albumsLoaded: (albums) => _buildEmpty(),
            searchResults: (results, query) => _buildEmpty(),
            scanComplete: (count) => _buildEmpty(),
            error: _buildError,
          );
        },
      ),
    );
  }

  Widget _buildTracksList(List<AudioTrack> tracks) {
    if (tracks.isEmpty) {
      return _buildEmpty();
    }

    return Column(
      children: [
        _buildHeader(tracks),
        Expanded(
          child: ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              return TrackListTile(
                track: track,
                onTap: () {
                  // TODO: Play track
                },
                onLongPress: () {
                  // TODO: Show context menu
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(List<AudioTrack> tracks) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.blue[100],
            child: Text(
              _getInitials(widget.artist),
              style: TextStyle(
                fontSize: 32,
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.artist,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${tracks.length} ${tracks.length == 1 ? 'song' : 'songs'}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Play all tracks
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play All'),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Shuffle all tracks
                },
                icon: const Icon(Icons.shuffle),
                label: const Text('Shuffle'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.music_note, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No songs found',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text('Error', style: TextStyle(fontSize: 18, color: Colors.red[600])),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<LibraryBloc>().add(
                LibraryEvent.loadTracksByArtistRequested(widget.artist),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';

    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}
