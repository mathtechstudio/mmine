import 'package:flutter/material.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

class QueueItem extends StatelessWidget {
  final AudioTrack track;
  final bool isCurrentTrack;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const QueueItem({
    required this.track,
    required this.isCurrentTrack,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(track.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        onRemove?.call();
      },
      child: Container(
        color: isCurrentTrack
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
            : null,
        child: ListTile(
          leading: _buildLeading(context),
          title: Text(
            track.title,
            style: TextStyle(
              fontWeight: isCurrentTrack ? FontWeight.bold : FontWeight.normal,
              color: isCurrentTrack
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${track.artist} • ${track.album}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDuration(track.duration),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(width: 8),
              Icon(Icons.drag_handle, color: Colors.grey[400]),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (isCurrentTrack) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
      );
    }

    return Container(
      width: 48,
      height: 48,
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
    );
  }

  Widget _buildPlaceholder() {
    return Icon(Icons.music_note, size: 24, color: Colors.grey[400]);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
