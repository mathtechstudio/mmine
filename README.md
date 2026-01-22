# mmine - Lossless Music Player

A high-fidelity music player for Flutter that exclusively supports lossless audio formats (FLAC, WAV, ALAC).

## Features

- 🎵 Lossless audio support (FLAC, WAV, ALAC)
- 🎧 Bit-perfect playback
- 📚 Library management with metadata
- 🎼 Playlist creation and management
- ⏯️ Queue management
- 🔁 Repeat and shuffle modes
- 🎚️ Volume and speed controls
- 📱 Background playback
- 🔒 Lock screen controls

## Architecture

Built with Clean Architecture:
- **Presentation Layer**: BLoC pattern for state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Repositories and data sources

## Tech Stack

- Flutter & Dart
- BLoC for state management
- Drift for local database
- just_audio for audio playback
- Freezed for immutable models

## Getting Started

```bash
# Get dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Development

See [AGENTS.md](AGENTS.md) for development guidelines and workflow.

## License

This project is licensed under the MIT License.
