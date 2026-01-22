import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/add_to_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/clear_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/play_next_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/remove_from_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/reorder_queue_use_case.dart';

part 'queue_bloc.freezed.dart';
part 'queue_event.dart';
part 'queue_state.dart';

class QueueBloc extends Bloc<QueueEvent, QueueBlocState> {
  final AddToQueueUseCase addToQueue;
  final PlayNextUseCase playNext;
  final RemoveFromQueueUseCase removeFromQueue;
  final ReorderQueueUseCase reorderQueue;
  final ClearQueueUseCase clearQueue;
  final PlaybackRepository playbackRepository;

  StreamSubscription<PlaybackState>? _playbackStateSubscription;

  QueueBloc({
    required this.addToQueue,
    required this.playNext,
    required this.removeFromQueue,
    required this.reorderQueue,
    required this.clearQueue,
    required this.playbackRepository,
  }) : super(const QueueBlocState.initial()) {
    on<_LoadQueueRequested>(_onLoadQueueRequested);
    on<_AddToQueueRequested>(_onAddToQueueRequested);
    on<_PlayNextRequested>(_onPlayNextRequested);
    on<_RemoveFromQueueRequested>(_onRemoveFromQueueRequested);
    on<_ReorderQueueRequested>(_onReorderQueueRequested);
    on<_ClearQueueRequested>(_onClearQueueRequested);
    on<_QueueStateUpdated>(_onQueueStateUpdated);

    _playbackStateSubscription = playbackRepository.playbackStateStream.listen((
      playbackState,
    ) {
      add(QueueEvent.queueStateUpdated(playbackState));
    });
  }

  Future<void> _onLoadQueueRequested(
    _LoadQueueRequested event,
    Emitter<QueueBlocState> emit,
  ) async {
    emit(const QueueBlocState.loading());
  }

  Future<void> _onAddToQueueRequested(
    _AddToQueueRequested event,
    Emitter<QueueBlocState> emit,
  ) async {
    final result = await addToQueue(event.tracks);
    result.fold(
      (failure) => emit(QueueBlocState.error(failure.message)),
      (_) {},
    );
  }

  Future<void> _onPlayNextRequested(
    _PlayNextRequested event,
    Emitter<QueueBlocState> emit,
  ) async {
    final result = await playNext(event.tracks);
    result.fold(
      (failure) => emit(QueueBlocState.error(failure.message)),
      (_) {},
    );
  }

  Future<void> _onRemoveFromQueueRequested(
    _RemoveFromQueueRequested event,
    Emitter<QueueBlocState> emit,
  ) async {
    final result = await removeFromQueue(event.index);
    result.fold(
      (failure) => emit(QueueBlocState.error(failure.message)),
      (_) {},
    );
  }

  Future<void> _onReorderQueueRequested(
    _ReorderQueueRequested event,
    Emitter<QueueBlocState> emit,
  ) async {
    final result = await reorderQueue(
      ReorderQueueParams(oldIndex: event.oldIndex, newIndex: event.newIndex),
    );
    result.fold(
      (failure) => emit(QueueBlocState.error(failure.message)),
      (_) {},
    );
  }

  Future<void> _onClearQueueRequested(
    _ClearQueueRequested event,
    Emitter<QueueBlocState> emit,
  ) async {
    final result = await clearQueue(NoParams());
    result.fold(
      (failure) => emit(QueueBlocState.error(failure.message)),
      (_) => emit(const QueueBlocState.initial()),
    );
  }

  void _onQueueStateUpdated(
    _QueueStateUpdated event,
    Emitter<QueueBlocState> emit,
  ) {
    final playbackState = event.playbackState;
    if (playbackState.queue.isEmpty) {
      emit(const QueueBlocState.initial());
    } else {
      emit(
        QueueBlocState.loaded(
          queue: playbackState.queue,
          currentIndex: playbackState.currentIndex,
          currentTrack: playbackState.currentTrack,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _playbackStateSubscription?.cancel();
    return super.close();
  }
}
