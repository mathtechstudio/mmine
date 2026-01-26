import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/artist_detail_page.dart';
import 'package:mmine/features/music_player/presentation/widgets/artist_list_tile.dart';

class ArtistsTab extends StatefulWidget {
  const ArtistsTab();

  @override
  State<ArtistsTab> createState() => _ArtistsTabState();
}

class _ArtistsTabState extends State<ArtistsTab> {
  Map<String, int> _artistTrackCounts = {};
  List<String> _artists = [];

  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(const LibraryEvent.loadArtistsRequested());
    unawaited(_loadTrackCounts());
  }

  Future<void> _loadTrackCounts() async {
    // Load all tracks to count them by artist
    context.read<LibraryBloc>().add(const LibraryEvent.loadTracksRequested());
  }

  void _updateTrackCounts(List<dynamic> tracks) {
    final counts = <String, int>{};
    for (final track in tracks) {
      if (track is AudioTrack) {
        final artist = track.artist;
        counts[artist] = (counts[artist] ?? 0) + 1;
      }
    }

    // Schedule setState to run after build completes
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _artistTrackCounts = counts;
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
          artistsLoaded: (artists) {
            setState(() {
              _artists = artists;
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
            // Keep showing artists list if we have artists
            if (_artists.isNotEmpty) {
              return _buildArtistsList(_artists);
            }
            return _buildEmpty();
          },
          artistsLoaded: _buildArtistsList,
          albumsLoaded: (albums) {
            // Keep showing artists list if we have artists
            if (_artists.isNotEmpty) {
              return _buildArtistsList(_artists);
            }
            return _buildEmpty();
          },
          searchResults: (results, query) {
            // Keep showing artists list if we have artists
            if (_artists.isNotEmpty) {
              return _buildArtistsList(_artists);
            }
            return _buildEmpty();
          },
          scanComplete: (count) {
            // Keep showing artists list if we have artists
            if (_artists.isNotEmpty) {
              return _buildArtistsList(_artists);
            }
            return _buildEmpty();
          },
          error: _buildError,
        );
      },
    );
  }

  Widget _buildArtistsList(List<String> artists) {
    if (artists.isEmpty) {
      return _buildEmpty();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<LibraryBloc>().add(
          const LibraryEvent.loadArtistsRequested(),
        );
        await _loadTrackCounts();
      },
      child: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          final trackCount = _artistTrackCounts[artist] ?? 0;
          return ArtistListTile(
            artist: artist,
            trackCount: trackCount,
            onTap: () {
              unawaited(
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => ArtistDetailPage(artist: artist),
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
          Icon(Icons.person_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No artists found',
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
                const LibraryEvent.loadArtistsRequested(),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
