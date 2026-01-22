part of 'queue_bloc.dart';

@freezed
class QueueBlocState with _$QueueBlocState {
  const factory QueueBlocState.initial() = _Initial;
  const factory QueueBlocState.loading() = _Loading;
  const factory QueueBlocState.loaded({
    required List<AudioTrack> queue,
    required int currentIndex,
    AudioTrack? currentTrack,
  }) = _Loaded;
  const factory QueueBlocState.error(String message) = _Error;
}
