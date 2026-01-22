part of 'playback_bloc.dart';

@freezed
sealed class PlaybackBlocState with _$PlaybackBlocState {
  const factory PlaybackBlocState.initial() = _Initial;

  const factory PlaybackBlocState.loading() = _Loading;

  const factory PlaybackBlocState.playing(PlaybackState playbackState) =
      _Playing;

  const factory PlaybackBlocState.error(String message) = _Error;
}
