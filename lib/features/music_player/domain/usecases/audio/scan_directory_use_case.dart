import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for scanning a directory for audio files.
///
/// This use case handles the business logic for scanning a directory
/// and its subdirectories for supported audio files (FLAC, WAV, ALAC).
/// It extracts metadata from each file and adds them to the library.
///
/// The scanning process:
/// 1. Recursively traverses the directory
/// 2. Filters for supported audio formats
/// 3. Extracts metadata from each file
/// 4. Stores tracks in the database
///
/// Example usage:
/// ```dart
/// final result = await scanDirectoryUseCase('/storage/emulated/0/Music');
/// result.fold(
///   (failure) => print('Scan failed: $failure'),
///   (tracks) => print('Found ${tracks.length} tracks'),
/// );
/// ```
class ScanDirectoryUseCase implements UseCase<List<AudioTrack>, String> {
  final AudioRepository repository;

  /// Creates a [ScanDirectoryUseCase] with the given [repository].
  ScanDirectoryUseCase(this.repository);

  /// Scans the directory at [path] for audio files.
  ///
  /// Returns [Right] with a list of [AudioTrack]s found, or [Left] with
  /// a [Failure] if scanning fails (e.g., permission denied, path not found).
  @override
  Future<Either<Failure, List<AudioTrack>>> call(String path) async {
    return await repository.scanDirectory(path);
  }
}
