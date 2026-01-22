// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaybackEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackEvent()';
}


}

/// @nodoc
class $PlaybackEventCopyWith<$Res>  {
$PlaybackEventCopyWith(PlaybackEvent _, $Res Function(PlaybackEvent) __);
}


/// Adds pattern-matching-related methods to [PlaybackEvent].
extension PlaybackEventPatterns on PlaybackEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PlayRequested value)?  playRequested,TResult Function( _PauseRequested value)?  pauseRequested,TResult Function( _ResumeRequested value)?  resumeRequested,TResult Function( _SeekRequested value)?  seekRequested,TResult Function( _VolumeChanged value)?  volumeChanged,TResult Function( _SpeedChanged value)?  speedChanged,TResult Function( _SkipToNextRequested value)?  skipToNextRequested,TResult Function( _SkipToPreviousRequested value)?  skipToPreviousRequested,TResult Function( _PlaybackStateUpdated value)?  playbackStateUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayRequested() when playRequested != null:
return playRequested(_that);case _PauseRequested() when pauseRequested != null:
return pauseRequested(_that);case _ResumeRequested() when resumeRequested != null:
return resumeRequested(_that);case _SeekRequested() when seekRequested != null:
return seekRequested(_that);case _VolumeChanged() when volumeChanged != null:
return volumeChanged(_that);case _SpeedChanged() when speedChanged != null:
return speedChanged(_that);case _SkipToNextRequested() when skipToNextRequested != null:
return skipToNextRequested(_that);case _SkipToPreviousRequested() when skipToPreviousRequested != null:
return skipToPreviousRequested(_that);case _PlaybackStateUpdated() when playbackStateUpdated != null:
return playbackStateUpdated(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PlayRequested value)  playRequested,required TResult Function( _PauseRequested value)  pauseRequested,required TResult Function( _ResumeRequested value)  resumeRequested,required TResult Function( _SeekRequested value)  seekRequested,required TResult Function( _VolumeChanged value)  volumeChanged,required TResult Function( _SpeedChanged value)  speedChanged,required TResult Function( _SkipToNextRequested value)  skipToNextRequested,required TResult Function( _SkipToPreviousRequested value)  skipToPreviousRequested,required TResult Function( _PlaybackStateUpdated value)  playbackStateUpdated,}){
final _that = this;
switch (_that) {
case _PlayRequested():
return playRequested(_that);case _PauseRequested():
return pauseRequested(_that);case _ResumeRequested():
return resumeRequested(_that);case _SeekRequested():
return seekRequested(_that);case _VolumeChanged():
return volumeChanged(_that);case _SpeedChanged():
return speedChanged(_that);case _SkipToNextRequested():
return skipToNextRequested(_that);case _SkipToPreviousRequested():
return skipToPreviousRequested(_that);case _PlaybackStateUpdated():
return playbackStateUpdated(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PlayRequested value)?  playRequested,TResult? Function( _PauseRequested value)?  pauseRequested,TResult? Function( _ResumeRequested value)?  resumeRequested,TResult? Function( _SeekRequested value)?  seekRequested,TResult? Function( _VolumeChanged value)?  volumeChanged,TResult? Function( _SpeedChanged value)?  speedChanged,TResult? Function( _SkipToNextRequested value)?  skipToNextRequested,TResult? Function( _SkipToPreviousRequested value)?  skipToPreviousRequested,TResult? Function( _PlaybackStateUpdated value)?  playbackStateUpdated,}){
final _that = this;
switch (_that) {
case _PlayRequested() when playRequested != null:
return playRequested(_that);case _PauseRequested() when pauseRequested != null:
return pauseRequested(_that);case _ResumeRequested() when resumeRequested != null:
return resumeRequested(_that);case _SeekRequested() when seekRequested != null:
return seekRequested(_that);case _VolumeChanged() when volumeChanged != null:
return volumeChanged(_that);case _SpeedChanged() when speedChanged != null:
return speedChanged(_that);case _SkipToNextRequested() when skipToNextRequested != null:
return skipToNextRequested(_that);case _SkipToPreviousRequested() when skipToPreviousRequested != null:
return skipToPreviousRequested(_that);case _PlaybackStateUpdated() when playbackStateUpdated != null:
return playbackStateUpdated(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AudioTrack track,  List<AudioTrack> queue,  int startIndex)?  playRequested,TResult Function()?  pauseRequested,TResult Function()?  resumeRequested,TResult Function( Duration position)?  seekRequested,TResult Function( double volume)?  volumeChanged,TResult Function( double speed)?  speedChanged,TResult Function()?  skipToNextRequested,TResult Function()?  skipToPreviousRequested,TResult Function( PlaybackState playbackState)?  playbackStateUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayRequested() when playRequested != null:
return playRequested(_that.track,_that.queue,_that.startIndex);case _PauseRequested() when pauseRequested != null:
return pauseRequested();case _ResumeRequested() when resumeRequested != null:
return resumeRequested();case _SeekRequested() when seekRequested != null:
return seekRequested(_that.position);case _VolumeChanged() when volumeChanged != null:
return volumeChanged(_that.volume);case _SpeedChanged() when speedChanged != null:
return speedChanged(_that.speed);case _SkipToNextRequested() when skipToNextRequested != null:
return skipToNextRequested();case _SkipToPreviousRequested() when skipToPreviousRequested != null:
return skipToPreviousRequested();case _PlaybackStateUpdated() when playbackStateUpdated != null:
return playbackStateUpdated(_that.playbackState);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AudioTrack track,  List<AudioTrack> queue,  int startIndex)  playRequested,required TResult Function()  pauseRequested,required TResult Function()  resumeRequested,required TResult Function( Duration position)  seekRequested,required TResult Function( double volume)  volumeChanged,required TResult Function( double speed)  speedChanged,required TResult Function()  skipToNextRequested,required TResult Function()  skipToPreviousRequested,required TResult Function( PlaybackState playbackState)  playbackStateUpdated,}) {final _that = this;
switch (_that) {
case _PlayRequested():
return playRequested(_that.track,_that.queue,_that.startIndex);case _PauseRequested():
return pauseRequested();case _ResumeRequested():
return resumeRequested();case _SeekRequested():
return seekRequested(_that.position);case _VolumeChanged():
return volumeChanged(_that.volume);case _SpeedChanged():
return speedChanged(_that.speed);case _SkipToNextRequested():
return skipToNextRequested();case _SkipToPreviousRequested():
return skipToPreviousRequested();case _PlaybackStateUpdated():
return playbackStateUpdated(_that.playbackState);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AudioTrack track,  List<AudioTrack> queue,  int startIndex)?  playRequested,TResult? Function()?  pauseRequested,TResult? Function()?  resumeRequested,TResult? Function( Duration position)?  seekRequested,TResult? Function( double volume)?  volumeChanged,TResult? Function( double speed)?  speedChanged,TResult? Function()?  skipToNextRequested,TResult? Function()?  skipToPreviousRequested,TResult? Function( PlaybackState playbackState)?  playbackStateUpdated,}) {final _that = this;
switch (_that) {
case _PlayRequested() when playRequested != null:
return playRequested(_that.track,_that.queue,_that.startIndex);case _PauseRequested() when pauseRequested != null:
return pauseRequested();case _ResumeRequested() when resumeRequested != null:
return resumeRequested();case _SeekRequested() when seekRequested != null:
return seekRequested(_that.position);case _VolumeChanged() when volumeChanged != null:
return volumeChanged(_that.volume);case _SpeedChanged() when speedChanged != null:
return speedChanged(_that.speed);case _SkipToNextRequested() when skipToNextRequested != null:
return skipToNextRequested();case _SkipToPreviousRequested() when skipToPreviousRequested != null:
return skipToPreviousRequested();case _PlaybackStateUpdated() when playbackStateUpdated != null:
return playbackStateUpdated(_that.playbackState);case _:
  return null;

}
}

}

/// @nodoc


class _PlayRequested implements PlaybackEvent {
  const _PlayRequested(this.track, final  List<AudioTrack> queue, this.startIndex): _queue = queue;
  

 final  AudioTrack track;
 final  List<AudioTrack> _queue;
 List<AudioTrack> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

 final  int startIndex;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayRequestedCopyWith<_PlayRequested> get copyWith => __$PlayRequestedCopyWithImpl<_PlayRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayRequested&&(identical(other.track, track) || other.track == track)&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex));
}


@override
int get hashCode => Object.hash(runtimeType,track,const DeepCollectionEquality().hash(_queue),startIndex);

@override
String toString() {
  return 'PlaybackEvent.playRequested(track: $track, queue: $queue, startIndex: $startIndex)';
}


}

/// @nodoc
abstract mixin class _$PlayRequestedCopyWith<$Res> implements $PlaybackEventCopyWith<$Res> {
  factory _$PlayRequestedCopyWith(_PlayRequested value, $Res Function(_PlayRequested) _then) = __$PlayRequestedCopyWithImpl;
@useResult
$Res call({
 AudioTrack track, List<AudioTrack> queue, int startIndex
});




}
/// @nodoc
class __$PlayRequestedCopyWithImpl<$Res>
    implements _$PlayRequestedCopyWith<$Res> {
  __$PlayRequestedCopyWithImpl(this._self, this._then);

  final _PlayRequested _self;
  final $Res Function(_PlayRequested) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? track = null,Object? queue = null,Object? startIndex = null,}) {
  return _then(_PlayRequested(
null == track ? _self.track : track // ignore: cast_nullable_to_non_nullable
as AudioTrack,null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _PauseRequested implements PlaybackEvent {
  const _PauseRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PauseRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackEvent.pauseRequested()';
}


}




/// @nodoc


class _ResumeRequested implements PlaybackEvent {
  const _ResumeRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackEvent.resumeRequested()';
}


}




/// @nodoc


class _SeekRequested implements PlaybackEvent {
  const _SeekRequested(this.position);
  

 final  Duration position;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeekRequestedCopyWith<_SeekRequested> get copyWith => __$SeekRequestedCopyWithImpl<_SeekRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeekRequested&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,position);

@override
String toString() {
  return 'PlaybackEvent.seekRequested(position: $position)';
}


}

/// @nodoc
abstract mixin class _$SeekRequestedCopyWith<$Res> implements $PlaybackEventCopyWith<$Res> {
  factory _$SeekRequestedCopyWith(_SeekRequested value, $Res Function(_SeekRequested) _then) = __$SeekRequestedCopyWithImpl;
@useResult
$Res call({
 Duration position
});




}
/// @nodoc
class __$SeekRequestedCopyWithImpl<$Res>
    implements _$SeekRequestedCopyWith<$Res> {
  __$SeekRequestedCopyWithImpl(this._self, this._then);

  final _SeekRequested _self;
  final $Res Function(_SeekRequested) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? position = null,}) {
  return _then(_SeekRequested(
null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class _VolumeChanged implements PlaybackEvent {
  const _VolumeChanged(this.volume);
  

 final  double volume;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VolumeChangedCopyWith<_VolumeChanged> get copyWith => __$VolumeChangedCopyWithImpl<_VolumeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VolumeChanged&&(identical(other.volume, volume) || other.volume == volume));
}


@override
int get hashCode => Object.hash(runtimeType,volume);

@override
String toString() {
  return 'PlaybackEvent.volumeChanged(volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$VolumeChangedCopyWith<$Res> implements $PlaybackEventCopyWith<$Res> {
  factory _$VolumeChangedCopyWith(_VolumeChanged value, $Res Function(_VolumeChanged) _then) = __$VolumeChangedCopyWithImpl;
@useResult
$Res call({
 double volume
});




}
/// @nodoc
class __$VolumeChangedCopyWithImpl<$Res>
    implements _$VolumeChangedCopyWith<$Res> {
  __$VolumeChangedCopyWithImpl(this._self, this._then);

  final _VolumeChanged _self;
  final $Res Function(_VolumeChanged) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? volume = null,}) {
  return _then(_VolumeChanged(
null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _SpeedChanged implements PlaybackEvent {
  const _SpeedChanged(this.speed);
  

 final  double speed;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeedChangedCopyWith<_SpeedChanged> get copyWith => __$SpeedChangedCopyWithImpl<_SpeedChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeedChanged&&(identical(other.speed, speed) || other.speed == speed));
}


@override
int get hashCode => Object.hash(runtimeType,speed);

@override
String toString() {
  return 'PlaybackEvent.speedChanged(speed: $speed)';
}


}

/// @nodoc
abstract mixin class _$SpeedChangedCopyWith<$Res> implements $PlaybackEventCopyWith<$Res> {
  factory _$SpeedChangedCopyWith(_SpeedChanged value, $Res Function(_SpeedChanged) _then) = __$SpeedChangedCopyWithImpl;
@useResult
$Res call({
 double speed
});




}
/// @nodoc
class __$SpeedChangedCopyWithImpl<$Res>
    implements _$SpeedChangedCopyWith<$Res> {
  __$SpeedChangedCopyWithImpl(this._self, this._then);

  final _SpeedChanged _self;
  final $Res Function(_SpeedChanged) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? speed = null,}) {
  return _then(_SpeedChanged(
null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _SkipToNextRequested implements PlaybackEvent {
  const _SkipToNextRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipToNextRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackEvent.skipToNextRequested()';
}


}




/// @nodoc


class _SkipToPreviousRequested implements PlaybackEvent {
  const _SkipToPreviousRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipToPreviousRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackEvent.skipToPreviousRequested()';
}


}




/// @nodoc


class _PlaybackStateUpdated implements PlaybackEvent {
  const _PlaybackStateUpdated(this.playbackState);
  

 final  PlaybackState playbackState;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackStateUpdatedCopyWith<_PlaybackStateUpdated> get copyWith => __$PlaybackStateUpdatedCopyWithImpl<_PlaybackStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackStateUpdated&&(identical(other.playbackState, playbackState) || other.playbackState == playbackState));
}


@override
int get hashCode => Object.hash(runtimeType,playbackState);

@override
String toString() {
  return 'PlaybackEvent.playbackStateUpdated(playbackState: $playbackState)';
}


}

/// @nodoc
abstract mixin class _$PlaybackStateUpdatedCopyWith<$Res> implements $PlaybackEventCopyWith<$Res> {
  factory _$PlaybackStateUpdatedCopyWith(_PlaybackStateUpdated value, $Res Function(_PlaybackStateUpdated) _then) = __$PlaybackStateUpdatedCopyWithImpl;
@useResult
$Res call({
 PlaybackState playbackState
});




}
/// @nodoc
class __$PlaybackStateUpdatedCopyWithImpl<$Res>
    implements _$PlaybackStateUpdatedCopyWith<$Res> {
  __$PlaybackStateUpdatedCopyWithImpl(this._self, this._then);

  final _PlaybackStateUpdated _self;
  final $Res Function(_PlaybackStateUpdated) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playbackState = null,}) {
  return _then(_PlaybackStateUpdated(
null == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState,
  ));
}


}

/// @nodoc
mixin _$PlaybackBlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackBlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackBlocState()';
}


}

/// @nodoc
class $PlaybackBlocStateCopyWith<$Res>  {
$PlaybackBlocStateCopyWith(PlaybackBlocState _, $Res Function(PlaybackBlocState) __);
}


/// Adds pattern-matching-related methods to [PlaybackBlocState].
extension PlaybackBlocStatePatterns on PlaybackBlocState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Playing value)?  playing,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Playing() when playing != null:
return playing(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Playing value)  playing,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Playing():
return playing(_that);case _Error():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Playing value)?  playing,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Playing() when playing != null:
return playing(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PlaybackState playbackState)?  playing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Playing() when playing != null:
return playing(_that.playbackState);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PlaybackState playbackState)  playing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Playing():
return playing(_that.playbackState);case _Error():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PlaybackState playbackState)?  playing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Playing() when playing != null:
return playing(_that.playbackState);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PlaybackBlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackBlocState.initial()';
}


}




/// @nodoc


class _Loading implements PlaybackBlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaybackBlocState.loading()';
}


}




/// @nodoc


class _Playing implements PlaybackBlocState {
  const _Playing(this.playbackState);
  

 final  PlaybackState playbackState;

/// Create a copy of PlaybackBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayingCopyWith<_Playing> get copyWith => __$PlayingCopyWithImpl<_Playing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Playing&&(identical(other.playbackState, playbackState) || other.playbackState == playbackState));
}


@override
int get hashCode => Object.hash(runtimeType,playbackState);

@override
String toString() {
  return 'PlaybackBlocState.playing(playbackState: $playbackState)';
}


}

/// @nodoc
abstract mixin class _$PlayingCopyWith<$Res> implements $PlaybackBlocStateCopyWith<$Res> {
  factory _$PlayingCopyWith(_Playing value, $Res Function(_Playing) _then) = __$PlayingCopyWithImpl;
@useResult
$Res call({
 PlaybackState playbackState
});




}
/// @nodoc
class __$PlayingCopyWithImpl<$Res>
    implements _$PlayingCopyWith<$Res> {
  __$PlayingCopyWithImpl(this._self, this._then);

  final _Playing _self;
  final $Res Function(_Playing) _then;

/// Create a copy of PlaybackBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playbackState = null,}) {
  return _then(_Playing(
null == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState,
  ));
}


}

/// @nodoc


class _Error implements PlaybackBlocState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of PlaybackBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PlaybackBlocState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PlaybackBlocStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PlaybackBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
