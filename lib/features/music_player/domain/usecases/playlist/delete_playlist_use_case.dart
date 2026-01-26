import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Use case for deleting a playlist.
///
/// This use case permanently deletes a playlist and all its track associations
/// from the database. The actual audio files are not deleted, only the
/// playlist and its references.
///
/// Parameters:
/// - [id]: The ID of the playlist to delete
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails (e.g., playlist not found)
///
/// Example:
/// ```dart
/// final useCase = DeletePlaylistUseCase(repository);
/// final result = await useCase('playlist-123');
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Playlist deleted'),
/// );
/// ```
class DeletePlaylistUseCase implements UseCase<void, String> {
  final PlaylistRepository repository;

  DeletePlaylistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deletePlaylist(id);
  }
}
