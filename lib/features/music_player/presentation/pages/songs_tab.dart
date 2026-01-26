import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/core/utils/animations.dart';
import 'package:mmine/core/utils/error_handler.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/skeleton_track_tile.dart';
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
    return BlocConsumer<LibraryBloc, LibraryState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ErrorHandler.showErrorSnackBar(
              context,
              ErrorHandler.getUserFriendlyMessage(message),
              onRetry: () {
                context.read<LibraryBloc>().add(
                  const LibraryEvent.loadTracksRequested(),
                );
              },
            );
          },
          scanComplete: (tracksAdded) {
            if (tracksAdded > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    tracksAdded == 1
                        ? 'Successfully added 1 track'
                        : 'Successfully added $tracksAdded tracks',
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'File already in library or no new tracks found',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildEmpty(),
          loading: () => _buildLoadingSkeleton(),
          scanning: (path) => _buildScanning(path),
          tracksLoaded: (tracks, activeFilter) => _buildTracksList(tracks),
          artistsLoaded: (_) => _buildEmpty(),
          albumsLoaded: (_) => _buildEmpty(),
          searchResults: (results, query) => _buildTracksList(results),
          scanComplete: (_) => _buildLoadingSkeleton(),
          error: (message) => _buildError(message),
        );
      },
    );
  }

  Widget _buildTracksList(List<AudioTrack> tracks) {
    if (tracks.isEmpty) {
      return _buildEmpty();
    }

    return BlocBuilder<PlaybackBloc, PlaybackBlocState>(
      buildWhen: (previous, current) {
        // Always rebuild when state changes
        return true;
      },
      builder: (context, playbackState) {
        AudioTrack? currentTrack;
        bool isPlaying = false;

        playbackState.whenOrNull(
          playing: (state) {
            currentTrack = state.currentTrack;
            isPlaying = state.isPlaying;
            debugPrint(
              'SongsTab - Playing state: track=${currentTrack?.title}, isPlaying=$isPlaying',
            );
          },
        );

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
              final isCurrentTrack = currentTrack?.id == track.id;

              return AppAnimations.animatedListItem(
                index: index,
                child: TrackListTile(
                  track: track,
                  isPlaying: isCurrentTrack && isPlaying,
                  isCurrentTrack: isCurrentTrack,
                  onTap: () {
                    debugPrint(
                      'Track tapped: ${track.title}, isCurrentTrack=$isCurrentTrack, isPlaying=$isPlaying',
                    );
                    // If tapping on current track, toggle play/pause
                    if (isCurrentTrack) {
                      if (isPlaying) {
                        debugPrint('Requesting pause');
                        context.read<PlaybackBloc>().add(
                          const PlaybackEvent.pauseRequested(),
                        );
                      } else {
                        debugPrint('Requesting resume');
                        context.read<PlaybackBloc>().add(
                          const PlaybackEvent.resumeRequested(),
                        );
                      }
                    } else {
                      debugPrint('Requesting play with queue');
                      // Play the track with the full queue
                      context.read<PlaybackBloc>().add(
                        PlaybackEvent.playRequested(track, tracks, index),
                      );
                    }
                  },
                  onLongPress: () {
                    // TODO: Show context menu
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLoadingSkeleton() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const SkeletonTrackTile(),
    );
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
