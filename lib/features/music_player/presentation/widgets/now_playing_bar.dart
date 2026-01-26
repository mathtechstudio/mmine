import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/now_playing_page.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaybackBloc, PlaybackBlocState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          playing: (playbackState) {
            if (playbackState.currentTrack == null) {
              return const SizedBox.shrink();
            }
            return _buildBar(context, playbackState);
          },
          error: (message) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildBar(BuildContext context, PlaybackState playbackState) {
    final track = playbackState.currentTrack!;
    final progress = playbackState.duration.inMilliseconds > 0
        ? playbackState.position.inMilliseconds /
              playbackState.duration.inMilliseconds
        : 0.0;

    return GestureDetector(
      onTap: () {
        unawaited(
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (newContext) => BlocProvider.value(
                value: context.read<PlaybackBloc>(),
                child: const NowPlayingPage(),
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 2,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildAlbumArt(track.albumArtPath),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            track.artist,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildPlayPauseButton(context, playbackState.isPlaying),
                    const SizedBox(width: 8),
                    _buildNextButton(context, playbackState.hasNext),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumArt(String? albumArtPath) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: albumArtPath != null
            ? Image.file(
                File(albumArtPath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Icon(Icons.music_note, size: 24, color: Colors.grey[400]);
  }

  Widget _buildPlayPauseButton(BuildContext context, bool isPlaying) {
    return IconButton(
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      iconSize: 32,
      onPressed: () {
        if (isPlaying) {
          context.read<PlaybackBloc>().add(
            const PlaybackEvent.pauseRequested(),
          );
        } else {
          context.read<PlaybackBloc>().add(
            const PlaybackEvent.resumeRequested(),
          );
        }
      },
    );
  }

  Widget _buildNextButton(BuildContext context, bool hasNext) {
    return IconButton(
      icon: const Icon(Icons.skip_next),
      iconSize: 28,
      onPressed: hasNext
          ? () {
              // TODO: Skip to next
            }
          : null,
      color: hasNext ? Colors.black87 : Colors.grey[400],
    );
  }
}
