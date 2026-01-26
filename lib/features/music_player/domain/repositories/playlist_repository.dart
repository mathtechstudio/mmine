import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';

/// Repository interface for playlist operations.
///
/// This abstract class defines the contract for playlist management in the
/// domain layer. It provides methods for:
/// - CRUD operations on playlists
/// - Managing tracks within playlists
/// - Reordering playlist tracks
///
/// All methods return [Either] type for functional error handling:
/// - Right: Successful operation with result
/// - Left: [Failure] if operation fails
///
/// Implementations should handle data persistence and error conversion.
abstract class PlaylistRepository {
  /// Retrieves all playlists from the repository.
  Future<Either<Failure, List<Playlist>>> getAllPlaylists();

  /// Retrieves a specific playlist by its ID.
  Future<Either<Failure, Playlist>> getPlaylistById(String id);

  /// Creates a new playlist with the given name.
  Future<Either<Failure, Playlist>> createPlaylist(String name);

  /// Updates an existing playlist's metadata.
  Future<Either<Failure, void>> updatePlaylist(Playlist playlist);

  /// Deletes a playlist and all its track associations.
  Future<Either<Failure, void>> deletePlaylist(String id);

  /// Adds a track to a playlist.
  Future<Either<Failure, void>> addTrackToPlaylist(
    String playlistId,
    String trackId,
  );

  /// Removes a track from a playlist.
  Future<Either<Failure, void>> removeTrackFromPlaylist(
    String playlistId,
    String trackId,
  );

  /// Reorders tracks within a playlist.
  Future<Either<Failure, void>> reorderPlaylistTracks(
    String playlistId,
    int oldIndex,
    int newIndex,
  );
}
