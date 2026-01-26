/// Application-wide constants for the music player.
///
/// This class contains all constant values used throughout the application
/// including:
/// - Supported audio formats and extensions
/// - Database configuration
/// - Audio quality constraints
/// - Playback settings
/// - UI configuration
class AppConstants {
  // Audio formats
  /// Supported lossless audio file extensions.
  static const List<String> losslessExtensions = ['.flac', '.wav', '.m4a'];

  /// Supported lossless audio format names.
  static const List<String> losslessFormats = ['FLAC', 'WAV', 'ALAC'];

  // Database
  /// Name of the SQLite database file.
  static const String databaseName = 'music_player.db';

  /// Current database schema version.
  static const int databaseVersion = 1;

  // Audio quality
  /// Minimum supported bit depth for audio files.
  static const int minBitDepth = 16;

  /// Maximum supported bit depth for audio files.
  static const int maxBitDepth = 32;

  /// Minimum supported sample rate (44.1 kHz).
  static const int minSampleRate = 44100;

  /// Maximum supported sample rate (384 kHz).
  static const int maxSampleRate = 384000;

  // Playback
  /// Minimum volume level (muted).
  static const double minVolume = 0.0;

  /// Maximum volume level (full volume).
  static const double maxVolume = 1.0;

  /// Minimum playback speed (half speed).
  static const double minSpeed = 0.5;

  /// Maximum playback speed (double speed).
  static const double maxSpeed = 2.0;

  /// Preset playback speed options.
  static const List<double> speedPresets = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  // UI
  /// Maximum number of recent searches to store.
  static const int maxRecentSearches = 10;

  /// Debounce delay for search input.
  static const Duration debounceDelay = Duration(milliseconds: 300);
}
