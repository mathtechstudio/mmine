part of 'library_bloc.dart';

@freezed
sealed class LibraryState with _$LibraryState {
  const factory LibraryState.initial() = _Initial;

  const factory LibraryState.loading() = _Loading;

  const factory LibraryState.scanning(String directoryPath) = _Scanning;

  const factory LibraryState.tracksLoaded({
    required List<AudioTrack> tracks,
    AudioFormat? activeFilter,
  }) = _TracksLoaded;

  const factory LibraryState.artistsLoaded(List<String> artists) =
      _ArtistsLoaded;

  const factory LibraryState.albumsLoaded(List<String> albums) = _AlbumsLoaded;

  const factory LibraryState.searchResults({
    required List<AudioTrack> results,
    required String query,
  }) = _SearchResults;

  const factory LibraryState.scanComplete(int tracksAdded) = _ScanComplete;

  const factory LibraryState.error(String message) = _Error;
}
