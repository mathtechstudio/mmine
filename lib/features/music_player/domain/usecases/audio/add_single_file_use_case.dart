import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for adding a single audio file to the library.
///
/// This use case handles the business logic for adding a single audio file
/// to the library. It validates the file format, extracts metadata, and
/// stores the track in the database.
///
/// The process:
/// 1. Validates the file format (FLAC, WAV, ALAC)
/// 2. Checks for duplicates
/// 3. Extracts metadata from the file
/// 4. Stores the track in the database
///
/// Example usage:
/// ```dart
/// final result = await addSingleFileUseCase('/storage/emulated/0/Music/song.flac');
/// result.fold(
///   (failure) => print('Failed to add file: $failure'),
///   (track) => print('Added track: ${track?.title}'),
/// );
/// ```
class AddSingleFileUseCase implements UseCase<AudioTrack?, String> {
  final AudioRepository repository;

  /// Creates an [AddSingleFileUseCase] with the given [repository].
  AddSingleFileUseCase(this.repository);

  /// Adds the audio file at [filePath] to the library.
  ///
  /// Returns [Right] with the [AudioTrack] if successfully added,
  /// [Right] with null if the file already exists (duplicate),
  /// or [Left] with a [Failure] if adding fails (e.g., invalid format,
  /// permission denied, metadata extraction error).
  @override
  Future<Either<Failure, AudioTrack?>> call(String filePath) async {
    return await repository.addSingleFile(filePath);
  }
}
