import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/track_list_tile.dart';

class AlbumDetailPage extends StatefulWidget {
  final String album;

  const AlbumDetailPage({required this.album});

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(
      LibraryEvent.loadTracksByAlbumRequested(widget.album),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          return state.when(
            initial: _buildEmpty,
            loading: _buildLoading,
            scanning: (path) => _buildLoading(),
            tracksLoaded: (tracks, filter) => _buildContent(tracks),
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

  Widget _buildContent(List<AudioTrack> tracks) {
    if (tracks.isEmpty) {
      return _buildEmpty();
    }

    final albumArtPath = tracks.first.albumArtPath;
    final artist = tracks.first.artist;

    return CustomScrollView(
      slivers: [
        _buildAppBar(albumArtPath),
        SliverToBoxAdapter(child: _buildHeader(tracks, artist)),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
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
          }, childCount: tracks.length),
        ),
      ],
    );
  }

  Widget _buildAppBar(String? albumArtPath) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.album,
          style: const TextStyle(
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        background: albumArtPath != null
            ? Image.asset(
                albumArtPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.album, size: 128, color: Colors.grey[400]),
    );
  }

  Widget _buildHeader(List<AudioTrack> tracks, String artist) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(artist, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text(
            '${tracks.length} ${tracks.length == 1 ? 'song' : 'songs'}',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Play all tracks
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play All'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Shuffle all tracks
                  },
                  icon: const Icon(Icons.shuffle),
                  label: const Text('Shuffle'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(title: Text(widget.album)),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildEmpty() {
    return Scaffold(
      appBar: AppBar(title: Text(widget.album)),
      body: Center(
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
      ),
    );
  }

  Widget _buildError(String message) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.album)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: TextStyle(fontSize: 18, color: Colors.red[600]),
            ),
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
                  LibraryEvent.loadTracksByAlbumRequested(widget.album),
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
