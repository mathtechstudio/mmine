import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/core/utils/animations.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/pages/albums_tab.dart';
import 'package:mmine/features/music_player/presentation/pages/artists_tab.dart';
import 'package:mmine/features/music_player/presentation/pages/playlist_page.dart';
import 'package:mmine/features/music_player/presentation/pages/settings_page.dart';
import 'package:mmine/features/music_player/presentation/pages/songs_tab.dart';
import 'package:mmine/features/music_player/presentation/widgets/now_playing_bar.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage();

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text('Library'),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
                context.read<LibraryBloc>().add(
                  const LibraryEvent.searchQueryChanged(''),
                );
              },
            ),
          PopupMenuButton<AudioFormat?>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter by format',
            onSelected: (format) {
              context.read<LibraryBloc>().add(
                LibraryEvent.filterByFormatRequested(format),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: null, child: Text('All Formats')),
              const PopupMenuItem(value: AudioFormat.flac, child: Text('FLAC')),
              const PopupMenuItem(value: AudioFormat.wav, child: Text('WAV')),
              const PopupMenuItem(value: AudioFormat.alac, child: Text('ALAC')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: 'Scan directory',
            onPressed: () {
              _showScanDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              unawaited(
                Navigator.push(
                  context,
                  AppAnimations.createSlideRoute(const SettingsPage()),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Songs'),
            Tab(text: 'Artists'),
            Tab(text: 'Albums'),
            Tab(text: 'Playlists'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SongsTab(),
                ArtistsTab(),
                AlbumsTab(),
                PlaylistPage(),
              ],
            ),
          ),
          const NowPlayingBar(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search songs, artists, albums...',
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (query) {
        context.read<LibraryBloc>().add(LibraryEvent.searchQueryChanged(query));
      },
    );
  }

  void _showScanDialog() {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Scan Music Directory'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a folder containing your music files (FLAC, WAV, ALAC)',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await FilePicker.platform.getDirectoryPath(
                    dialogTitle: 'Select Music Folder',
                  );

                  if (result != null && dialogContext.mounted) {
                    dialogContext.read<LibraryBloc>().add(
                      LibraryEvent.scanLibraryRequested(result),
                    );
                    Navigator.pop(dialogContext);
                  }
                },
                icon: const Icon(Icons.folder_open),
                label: const Text('Choose Folder'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
