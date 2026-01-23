import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    unawaited(_loadVersion());
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${packageInfo.version} (${packageInfo.buildNumber})';
    });
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
              SwitchListTile(
                title: const Text('Gapless Playback'),
                subtitle: const Text('Seamless transition between tracks'),
                value: true,
                onChanged: (value) {
                  // TODO: Implement gapless playback toggle
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
                subtitle: const Text('Tap to change music directory'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Show folder picker
                },
              ),
              ListTile(
                title: const Text('Scan Library'),
                subtitle: const Text('Rescan music folder for new tracks'),
                trailing: const Icon(Icons.refresh),
                onTap: () {
                  // TODO: Trigger library scan
                },
              ),
              SwitchListTile(
                title: const Text('Auto-scan on Startup'),
                subtitle: const Text('Automatically scan for new music'),
                value: false,
                onChanged: (value) {
                  // TODO: Implement auto-scan toggle
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
              SwitchListTile(
                title: const Text('Show Album Art'),
                subtitle: const Text('Display album artwork in lists'),
                value: true,
                onChanged: (value) {
                  // TODO: Implement album art toggle
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
