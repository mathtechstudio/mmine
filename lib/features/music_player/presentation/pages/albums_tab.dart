import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/album_detail_page.dart';
import 'package:mmine/features/music_player/presentation/widgets/album_card.dart';

class AlbumsTab extends StatefulWidget {
  const AlbumsTab();

  @override
  State<AlbumsTab> createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(const LibraryEvent.loadAlbumsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return state.when(
          initial: _buildEmpty,
          loading: _buildLoading,
          scanning: (path) => _buildScanning(path),
          tracksLoaded: (tracks, filter) => _buildEmpty(),
          artistsLoaded: (artists) => _buildEmpty(),
          albumsLoaded: _buildAlbumsGrid,
          searchResults: (results, query) => _buildEmpty(),
          scanComplete: (count) => _buildEmpty(),
          error: _buildError,
        );
      },
    );
  }

  Widget _buildAlbumsGrid(List<String> albums) {
    if (albums.isEmpty) {
      return _buildEmpty();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<LibraryBloc>().add(
          const LibraryEvent.loadAlbumsRequested(),
        );
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return AlbumCard(
            album: album,
            artist: 'Unknown Artist',
            trackCount: 0,
            onTap: () {
              unawaited(
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => AlbumDetailPage(album: album),
                  ),
                ),
              );
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
          Icon(Icons.album, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No albums found',
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
                const LibraryEvent.loadAlbumsRequested(),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
