import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/queue_page.dart';
import 'package:mmine/features/music_player/presentation/widgets/audio_quality_badge.dart';
import 'package:mmine/features/music_player/presentation/widgets/playback_controls.dart';
import 'package:mmine/features/music_player/presentation/widgets/progress_slider.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
      body: BlocBuilder<PlaybackBloc, PlaybackBlocState>(
        builder: (context, state) {
          return state.when(
            initial: _buildEmpty,
            loading: _buildLoading,
            playing: (playbackState) => _buildPlaying(context, playbackState),
            error: _buildError,
          );
        },
      ),
    );
  }

  Widget _buildPlaying(BuildContext context, PlaybackState playbackState) {
    final track = playbackState.currentTrack;
    if (track == null) return _buildEmpty();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildAlbumArt(track),
                const SizedBox(height: 32),
                _buildTrackInfo(track),
                const SizedBox(height: 24),
                AudioQualityBadge(track: track),
                const SizedBox(height: 32),
                ProgressSlider(
                  position: playbackState.position,
                  duration: playbackState.duration,
                  onChangeEnd: (position) {
                    context.read<PlaybackBloc>().add(
                      PlaybackEvent.seekRequested(position),
                    );
                  },
                ),
                const SizedBox(height: 32),
                PlaybackControls(
                  isPlaying: playbackState.isPlaying,
                  hasPrevious: playbackState.hasPrevious,
                  hasNext: playbackState.hasNext,
                  onPlayPause: () {
                    if (playbackState.isPlaying) {
                      context.read<PlaybackBloc>().add(
                        const PlaybackEvent.pauseRequested(),
                      );
                    } else {
                      context.read<PlaybackBloc>().add(
                        const PlaybackEvent.resumeRequested(),
                      );
                    }
                  },
                  onPrevious: () {
                    context.read<PlaybackBloc>().add(
                      const PlaybackEvent.skipToPreviousRequested(),
                    );
                  },
                  onNext: () {
                    context.read<PlaybackBloc>().add(
                      const PlaybackEvent.skipToNextRequested(),
                    );
                  },
                ),
                const SizedBox(height: 32),
                _buildAdditionalControls(context, playbackState),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAlbumArt(AudioTrack track) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: track.albumArtPath != null
                ? Image.asset(
                    track.albumArtPath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderArt(),
                  )
                : _buildPlaceholderArt(),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderArt() {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.album, size: 120, color: Colors.grey[400]),
    );
  }

  Widget _buildTrackInfo(AudioTrack track) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            track.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            track.artist,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            track.album,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalControls(
    BuildContext context,
    PlaybackState playbackState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              playbackState.shuffleEnabled
                  ? Icons.shuffle_on_outlined
                  : Icons.shuffle,
              color: playbackState.shuffleEnabled
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[600],
            ),
            onPressed: () {
              context.read<PlaybackBloc>().add(
                PlaybackEvent.shuffleToggled(!playbackState.shuffleEnabled),
              );
            },
          ),
          IconButton(
            icon: Icon(
              _getRepeatIcon(playbackState.repeatMode),
              color: playbackState.repeatMode != RepeatMode.off
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[600],
            ),
            onPressed: () {
              final nextMode = _getNextRepeatMode(playbackState.repeatMode);
              context.read<PlaybackBloc>().add(
                PlaybackEvent.repeatModeChanged(nextMode),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.queue_music, color: Colors.grey[600]),
            onPressed: () {
              unawaited(
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const QueuePage(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.speed, color: Colors.grey[600]),
            onPressed: () {
              _showSpeedDialog(context, playbackState.speed);
            },
          ),
        ],
      ),
    );
  }

  IconData _getRepeatIcon(RepeatMode mode) {
    return switch (mode) {
      RepeatMode.off => Icons.repeat,
      RepeatMode.all => Icons.repeat_on,
      RepeatMode.one => Icons.repeat_one_on,
    };
  }

  RepeatMode _getNextRepeatMode(RepeatMode current) {
    return switch (current) {
      RepeatMode.off => RepeatMode.all,
      RepeatMode.all => RepeatMode.one,
      RepeatMode.one => RepeatMode.off,
    };
  }

  void _showSpeedDialog(BuildContext context, double currentSpeed) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Playback Speed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
              return RadioListTile<double>(
                title: Text('${speed}x'),
                value: speed,
                groupValue: currentSpeed,
                onChanged: (value) {
                  if (value != null) {
                    context.read<PlaybackBloc>().add(
                      PlaybackEvent.speedChanged(value),
                    );
                    Navigator.pop(dialogContext);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
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
            'No track playing',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
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
        ],
      ),
    );
  }
}
