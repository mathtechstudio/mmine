part of 'playlist_bloc.dart';

@freezed
class PlaylistEvent with _$PlaylistEvent {
  const factory PlaylistEvent.loadPlaylistsRequested() =
      _LoadPlaylistsRequested;
  const factory PlaylistEvent.createPlaylistRequested(String name) =
      _CreatePlaylistRequested;
  const factory PlaylistEvent.deletePlaylistRequested(String id) =
      _DeletePlaylistRequested;
  const factory PlaylistEvent.addTrackToPlaylistRequested(
    String playlistId,
    String trackId,
  ) = _AddTrackToPlaylistRequested;
  const factory PlaylistEvent.removeTrackFromPlaylistRequested(
    String playlistId,
    String trackId,
  ) = _RemoveTrackFromPlaylistRequested;
  const factory PlaylistEvent.reorderPlaylistTracksRequested(
    String playlistId,
    int oldIndex,
    int newIndex,
  ) = _ReorderPlaylistTracksRequested;
}
