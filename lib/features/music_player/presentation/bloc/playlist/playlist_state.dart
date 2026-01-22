part of 'playlist_bloc.dart';

@freezed
class PlaylistBlocState with _$PlaylistBlocState {
  const factory PlaylistBlocState.initial() = _Initial;
  const factory PlaylistBlocState.loading() = _Loading;
  const factory PlaylistBlocState.loaded(List<Playlist> playlists) = _Loaded;
  const factory PlaylistBlocState.error(String message) = _Error;
}
