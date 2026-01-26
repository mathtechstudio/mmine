import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/add_single_file_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_albums_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_artists_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_tracks_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_tracks_by_album_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_tracks_by_artist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/scan_directory_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/search_tracks_use_case.dart';

part 'library_bloc.freezed.dart';
part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetAllTracksUseCase getAllTracks;
  final GetAllArtistsUseCase getAllArtists;
  final GetAllAlbumsUseCase getAllAlbums;
  final GetTracksByArtistUseCase getTracksByArtist;
  final GetTracksByAlbumUseCase getTracksByAlbum;
  final ScanDirectoryUseCase scanDirectory;
  final AddSingleFileUseCase addSingleFile;
  final SearchTracksUseCase searchTracks;

  LibraryBloc({
    required this.getAllTracks,
    required this.getAllArtists,
    required this.getAllAlbums,
    required this.getTracksByArtist,
    required this.getTracksByAlbum,
    required this.scanDirectory,
    required this.addSingleFile,
    required this.searchTracks,
  }) : super(const LibraryState.initial()) {
    on<_LoadTracksRequested>(
      _onLoadTracksRequested,
      transformer: restartable(),
    );
    on<_LoadArtistsRequested>(
      _onLoadArtistsRequested,
      transformer: restartable(),
    );
    on<_LoadAlbumsRequested>(
      _onLoadAlbumsRequested,
      transformer: restartable(),
    );
    on<_ScanLibraryRequested>(
      _onScanLibraryRequested,
      transformer: droppable(),
    );
    on<_AddSingleFileRequested>(
      _onAddSingleFileRequested,
      transformer: droppable(),
    );
    on<_SearchQueryChanged>(_onSearchQueryChanged, transformer: restartable());
    on<_FilterByFormatRequested>(_onFilterByFormatRequested);
    on<_LoadTracksByArtistRequested>(
      _onLoadTracksByArtistRequested,
      transformer: restartable(),
    );
    on<_LoadTracksByAlbumRequested>(
      _onLoadTracksByAlbumRequested,
      transformer: restartable(),
    );
  }

  Future<void> _onLoadTracksRequested(
    _LoadTracksRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryState.loading());

    final result = await getAllTracks(const NoParams());

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (tracks) => emit(LibraryState.tracksLoaded(tracks: tracks)),
    );
  }

  Future<void> _onLoadArtistsRequested(
    _LoadArtistsRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryState.loading());

    final result = await getAllArtists(const NoParams());

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (artists) => emit(LibraryState.artistsLoaded(artists)),
    );
  }

  Future<void> _onLoadAlbumsRequested(
    _LoadAlbumsRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryState.loading());

    final result = await getAllAlbums(const NoParams());

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (albums) => emit(LibraryState.albumsLoaded(albums)),
    );
  }

  Future<void> _onScanLibraryRequested(
    _ScanLibraryRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryState.scanning(event.directoryPath));

    final result = await scanDirectory(event.directoryPath);

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (tracks) => emit(LibraryState.scanComplete(tracks.length)),
    );
  }

  Future<void> _onAddSingleFileRequested(
    _AddSingleFileRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryState.scanning(event.filePath));

    final result = await addSingleFile(event.filePath);

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (track) {
        if (track != null) {
          emit(const LibraryState.scanComplete(1));
        } else {
          emit(const LibraryState.scanComplete(0));
        }
      },
    );
  }

  Future<void> _onSearchQueryChanged(
    _SearchQueryChanged event,
    Emitter<LibraryState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LibraryEvent.loadTracksRequested());
      return;
    }

    emit(const LibraryState.loading());

    final result = await searchTracks(event.query);

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (tracks) =>
          emit(LibraryState.searchResults(results: tracks, query: event.query)),
    );
  }

  Future<void> _onFilterByFormatRequested(
    _FilterByFormatRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryState.loading());

    final result = await getAllTracks(const NoParams());

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (tracks) {
        final filteredTracks = event.format == null
            ? tracks
            : tracks.where((track) => track.format == event.format).toList();

        emit(
          LibraryState.tracksLoaded(
            tracks: filteredTracks,
            activeFilter: event.format,
          ),
        );
      },
    );
  }

  Future<void> _onLoadTracksByArtistRequested(
    _LoadTracksByArtistRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryState.loading());

    final result = await getTracksByArtist(event.artist);

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (tracks) => emit(LibraryState.tracksLoaded(tracks: tracks)),
    );
  }

  Future<void> _onLoadTracksByAlbumRequested(
    _LoadTracksByAlbumRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryState.loading());

    final result = await getTracksByAlbum(event.album);

    result.fold(
      (failure) => emit(LibraryState.error(_mapFailureToMessage(failure))),
      (tracks) => emit(LibraryState.tracksLoaded(tracks: tracks)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      FileNotFoundFailure() => 'File not found',
      PermissionDeniedFailure() => 'Permission denied',
      PlaybackFailure() => 'Playback error occurred',
      DatabaseFailure() => 'Database error occurred',
      MetadataExtractionFailure() => 'Failed to extract metadata',
      InvalidFormatFailure() => 'Invalid audio format',
      UnknownFailure() => 'An unexpected error occurred',
      _ => 'An unexpected error occurred',
    };
  }
}
