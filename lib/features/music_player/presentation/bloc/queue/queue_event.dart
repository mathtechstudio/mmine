part of 'queue_bloc.dart';

@freezed
class QueueEvent with _$QueueEvent {
  const factory QueueEvent.loadQueueRequested() = _LoadQueueRequested;
  const factory QueueEvent.addToQueueRequested(List<AudioTrack> tracks) =
      _AddToQueueRequested;
  const factory QueueEvent.playNextRequested(List<AudioTrack> tracks) =
      _PlayNextRequested;
  const factory QueueEvent.removeFromQueueRequested(int index) =
      _RemoveFromQueueRequested;
  const factory QueueEvent.reorderQueueRequested(int oldIndex, int newIndex) =
      _ReorderQueueRequested;
  const factory QueueEvent.clearQueueRequested() = _ClearQueueRequested;
  const factory QueueEvent.queueStateUpdated(PlaybackState playbackState) =
      _QueueStateUpdated;
}
