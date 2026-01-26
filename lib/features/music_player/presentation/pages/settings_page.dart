import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmine/features/music_player/presentation/bloc/library/library_bloc.dart';
import 'package:mmine/features/music_player/presentation/widgets/settings_switch_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _version = '';
  bool _gaplessPlayback = true;
  bool _autoScanOnStartup = false;
  bool _showAlbumArt = true;
  String _musicFolder = 'Not set';

  @override
  void initState() {
    super.initState();
    unawaited(_loadVersion());
    unawaited(_loadSettings());
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  Future<void> _loadSettings() async {
    // TODO: Load settings from persistent storage
    // For now, using default values
  }

  Future<void> _selectMusicFolder() async {
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Music Folder',
    );

    if (result != null && mounted) {
      setState(() {
        _musicFolder = result;
      });
      // TODO: Save to persistent storage
    }
  }

  Future<void> _scanLibrary() async {
    if (_musicFolder == 'Not set') {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a music folder first'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (!mounted) return;
    context.read<LibraryBloc>().add(
      LibraryEvent.scanLibraryRequested(_musicFolder),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Scanning library...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSection(
            title: 'Audio Settings',
            children: [
              SettingsSwitchTile(
                title: 'Gapless Playback',
                subtitle: 'Seamless transition between tracks',
                value: _gaplessPlayback,
                onChanged: (value) {
                  setState(() {
                    _gaplessPlayback = value;
                  });
                  // TODO: Save to persistent storage
                },
              ),
              ListTile(
                title: const Text('Audio Quality'),
                subtitle: const Text('Lossless (FLAC, WAV, ALAC)'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Show audio quality settings
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Library Settings',
            children: [
              ListTile(
                title: const Text('Music Folder'),
                subtitle: Text(_musicFolder),
                trailing: const Icon(Icons.chevron_right),
                onTap: _selectMusicFolder,
              ),
              ListTile(
                title: const Text('Scan Library'),
                subtitle: const Text('Rescan music folder for new tracks'),
                trailing: const Icon(Icons.refresh),
                onTap: _scanLibrary,
              ),
              SettingsSwitchTile(
                title: 'Auto-scan on Startup',
                subtitle: 'Automatically scan for new music',
                value: _autoScanOnStartup,
                onChanged: (value) {
                  setState(() {
                    _autoScanOnStartup = value;
                  });
                  // TODO: Save to persistent storage
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Appearance',
            children: [
              ListTile(
                title: const Text('Theme'),
                subtitle: const Text('System default'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Show theme picker
                },
              ),
              SettingsSwitchTile(
                title: 'Show Album Art',
                subtitle: 'Display album artwork in lists',
                value: _showAlbumArt,
                onChanged: (value) {
                  setState(() {
                    _showAlbumArt = value;
                  });
                  // TODO: Save to persistent storage
                },
              ),
            ],
          ),
          _buildSection(
            title: 'About',
            children: [
              ListTile(
                title: const Text('Version'),
                subtitle: Text(_version.isEmpty ? 'Loading...' : _version),
              ),
              ListTile(
                title: const Text('Mmine'),
                subtitle: const Text('Lossless Music Player'),
              ),
              ListTile(
                title: const Text('Licenses'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationName: 'Mmine',
                    applicationVersion: _version,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }
}
