import 'package:flutter/material.dart';

class ArtistListTile extends StatelessWidget {
  final String artist;
  final int trackCount;
  final VoidCallback? onTap;

  const ArtistListTile({
    required this.artist,
    required this.trackCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildAvatar(),
      title: Text(
        artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '$trackCount ${trackCount == 1 ? 'song' : 'songs'}',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.blue[100],
      child: Text(
        _getInitials(artist),
        style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';

    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}
