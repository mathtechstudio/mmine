import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/pause_playback_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/play_track_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/resume_playback_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/seek_to_position_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/set_speed_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/set_volume_use_case.dart';

part 'playback_bloc.freezed.dart';
part 'playback_event.dart';
part 'playback_state.dart';

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackBlocState> {
  final PlayTrackUseCase playTrack;
  final PausePlaybackUseCase pausePlayback;
  final ResumePlaybackUseCase resumePlayback;
  final SeekToPositionUseCase seekToPosition;
  final SetVolumeUseCase setVolume;
  final SetSpeedUseCase setSpeed;
  final PlaybackRepository playbackRepository;

  StreamSubscription<PlaybackState>? _playbackStateSubscription;

  PlaybackBloc({
    required this.playTrack,
    required this.pausePlayback,
    required this.resumePlayback,
    required this.seekToPosition,
    required this.setVolume,
    required this.setSpeed,
    required this.playbackRepository,
  }) : super(const PlaybackBlocState.initial()) {
    on<_PlayRequested>(_onPlayRequested);
    on<_PauseRequested>(_onPauseRequested);
    on<_ResumeRequested>(_onResumeRequested);
    on<_SeekRequested>(_onSeekRequested);
    on<_VolumeChanged>(_onVolumeChanged);
    on<_SpeedChanged>(_onSpeedChanged);
    on<_PlaybackStateUpdated>(_onPlaybackStateUpdated);

    _playbackStateSubscription = playbackRepository.playbackStateStream.listen((
      playbackState,
    ) {
      add(PlaybackEvent.playbackStateUpdated(playbackState));
    });
  }

  Future<void> _onPlayRequested(
    _PlayRequested event,
    Emitter<PlaybackBlocState> emit,
  ) async {
    emit(const PlaybackBlocState.loading());

    final result = await playTrack(event.track);

    result.fold(
      (failure) => emit(PlaybackBlocState.error(_mapFailureToMessage(failure))),
      (_) => null,
    );
  }

  Future<void> _onPauseRequested(
    _PauseRequested event,
    Emitter<PlaybackBlocState> emit,
  ) async {
    final result = await pausePlayback(const NoParams());

    result.fold(
      (failure) => emit(PlaybackBlocState.error(_mapFailureToMessage(failure))),
      (_) => null,
    );
  }

  Future<void> _onResumeRequested(
    _ResumeRequested event,
    Emitter<PlaybackBlocState> emit,
  ) async {
    final result = await resumePlayback(const NoParams());

    result.fold(
      (failure) => emit(PlaybackBlocState.error(_mapFailureToMessage(failure))),
      (_) => null,
    );
  }

  Future<void> _onSeekRequested(
    _SeekRequested event,
    Emitter<PlaybackBlocState> emit,
  ) async {
    final result = await seekToPosition(event.position);

    result.fold(
      (failure) => emit(PlaybackBlocState.error(_mapFailureToMessage(failure))),
      (_) => null,
    );
  }

  Future<void> _onVolumeChanged(
    _VolumeChanged event,
    Emitter<PlaybackBlocState> emit,
  ) async {
    final result = await setVolume(event.volume);

    result.fold(
      (failure) => emit(PlaybackBlocState.error(_mapFailureToMessage(failure))),
      (_) => null,
    );
  }

  Future<void> _onSpeedChanged(
    _SpeedChanged event,
    Emitter<PlaybackBlocState> emit,
  ) async {
    final result = await setSpeed(event.speed);

    result.fold(
      (failure) => emit(PlaybackBlocState.error(_mapFailureToMessage(failure))),
      (_) => null,
    );
  }

  void _onPlaybackStateUpdated(
    _PlaybackStateUpdated event,
    Emitter<PlaybackBlocState> emit,
  ) {
    emit(PlaybackBlocState.playing(event.playbackState));
  }

  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      FileNotFoundFailure() => 'File not found',
      PermissionDeniedFailure() => 'Permission denied',
      PlaybackFailure() => failure.message,
      DatabaseFailure() => 'Database error occurred',
      MetadataExtractionFailure() => 'Failed to extract metadata',
      InvalidFormatFailure() => 'Invalid audio format',
      UnknownFailure() => 'An unexpected error occurred',
      _ => 'An unexpected error occurred',
    };
  }

  @override
  Future<void> close() {
    unawaited(_playbackStateSubscription?.cancel());
    return super.close();
  }
}
