class AppConstants {
  // Audio formats
  static const List<String> losslessExtensions = ['.flac', '.wav', '.m4a'];
  static const List<String> losslessFormats = ['FLAC', 'WAV', 'ALAC'];

  // Database
  static const String databaseName = 'music_player.db';
  static const int databaseVersion = 1;

  // Audio quality
  static const int minBitDepth = 16;
  static const int maxBitDepth = 32;
  static const int minSampleRate = 44100;
  static const int maxSampleRate = 384000;

  // Playback
  static const double minVolume = 0.0;
  static const double maxVolume = 1.0;
  static const double minSpeed = 0.5;
  static const double maxSpeed = 2.0;
  static const List<double> speedPresets = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  // UI
  static const int maxRecentSearches = 10;
  static const Duration debounceDelay = Duration(milliseconds: 300);
}
