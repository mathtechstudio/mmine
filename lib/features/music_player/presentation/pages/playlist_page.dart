import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/playlist_detail_page.dart';
import 'package:mmine/features/music_player/presentation/widgets/playlist_card.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage();

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlaylistBloc>().add(
      const PlaylistEvent.loadPlaylistsRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreatePlaylistDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<PlaylistBloc, PlaylistBlocState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Loading...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (playlists) => _buildPlaylistGrid(context, playlists),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error',
                    style: TextStyle(fontSize: 18, color: Colors.red[600]),
                  ),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaylistGrid(BuildContext context, List<Playlist> playlists) {
    if (playlists.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.playlist_play, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No playlists yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to create your first playlist',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return PlaylistCard(
          playlist: playlist,
          onTap: () {
            unawaited(
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => PlaylistDetailPage(playlist: playlist),
                ),
              ),
            );
          },
          onRename: () => _showRenamePlaylistDialog(context, playlist),
          onDelete: () => _showDeleteConfirmationDialog(context, playlist),
        );
      },
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    final controller = TextEditingController();
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Create Playlist'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Playlist name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  context.read<PlaylistBloc>().add(
                    PlaylistEvent.createPlaylistRequested(name),
                  );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRenamePlaylistDialog(BuildContext context, Playlist playlist) {
    final controller = TextEditingController(text: playlist.name);
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Rename Playlist'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Playlist name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty && name != playlist.name) {
                  // TODO: Implement rename functionality
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rename not yet implemented')),
                  );
                }
              },
              child: const Text('Rename'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Playlist playlist) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Delete Playlist'),
          content: Text(
            'Are you sure you want to delete "${playlist.name}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PlaylistBloc>().add(
                  PlaylistEvent.deletePlaylistRequested(playlist.id),
                );
                Navigator.pop(dialogContext);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
