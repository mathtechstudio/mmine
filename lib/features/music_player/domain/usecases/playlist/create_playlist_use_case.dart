import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Use case for creating a new playlist.
///
/// This use case creates a new empty playlist with the given name.
/// The playlist is assigned a unique ID and timestamps are set automatically.
///
/// Parameters:
/// - [name]: The name for the new playlist
///
/// Returns:
/// - Right: The created [Playlist] object
/// - Left: [Failure] if the operation fails (e.g., empty name, database error)
///
/// Example:
/// ```dart
/// final useCase = CreatePlaylistUseCase(repository);
/// final result = await useCase('My Favorites');
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (playlist) => print('Created playlist: ${playlist.name}'),
/// );
/// ```
class CreatePlaylistUseCase implements UseCase<Playlist, String> {
  final PlaylistRepository repository;

  CreatePlaylistUseCase(this.repository);

  @override
  Future<Either<Failure, Playlist>> call(String name) async {
    return await repository.createPlaylist(name);
  }
}
