part of 'library_bloc.dart';

@freezed
sealed class LibraryEvent with _$LibraryEvent {
  const factory LibraryEvent.loadTracksRequested() = _LoadTracksRequested;

  const factory LibraryEvent.loadArtistsRequested() = _LoadArtistsRequested;

  const factory LibraryEvent.loadAlbumsRequested() = _LoadAlbumsRequested;

  const factory LibraryEvent.scanLibraryRequested(String directoryPath) =
      _ScanLibraryRequested;

  const factory LibraryEvent.searchQueryChanged(String query) =
      _SearchQueryChanged;

  const factory LibraryEvent.filterByFormatRequested(AudioFormat? format) =
      _FilterByFormatRequested;

  const factory LibraryEvent.loadTracksByArtistRequested(String artist) =
      _LoadTracksByArtistRequested;

  const factory LibraryEvent.loadTracksByAlbumRequested(String album) =
      _LoadTracksByAlbumRequested;
}
