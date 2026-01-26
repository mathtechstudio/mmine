/// Extension methods for [Duration] objects.
///
/// Provides convenient formatting methods for displaying durations
/// in human-readable formats.
extension DurationExtension on Duration {
  /// Formats duration as "M:SS" (minutes:seconds).
  ///
  /// Example: Duration(seconds: 125) -> "2:05"
  String toMinutesSeconds() {
    final minutes = inMinutes;
    final seconds = inSeconds.remainder(60);
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats duration as "H:MM:SS" or "M:SS" depending on length.
  ///
  /// Shows hours only if duration is 1 hour or longer.
  ///
  /// Examples:
  /// - Duration(seconds: 125) -> "2:05"
  /// - Duration(seconds: 3725) -> "1:02:05"
  String toHoursMinutesSeconds() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

/// Extension methods for [String] objects.
///
/// Provides utility methods for string manipulation and validation.
extension StringExtension on String {
  /// Capitalizes the first character of the string.
  ///
  /// Example: "hello" -> "Hello"
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Checks if the string represents a lossless audio format.
  ///
  /// Returns true if the string ends with .flac, .wav, or .m4a (case-insensitive).
  bool get isLosslessFormat {
    final ext = toLowerCase();
    return ext.endsWith('.flac') ||
        ext.endsWith('.wav') ||
        ext.endsWith('.m4a');
  }
}

/// Extension methods for [int] objects.
///
/// Provides formatting methods for file sizes and audio sample rates.
extension IntExtension on int {
  /// Formats an integer as a human-readable file size.
  ///
  /// Examples:
  /// - 512 -> "512 B"
  /// - 2048 -> "2.0 KB"
  /// - 5242880 -> "5.0 MB"
  /// - 1073741824 -> "1.0 GB"
  String toFileSize() {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Formats an integer as a sample rate with appropriate units.
  ///
  /// Examples:
  /// - 441 -> "441 Hz"
  /// - 44100 -> "44.1 kHz"
  /// - 192000 -> "192.0 kHz"
  String toSampleRate() {
    if (this < 1000) return '$this Hz';
    return '${(this / 1000).toStringAsFixed(1)} kHz';
  }
}
