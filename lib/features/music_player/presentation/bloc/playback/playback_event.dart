part of 'playback_bloc.dart';

@freezed
sealed class PlaybackEvent with _$PlaybackEvent {
  const factory PlaybackEvent.playRequested(AudioTrack track) = _PlayRequested;

  const factory PlaybackEvent.pauseRequested() = _PauseRequested;

  const factory PlaybackEvent.resumeRequested() = _ResumeRequested;

  const factory PlaybackEvent.seekRequested(Duration position) = _SeekRequested;

  const factory PlaybackEvent.volumeChanged(double volume) = _VolumeChanged;

  const factory PlaybackEvent.speedChanged(double speed) = _SpeedChanged;

  const factory PlaybackEvent.playbackStateUpdated(
    PlaybackState playbackState,
  ) = _PlaybackStateUpdated;
}
