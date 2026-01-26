import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for retrieving all audio tracks from the library.
///
/// This use case fetches all audio tracks stored in the local database.
/// The tracks are returned with their complete metadata including title,
/// artist, album, duration, and audio quality information.
///
/// Returns:
/// - Right: List of [AudioTrack] objects (may be empty if no tracks exist)
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = GetAllTracksUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (tracks) => print('Found ${tracks.length} tracks'),
/// );
/// ```
class GetAllTracksUseCase implements UseCase<List<AudioTrack>, NoParams> {
  final AudioRepository repository;

  GetAllTracksUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(NoParams params) async {
    return await repository.getAllTracks();
  }
}
