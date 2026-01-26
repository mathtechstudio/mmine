import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/album_detail_page.dart';
import 'package:mmine/features/music_player/presentation/widgets/album_card.dart';

class AlbumsTab extends StatefulWidget {
  const AlbumsTab();

  @override
  State<AlbumsTab> createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> {
  Map<String, int> _albumTrackCounts = {};
  Map<String, String> _albumArtists = {};
  List<String> _albums = [];

  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(const LibraryEvent.loadAlbumsRequested());
    unawaited(_loadTrackCounts());
  }

  Future<void> _loadTrackCounts() async {
    // Load all tracks to count them by album
    context.read<LibraryBloc>().add(const LibraryEvent.loadTracksRequested());
  }

  void _updateTrackCounts(List<dynamic> tracks) {
    final counts = <String, int>{};
    final artists = <String, String>{};

    for (final track in tracks) {
      if (track is AudioTrack) {
        final album = track.album;
        counts[album] = (counts[album] ?? 0) + 1;

        // Store the first artist found for this album
        if (!artists.containsKey(album)) {
          artists[album] = track.artist;
        }
      }
    }

    // Schedule setState to run after build completes
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _albumTrackCounts = counts;
          _albumArtists = artists;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryBloc, LibraryState>(
      listener: (context, state) {
        // Update track counts when tracks are loaded
        state.whenOrNull(
          tracksLoaded: (tracks, filter) {
            _updateTrackCounts(tracks);
          },
          albumsLoaded: (albums) {
            setState(() {
              _albums = albums;
            });
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: _buildEmpty,
          loading: _buildLoading,
          scanning: (path) => _buildScanning(path),
          tracksLoaded: (tracks, filter) {
            // Keep showing albums grid if we have albums
            if (_albums.isNotEmpty) {
              return _buildAlbumsGrid(_albums);
            }
            return _buildEmpty();
          },
          artistsLoaded: (artists) {
            // Keep showing albums grid if we have albums
            if (_albums.isNotEmpty) {
              return _buildAlbumsGrid(_albums);
            }
            return _buildEmpty();
          },
          albumsLoaded: _buildAlbumsGrid,
          searchResults: (results, query) {
            // Keep showing albums grid if we have albums
            if (_albums.isNotEmpty) {
              return _buildAlbumsGrid(_albums);
            }
            return _buildEmpty();
          },
          scanComplete: (count) {
            // Keep showing albums grid if we have albums
            if (_albums.isNotEmpty) {
              return _buildAlbumsGrid(_albums);
            }
            return _buildEmpty();
          },
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
        await _loadTrackCounts();
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
          final trackCount = _albumTrackCounts[album] ?? 0;
          final artist = _albumArtists[album] ?? 'Unknown Artist';
          return AlbumCard(
            album: album,
            artist: artist,
            trackCount: trackCount,
            onTap: () {
              final libraryBloc = context.read<LibraryBloc>();
              unawaited(
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => BlocProvider.value(
                      value: libraryBloc,
                      child: AlbumDetailPage(album: album),
                    ),
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
