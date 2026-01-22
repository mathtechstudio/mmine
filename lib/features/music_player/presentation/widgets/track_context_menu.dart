import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/queue/queue_bloc.dart';

class TrackContextMenu {
  static void show(
    BuildContext context,
    AudioTrack track, {
    bool showPlayNow = true,
  }) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (bottomSheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(track),
              const Divider(height: 1),
              if (showPlayNow)
                _buildMenuItem(
                  icon: Icons.play_arrow,
                  title: 'Play Now',
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    context.read<PlaybackBloc>().add(
                      PlaybackEvent.playRequested(track, [track], 0),
                    );
                  },
                ),
              _buildMenuItem(
                icon: Icons.playlist_play,
                title: 'Play Next',
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  context.read<QueueBloc>().add(
                    QueueEvent.playNextRequested([track]),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to play next'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.queue_music,
                title: 'Add to Queue',
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  context.read<QueueBloc>().add(
                    QueueEvent.addToQueueRequested([track]),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to queue'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.playlist_add,
                title: 'Add to Playlist',
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  // TODO: Show playlist selection dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Playlist feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'Track Info',
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _showTrackInfo(context, track);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildHeader(AudioTrack track) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: track.albumArtPath != null
                  ? Image.asset(
                      track.albumArtPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  track.artist,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPlaceholder() {
    return Icon(Icons.music_note, size: 28, color: Colors.grey[400]);
  }

  static Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  static void _showTrackInfo(BuildContext context, AudioTrack track) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Track Info'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoRow('Title', track.title),
                _buildInfoRow('Artist', track.artist),
                _buildInfoRow('Album', track.album),
                if (track.albumArtist != null)
                  _buildInfoRow('Album Artist', track.albumArtist!),
                if (track.year != null)
                  _buildInfoRow('Year', track.year.toString()),
                if (track.genre != null) _buildInfoRow('Genre', track.genre!),
                if (track.trackNumber != null)
                  _buildInfoRow('Track Number', track.trackNumber.toString()),
                _buildInfoRow('Duration', _formatDuration(track.duration)),
                _buildInfoRow('Format', track.format.name.toUpperCase()),
                _buildInfoRow('Bit Depth', '${track.bitDepth} bit'),
                _buildInfoRow(
                  'Sample Rate',
                  '${(track.sampleRate / 1000).toStringAsFixed(1)} kHz',
                ),
                _buildInfoRow(
                  'File Size',
                  '${(track.fileSize / (1024 * 1024)).toStringAsFixed(2)} MB',
                ),
                _buildInfoRow('Path', track.filePath, isPath: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfoRow(
    String label,
    String value, {
    bool isPath = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
            maxLines: isPath ? 3 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  static String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
