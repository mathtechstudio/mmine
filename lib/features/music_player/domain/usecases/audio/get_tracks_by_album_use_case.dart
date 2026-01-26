import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for retrieving all tracks from a specific album.
///
/// This use case fetches all audio tracks that belong to the specified album.
/// The album name must match exactly (case-sensitive).
///
/// Parameters:
/// - [album]: The name of the album to filter by
///
/// Returns:
/// - Right: List of [AudioTrack] objects (may be empty if album not found)
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = GetTracksByAlbumUseCase(repository);
/// final result = await useCase('Abbey Road');
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (tracks) => print('Found ${tracks.length} tracks'),
/// );
/// ```
class GetTracksByAlbumUseCase implements UseCase<List<AudioTrack>, String> {
  final AudioRepository repository;

  GetTracksByAlbumUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(String album) async {
    return await repository.getTracksByAlbum(album);
  }
}
