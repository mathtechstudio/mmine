import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/track_list_tile.dart';

class SongsTab extends StatefulWidget {
  const SongsTab();

  @override
  State<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(const LibraryEvent.loadTracksRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildEmpty(),
          loading: () => _buildLoading(),
          scanning: (path) => _buildScanning(path),
          tracksLoaded: (tracks, activeFilter) => _buildTracksList(tracks),
          artistsLoaded: (_) => _buildEmpty(),
          albumsLoaded: (_) => _buildEmpty(),
          searchResults: (results, query) => _buildTracksList(results),
          scanComplete: (_) => _buildEmpty(),
          error: (message) => _buildError(message),
        );
      },
    );
  }

  Widget _buildTracksList(List<AudioTrack> tracks) {
    if (tracks.isEmpty) {
      return _buildEmpty();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<LibraryBloc>().add(
          const LibraryEvent.loadTracksRequested(),
        );
      },
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
          const SizedBox(height: 8),
          Text(
            'Scan a directory to add music',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildScanning(String path) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          const Text('Scanning library...', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            path,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
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
                const LibraryEvent.loadTracksRequested(),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
