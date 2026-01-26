import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for searching tracks by title, artist, or album.
///
/// This use case performs a case-insensitive search across track metadata
/// (title, artist, album) and returns all matching tracks.
///
/// Parameters:
/// - [query]: The search query string
///
/// Returns:
/// - Right: List of matching [AudioTrack] objects (empty if no matches or empty query)
/// - Left: [Failure] if the operation fails
///
/// Note: Empty or whitespace-only queries return an empty list without
/// querying the repository.
///
/// Example:
/// ```dart
/// final useCase = SearchTracksUseCase(repository);
/// final result = await useCase('yesterday');
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (tracks) => print('Found ${tracks.length} matching tracks'),
/// );
/// ```
class SearchTracksUseCase implements UseCase<List<AudioTrack>, String> {
  final AudioRepository repository;

  SearchTracksUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.searchTracks(query);
  }
}
