import 'package:mmine/features/music_player/data/datasources/database.dart'
    as db;
import 'package:mmine/features/music_player/domain/entities/playlist.dart'
    as entity;

class PlaylistModel {
  static entity.Playlist fromDrift(
    db.Playlist playlist,
    List<String> trackIds,
  ) {
    return entity.Playlist(
      id: playlist.id,
      name: playlist.name,
      trackIds: trackIds,
      createdAt: DateTime.fromMillisecondsSinceEpoch(playlist.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(playlist.updatedAt),
    );
  }
}
