import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';

abstract class PlaylistRepository {
  Future<Either<Failure, List<Playlist>>> getAllPlaylists();
  Future<Either<Failure, Playlist>> getPlaylistById(String id);
  Future<Either<Failure, Playlist>> createPlaylist(String name);
  Future<Either<Failure, void>> updatePlaylist(Playlist playlist);
  Future<Either<Failure, void>> deletePlaylist(String id);
  Future<Either<Failure, void>> addTrackToPlaylist(
    String playlistId,
    String trackId,
  );
  Future<Either<Failure, void>> removeTrackFromPlaylist(
    String playlistId,
    String trackId,
  );
  Future<Either<Failure, void>> reorderPlaylistTracks(
    String playlistId,
    int oldIndex,
    int newIndex,
  );
}
