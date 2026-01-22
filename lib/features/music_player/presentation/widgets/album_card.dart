import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String album;
  final String artist;
  final String? albumArtPath;
  final int trackCount;
  final VoidCallback? onTap;

  const AlbumCard({
    required this.album,
    required this.artist,
    this.albumArtPath,
    required this.trackCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildAlbumArt()),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$trackCount ${trackCount == 1 ? 'song' : 'songs'}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumArt() {
    if (albumArtPath != null) {
      return Image.asset(
        albumArtPath!,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      child: Icon(Icons.album, size: 64, color: Colors.grey[400]),
    );
  }
}
