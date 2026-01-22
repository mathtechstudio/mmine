import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/data/datasources/playlist_data_source.dart';
import 'package:mmine/features/music_player/data/models/playlist_model.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/repositories/playlist_repository.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final PlaylistDataSource playlistDataSource;

  PlaylistRepositoryImpl({required this.playlistDataSource});

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
