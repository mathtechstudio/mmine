import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/data/datasources/playlist_data_source.dart';
import 'package:mmine/features/music_player/data/models/playlist_model.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

/// Implementation of [PlaylistRepository] using local database.
///
/// This repository provides playlist management functionality by coordinating
/// between the domain layer and the data source layer. It handles:
/// - CRUD operations for playlists
/// - Track management within playlists
/// - Track reordering
/// - Error handling and conversion to domain failures
///
/// All operations are performed on the local SQLite database through the
/// [PlaylistDataSource].
class PlaylistRepositoryImpl implements PlaylistRepository {
  final PlaylistDataSource playlistDataSource;

  /// Creates a [PlaylistRepositoryImpl] with the required data source.
  PlaylistRepositoryImpl({required this.playlistDataSource});

  /// Retrieves all playlists with their associated track IDs.
  ///
  /// Returns a list of playlists or a [DatabaseFailure] if the operation fails.
  @override
  Future<Either<Failure, List<Playlist>>> getAllPlaylists() async {
    try {
      final playlists = await playlistDataSource.getAllPlaylists();
      final result = <Playlist>[];

      for (final playlist in playlists) {
        final trackIds = await playlistDataSource.getPlaylistTrackIds(
          playlist.id,
        );
        result.add(PlaylistModel.fromDrift(playlist, trackIds));
      }

      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get playlists: ${e.toString()}'));
    }
  }

  /// Retrieves a specific playlist by its ID.
  ///
  /// Returns the playlist with its track IDs or a [DatabaseFailure] if:
  /// - The playlist is not found
  /// - The operation fails
  @override
  Future<Either<Failure, Playlist>> getPlaylistById(String id) async {
    try {
      final playlist = await playlistDataSource.getPlaylistById(id);
      if (playlist == null) {
        return Left(DatabaseFailure('Playlist not found'));
      }

      final trackIds = await playlistDataSource.getPlaylistTrackIds(id);
      return Right(PlaylistModel.fromDrift(playlist, trackIds));
    } catch (e) {
      return Left(DatabaseFailure('Failed to get playlist: ${e.toString()}'));
    }
  }

  /// Creates a new playlist with the given name.
  ///
  /// The name is trimmed of whitespace. Returns a [DatabaseFailure] if:
  /// - The name is empty or whitespace-only
  /// - The operation fails
  @override
  Future<Either<Failure, Playlist>> createPlaylist(String name) async {
    try {
      if (name.trim().isEmpty) {
        return Left(DatabaseFailure('Playlist name cannot be empty'));
      }

      final playlist = await playlistDataSource.createPlaylist(name.trim());
      return Right(PlaylistModel.fromDrift(playlist, []));
    } catch (e) {
      return Left(
        DatabaseFailure('Failed to create playlist: ${e.toString()}'),
      );
    }
  }

  /// Updates an existing playlist's metadata.
  ///
  /// Currently only the name can be updated. Returns a [DatabaseFailure] if:
  /// - The playlist is not found
  /// - The operation fails
  @override
  Future<Either<Failure, void>> updatePlaylist(Playlist playlist) async {
    try {
      final driftPlaylist = await playlistDataSource.getPlaylistById(
        playlist.id,
      );
      if (driftPlaylist == null) {
        return Left(DatabaseFailure('Playlist not found'));
      }

      await playlistDataSource.updatePlaylist(
        driftPlaylist.copyWith(name: playlist.name),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure('Failed to update playlist: ${e.toString()}'),
      );
    }
  }

  /// Deletes a playlist and all its track associations.
  ///
  /// Note: This does not delete the actual audio files, only the playlist
  /// and its track references.
  ///
  /// Returns a [DatabaseFailure] if the operation fails.
  @override
  Future<Either<Failure, void>> deletePlaylist(String id) async {
    try {
      await playlistDataSource.deletePlaylist(id);
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure('Failed to delete playlist: ${e.toString()}'),
      );
    }
  }

  /// Adds a track to a playlist.
  ///
  /// The track is added at the end of the playlist. If the track already
  /// exists in the playlist, it will be replaced.
  ///
  /// Returns a [DatabaseFailure] if the operation fails.
  @override
  Future<Either<Failure, void>> addTrackToPlaylist(
    String playlistId,
    String trackId,
  ) async {
    try {
      await playlistDataSource.addTrackToPlaylist(playlistId, trackId);
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure('Failed to add track to playlist: ${e.toString()}'),
      );
    }
  }

  /// Removes a track from a playlist.
  ///
  /// After removal, the remaining tracks are automatically reordered to
  /// maintain sequential positions.
  ///
  /// Returns a [DatabaseFailure] if the operation fails.
  @override
  Future<Either<Failure, void>> removeTrackFromPlaylist(
    String playlistId,
    String trackId,
  ) async {
    try {
      await playlistDataSource.removeTrackFromPlaylist(playlistId, trackId);
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure(
          'Failed to remove track from playlist: ${e.toString()}',
        ),
      );
    }
  }

  /// Reorders tracks within a playlist.
  ///
  /// Moves a track from [oldIndex] to [newIndex] and updates all affected
  /// track positions accordingly.
  ///
  /// Returns a [DatabaseFailure] if the operation fails or indices are invalid.
  @override
  Future<Either<Failure, void>> reorderPlaylistTracks(
    String playlistId,
    int oldIndex,
    int newIndex,
  ) async {
    try {
      await playlistDataSource.reorderPlaylistTracks(
        playlistId,
        oldIndex,
        newIndex,
      );
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure('Failed to reorder playlist: ${e.toString()}'),
      );
    }
  }
}
