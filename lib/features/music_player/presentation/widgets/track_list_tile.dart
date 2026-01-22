import 'package:flutter/material.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

class TrackListTile extends StatelessWidget {
  final AudioTrack track;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TrackListTile({required this.track, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildAlbumArt(),
      title: Text(track.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${track.artist} • ${track.album}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: _buildTrailing(),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  Widget _buildAlbumArt() {
    if (track.albumArtPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          track.albumArtPath!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        ),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.music_note, color: Colors.grey),
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _formatDuration(track.duration),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        _buildFormatBadge(),
      ],
    );
  }

  Widget _buildFormatBadge() {
    final formatText = track.format.name.toUpperCase();
    final color = _getFormatColor(track.format);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        formatText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Color _getFormatColor(AudioFormat format) {
    return switch (format) {
      AudioFormat.flac => Colors.blue,
      AudioFormat.wav => Colors.green,
      AudioFormat.alac => Colors.purple,
    };
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
