import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Use case for retrieving all playlists from the library.
///
/// This use case fetches all user-created playlists along with their
/// associated tracks.
///
/// Returns:
/// - Right: List of [Playlist] objects (may be empty if no playlists exist)
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = GetAllPlaylistsUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (playlists) => print('Found ${playlists.length} playlists'),
/// );
/// ```
class GetAllPlaylistsUseCase implements UseCase<List<Playlist>, NoParams> {
  final PlaylistRepository repository;

  GetAllPlaylistsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Playlist>>> call(NoParams params) async {
    return await repository.getAllPlaylists();
  }
}
