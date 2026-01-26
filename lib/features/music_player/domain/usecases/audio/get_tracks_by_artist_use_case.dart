import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for retrieving all tracks from a specific artist.
///
/// This use case fetches all audio tracks that belong to the specified artist.
/// The artist name must match exactly (case-sensitive).
///
/// Parameters:
/// - [artist]: The name of the artist to filter by
///
/// Returns:
/// - Right: List of [AudioTrack] objects (may be empty if artist not found)
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = GetTracksByArtistUseCase(repository);
/// final result = await useCase('The Beatles');
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (tracks) => print('Found ${tracks.length} tracks'),
/// );
/// ```
class GetTracksByArtistUseCase implements UseCase<List<AudioTrack>, String> {
  final AudioRepository repository;

  GetTracksByArtistUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(String artist) async {
    return await repository.getTracksByArtist(artist);
  }
}
