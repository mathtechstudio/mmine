# mmine

A Flutter application for local playback of lossless audio formats.

## Overview

mmine is a mobile music player designed for playback of lossless audio files stored locally on the device. The application provides library management, playlist organization, and standard playback controls.

## Supported Formats

- **FLAC** (Free Lossless Audio Codec) - `.flac`
- **WAV** (Waveform Audio File Format) - `.wav`
- **ALAC** (Apple Lossless Audio Codec) - `.m4a`

## Features

### Audio Library

- Local directory scanning
- Metadata extraction from embedded tags
- Organization by artist, album, and genre
- Search and filtering capabilities

### Playback Control

- Standard playback operations (play, pause, stop, seek)
- Queue management
- Repeat modes (off, all, single)
- Shuffle mode
- Volume and speed adjustment
- Gapless playback
- Background audio playback
- System media controls integration

### Playlist Management

- Create and manage playlists
- Add and remove tracks
- Reorder playlist items
- Persistent storage

## Architecture

The application implements Clean Architecture with separation across three layers:

- **Presentation Layer**: User interface and state management using BLoC pattern
- **Domain Layer**: Business logic, use cases, and repository interfaces
- **Data Layer**: Repository implementations, data sources, and external integrations

## Installation

Clone the repository:

```bash
git clone https://github.com/mathtechstudio/mmine.git
cd mmine
```

Install dependencies:

```bash
flutter pub get
```

Generate required code files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run the application:

```bash
flutter run
```

## Usage

### Initial Setup

1. Launch the application
2. Grant storage permissions when prompted
3. Select directories containing audio files
4. Wait for library scanning to complete

### Playing Audio

1. Navigate to the library view
2. Browse by songs, artists, or albums
3. Select a track to begin playback
4. Use playback controls for queue management

### Managing Playlists

1. Navigate to the playlists view
2. Create a new playlist
3. Add tracks from the library
4. Reorder or remove tracks as needed

## Contributing

Contributions are welcome. Please ensure that:

1. Code follows the project's architecture patterns
2. All changes are properly tested
3. Static analysis passes without errors
4. Pull requests include clear descriptions of changes

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

---

**Status**: Under active development. Features and APIs are subject to change.
