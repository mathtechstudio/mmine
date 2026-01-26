import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Failures represent errors that occur during business logic execution.
/// They are used with the Either type to provide functional error handling.
///
/// All failures extend [Equatable] to enable value-based equality comparison.
abstract class Failure extends Equatable {
  /// The error message describing what went wrong.
  final String message;

  /// Creates a [Failure] with the given error [message].
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure that occurs when a file is not found.
///
/// Used when attempting to access a file that doesn't exist on the file system.
class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure(super.message);
}

/// Failure that occurs when a required permission is denied.
///
/// Used when the user denies storage or media access permissions.
class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure(super.message);
}

/// Failure that occurs during audio playback operations.
///
/// Used when playback fails due to codec issues, corrupted files,
/// or audio player errors.
class PlaybackFailure extends Failure {
  const PlaybackFailure(super.message);
}

/// Failure that occurs during database operations.
///
/// Used when database queries, inserts, updates, or deletes fail.
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Failure that occurs during metadata extraction from audio files.
///
/// Used when reading metadata (title, artist, album art, etc.) fails.
class MetadataExtractionFailure extends Failure {
  const MetadataExtractionFailure(super.message);
}

/// Failure that occurs when an audio file has an invalid or unsupported format.
///
/// Used when attempting to play or process files that are not FLAC, WAV, or ALAC.
class InvalidFormatFailure extends Failure {
  const InvalidFormatFailure(super.message);
}

/// Failure for unexpected or unclassified errors.
///
/// Used as a fallback when the error doesn't fit into other failure categories.
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
