import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/queue/queue_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/queue_item.dart';

class QueuePage extends StatelessWidget {
  const QueuePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue'),
        actions: [
          BlocBuilder<QueueBloc, QueueBlocState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (queue, currentIndex, currentTrack) {
                  if (queue.isEmpty) return const SizedBox.shrink();
                  return IconButton(
                    icon: const Icon(Icons.clear_all),
                    tooltip: 'Clear queue',
                    onPressed: () {
                      _showClearQueueDialog(context);
                    },
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<QueueBloc, QueueBlocState>(
        builder: (context, state) {
          return state.when(
            initial: () => _buildEmptyState(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (queue, currentIndex, currentTrack) {
              if (queue.isEmpty) {
                return _buildEmptyState();
              }
              return _buildQueueList(
                context,
                queue,
                currentIndex,
                currentTrack,
              );
            },
            error: (message) => _buildErrorState(message),
          );
        },
      ),
    );
  }

  Widget _buildQueueList(
    BuildContext context,
    List<AudioTrack> queue,
    int currentIndex,
    AudioTrack? currentTrack,
  ) {
    return Column(
      children: [
        if (currentTrack != null) _buildCurrentTrackHeader(queue, currentIndex),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: queue.length,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex == currentIndex || newIndex == currentIndex) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cannot reorder currently playing track'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              context.read<QueueBloc>().add(
                QueueEvent.reorderQueueRequested(oldIndex, newIndex),
              );
            },
            itemBuilder: (context, index) {
              final track = queue[index];
              final isCurrentTrack = index == currentIndex;
              return Container(
                key: Key(track.id),
                child: QueueItem(
                  track: track,
                  isCurrentTrack: isCurrentTrack,
                  onTap: isCurrentTrack
                      ? null
                      : () {
                          // TODO: Skip to this track
                        },
                  onRemove: isCurrentTrack
                      ? null
                      : () {
                          context.read<QueueBloc>().add(
                            QueueEvent.removeFromQueueRequested(index),
                          );
                        },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentTrackHeader(List<AudioTrack> queue, int currentIndex) {
    final upcomingCount = queue.length - currentIndex - 1;
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Row(
        children: [
          const Icon(Icons.queue_music, size: 20),
          const SizedBox(width: 8),
          Text(
            'Now Playing • $upcomingCount upcoming',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.queue_music, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Queue is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add tracks to start playing',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showClearQueueDialog(BuildContext context) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Clear Queue'),
          content: const Text(
            'Are you sure you want to clear the entire queue? This will stop playback.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<QueueBloc>().add(
                  const QueueEvent.clearQueueRequested(),
                );
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}
