import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playlist.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/add_track_to_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/create_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/delete_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/get_all_playlists_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/remove_track_from_playlist_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playlist/reorder_playlist_tracks_use_case.dart';

part 'playlist_bloc.freezed.dart';
part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistBlocState> {
  final GetAllPlaylistsUseCase getAllPlaylists;
  final CreatePlaylistUseCase createPlaylist;
  final DeletePlaylistUseCase deletePlaylist;
  final AddTrackToPlaylistUseCase addTrackToPlaylist;
  final RemoveTrackFromPlaylistUseCase removeTrackFromPlaylist;
  final ReorderPlaylistTracksUseCase reorderPlaylistTracks;

  PlaylistBloc({
    required this.getAllPlaylists,
    required this.createPlaylist,
    required this.deletePlaylist,
    required this.addTrackToPlaylist,
    required this.removeTrackFromPlaylist,
    required this.reorderPlaylistTracks,
  }) : super(const PlaylistBlocState.initial()) {
    on<_LoadPlaylistsRequested>(_onLoadPlaylistsRequested);
    on<_CreatePlaylistRequested>(_onCreatePlaylistRequested);
    on<_DeletePlaylistRequested>(_onDeletePlaylistRequested);
    on<_AddTrackToPlaylistRequested>(_onAddTrackToPlaylistRequested);
    on<_RemoveTrackFromPlaylistRequested>(_onRemoveTrackFromPlaylistRequested);
    on<_ReorderPlaylistTracksRequested>(_onReorderPlaylistTracksRequested);
  }

  Future<void> _onLoadPlaylistsRequested(
    _LoadPlaylistsRequested event,
    Emitter<PlaylistBlocState> emit,
  ) async {
    emit(const PlaylistBlocState.loading());
    final result = await getAllPlaylists(NoParams());
    result.fold(
      (failure) => emit(PlaylistBlocState.error(failure.message)),
      (playlists) => emit(PlaylistBlocState.loaded(playlists)),
    );
  }

  Future<void> _onCreatePlaylistRequested(
    _CreatePlaylistRequested event,
    Emitter<PlaylistBlocState> emit,
  ) async {
    final result = await createPlaylist(event.name);
    result.fold(
      (failure) => emit(PlaylistBlocState.error(failure.message)),
      (_) => add(const PlaylistEvent.loadPlaylistsRequested()),
    );
  }

  Future<void> _onDeletePlaylistRequested(
    _DeletePlaylistRequested event,
    Emitter<PlaylistBlocState> emit,
  ) async {
    final result = await deletePlaylist(event.id);
    result.fold(
      (failure) => emit(PlaylistBlocState.error(failure.message)),
      (_) => add(const PlaylistEvent.loadPlaylistsRequested()),
    );
  }

  Future<void> _onAddTrackToPlaylistRequested(
    _AddTrackToPlaylistRequested event,
    Emitter<PlaylistBlocState> emit,
  ) async {
    final result = await addTrackToPlaylist(
      AddTrackToPlaylistParams(
        playlistId: event.playlistId,
        trackId: event.trackId,
      ),
    );
    result.fold(
      (failure) => emit(PlaylistBlocState.error(failure.message)),
      (_) => add(const PlaylistEvent.loadPlaylistsRequested()),
    );
  }

  Future<void> _onRemoveTrackFromPlaylistRequested(
    _RemoveTrackFromPlaylistRequested event,
    Emitter<PlaylistBlocState> emit,
  ) async {
    final result = await removeTrackFromPlaylist(
      RemoveTrackFromPlaylistParams(
        playlistId: event.playlistId,
        trackId: event.trackId,
      ),
    );
    result.fold(
      (failure) => emit(PlaylistBlocState.error(failure.message)),
      (_) => add(const PlaylistEvent.loadPlaylistsRequested()),
    );
  }

  Future<void> _onReorderPlaylistTracksRequested(
    _ReorderPlaylistTracksRequested event,
    Emitter<PlaylistBlocState> emit,
  ) async {
    final result = await reorderPlaylistTracks(
      ReorderPlaylistTracksParams(
        playlistId: event.playlistId,
        oldIndex: event.oldIndex,
        newIndex: event.newIndex,
      ),
    );
    result.fold(
      (failure) => emit(PlaylistBlocState.error(failure.message)),
      (_) => add(const PlaylistEvent.loadPlaylistsRequested()),
    );
  }
}
