import 'package:mmine/features/music_player/data/datasources/database.dart'
    as db;
import 'package:mmine/features/music_player/domain/entities/playlist.dart'
    as entity;

/// Model class for converting between Drift database playlists and domain entities.
///
/// This class provides conversion methods to transform playlist data from
/// the database layer (Drift) to the domain layer (entities).
///
/// The conversion includes:
/// - Playlist metadata (id, name, timestamps)
/// - Associated track IDs
/// - Timestamp conversion from milliseconds to DateTime
class PlaylistModel {
  /// Converts a Drift [Playlist] to a domain [Playlist] entity.
  ///
  /// Parameters:
  /// - [playlist]: The Drift playlist object from the database
  /// - [trackIds]: List of track IDs associated with this playlist
  ///
  /// Returns a domain [Playlist] entity with converted timestamps.
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
