// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueEvent()';
}


}

/// @nodoc
class $QueueEventCopyWith<$Res>  {
$QueueEventCopyWith(QueueEvent _, $Res Function(QueueEvent) __);
}


/// Adds pattern-matching-related methods to [QueueEvent].
extension QueueEventPatterns on QueueEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadQueueRequested value)?  loadQueueRequested,TResult Function( _AddToQueueRequested value)?  addToQueueRequested,TResult Function( _PlayNextRequested value)?  playNextRequested,TResult Function( _RemoveFromQueueRequested value)?  removeFromQueueRequested,TResult Function( _ReorderQueueRequested value)?  reorderQueueRequested,TResult Function( _ClearQueueRequested value)?  clearQueueRequested,TResult Function( _QueueStateUpdated value)?  queueStateUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadQueueRequested() when loadQueueRequested != null:
return loadQueueRequested(_that);case _AddToQueueRequested() when addToQueueRequested != null:
return addToQueueRequested(_that);case _PlayNextRequested() when playNextRequested != null:
return playNextRequested(_that);case _RemoveFromQueueRequested() when removeFromQueueRequested != null:
return removeFromQueueRequested(_that);case _ReorderQueueRequested() when reorderQueueRequested != null:
return reorderQueueRequested(_that);case _ClearQueueRequested() when clearQueueRequested != null:
return clearQueueRequested(_that);case _QueueStateUpdated() when queueStateUpdated != null:
return queueStateUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadQueueRequested value)  loadQueueRequested,required TResult Function( _AddToQueueRequested value)  addToQueueRequested,required TResult Function( _PlayNextRequested value)  playNextRequested,required TResult Function( _RemoveFromQueueRequested value)  removeFromQueueRequested,required TResult Function( _ReorderQueueRequested value)  reorderQueueRequested,required TResult Function( _ClearQueueRequested value)  clearQueueRequested,required TResult Function( _QueueStateUpdated value)  queueStateUpdated,}){
final _that = this;
switch (_that) {
case _LoadQueueRequested():
return loadQueueRequested(_that);case _AddToQueueRequested():
return addToQueueRequested(_that);case _PlayNextRequested():
return playNextRequested(_that);case _RemoveFromQueueRequested():
return removeFromQueueRequested(_that);case _ReorderQueueRequested():
return reorderQueueRequested(_that);case _ClearQueueRequested():
return clearQueueRequested(_that);case _QueueStateUpdated():
return queueStateUpdated(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadQueueRequested value)?  loadQueueRequested,TResult? Function( _AddToQueueRequested value)?  addToQueueRequested,TResult? Function( _PlayNextRequested value)?  playNextRequested,TResult? Function( _RemoveFromQueueRequested value)?  removeFromQueueRequested,TResult? Function( _ReorderQueueRequested value)?  reorderQueueRequested,TResult? Function( _ClearQueueRequested value)?  clearQueueRequested,TResult? Function( _QueueStateUpdated value)?  queueStateUpdated,}){
final _that = this;
switch (_that) {
case _LoadQueueRequested() when loadQueueRequested != null:
return loadQueueRequested(_that);case _AddToQueueRequested() when addToQueueRequested != null:
return addToQueueRequested(_that);case _PlayNextRequested() when playNextRequested != null:
return playNextRequested(_that);case _RemoveFromQueueRequested() when removeFromQueueRequested != null:
return removeFromQueueRequested(_that);case _ReorderQueueRequested() when reorderQueueRequested != null:
return reorderQueueRequested(_that);case _ClearQueueRequested() when clearQueueRequested != null:
return clearQueueRequested(_that);case _QueueStateUpdated() when queueStateUpdated != null:
return queueStateUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadQueueRequested,TResult Function( List<AudioTrack> tracks)?  addToQueueRequested,TResult Function( List<AudioTrack> tracks)?  playNextRequested,TResult Function( int index)?  removeFromQueueRequested,TResult Function( int oldIndex,  int newIndex)?  reorderQueueRequested,TResult Function()?  clearQueueRequested,TResult Function( PlaybackState playbackState)?  queueStateUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadQueueRequested() when loadQueueRequested != null:
return loadQueueRequested();case _AddToQueueRequested() when addToQueueRequested != null:
return addToQueueRequested(_that.tracks);case _PlayNextRequested() when playNextRequested != null:
return playNextRequested(_that.tracks);case _RemoveFromQueueRequested() when removeFromQueueRequested != null:
return removeFromQueueRequested(_that.index);case _ReorderQueueRequested() when reorderQueueRequested != null:
return reorderQueueRequested(_that.oldIndex,_that.newIndex);case _ClearQueueRequested() when clearQueueRequested != null:
return clearQueueRequested();case _QueueStateUpdated() when queueStateUpdated != null:
return queueStateUpdated(_that.playbackState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadQueueRequested,required TResult Function( List<AudioTrack> tracks)  addToQueueRequested,required TResult Function( List<AudioTrack> tracks)  playNextRequested,required TResult Function( int index)  removeFromQueueRequested,required TResult Function( int oldIndex,  int newIndex)  reorderQueueRequested,required TResult Function()  clearQueueRequested,required TResult Function( PlaybackState playbackState)  queueStateUpdated,}) {final _that = this;
switch (_that) {
case _LoadQueueRequested():
return loadQueueRequested();case _AddToQueueRequested():
return addToQueueRequested(_that.tracks);case _PlayNextRequested():
return playNextRequested(_that.tracks);case _RemoveFromQueueRequested():
return removeFromQueueRequested(_that.index);case _ReorderQueueRequested():
return reorderQueueRequested(_that.oldIndex,_that.newIndex);case _ClearQueueRequested():
return clearQueueRequested();case _QueueStateUpdated():
return queueStateUpdated(_that.playbackState);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadQueueRequested,TResult? Function( List<AudioTrack> tracks)?  addToQueueRequested,TResult? Function( List<AudioTrack> tracks)?  playNextRequested,TResult? Function( int index)?  removeFromQueueRequested,TResult? Function( int oldIndex,  int newIndex)?  reorderQueueRequested,TResult? Function()?  clearQueueRequested,TResult? Function( PlaybackState playbackState)?  queueStateUpdated,}) {final _that = this;
switch (_that) {
case _LoadQueueRequested() when loadQueueRequested != null:
return loadQueueRequested();case _AddToQueueRequested() when addToQueueRequested != null:
return addToQueueRequested(_that.tracks);case _PlayNextRequested() when playNextRequested != null:
return playNextRequested(_that.tracks);case _RemoveFromQueueRequested() when removeFromQueueRequested != null:
return removeFromQueueRequested(_that.index);case _ReorderQueueRequested() when reorderQueueRequested != null:
return reorderQueueRequested(_that.oldIndex,_that.newIndex);case _ClearQueueRequested() when clearQueueRequested != null:
return clearQueueRequested();case _QueueStateUpdated() when queueStateUpdated != null:
return queueStateUpdated(_that.playbackState);case _:
  return null;

}
}

}

/// @nodoc


class _LoadQueueRequested implements QueueEvent {
  const _LoadQueueRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadQueueRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueEvent.loadQueueRequested()';
}


}




/// @nodoc


class _AddToQueueRequested implements QueueEvent {
  const _AddToQueueRequested(final  List<AudioTrack> tracks): _tracks = tracks;
  

 final  List<AudioTrack> _tracks;
 List<AudioTrack> get tracks {
  if (_tracks is EqualUnmodifiableListView) return _tracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tracks);
}


/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddToQueueRequestedCopyWith<_AddToQueueRequested> get copyWith => __$AddToQueueRequestedCopyWithImpl<_AddToQueueRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddToQueueRequested&&const DeepCollectionEquality().equals(other._tracks, _tracks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tracks));

@override
String toString() {
  return 'QueueEvent.addToQueueRequested(tracks: $tracks)';
}


}

/// @nodoc
abstract mixin class _$AddToQueueRequestedCopyWith<$Res> implements $QueueEventCopyWith<$Res> {
  factory _$AddToQueueRequestedCopyWith(_AddToQueueRequested value, $Res Function(_AddToQueueRequested) _then) = __$AddToQueueRequestedCopyWithImpl;
@useResult
$Res call({
 List<AudioTrack> tracks
});




}
/// @nodoc
class __$AddToQueueRequestedCopyWithImpl<$Res>
    implements _$AddToQueueRequestedCopyWith<$Res> {
  __$AddToQueueRequestedCopyWithImpl(this._self, this._then);

  final _AddToQueueRequested _self;
  final $Res Function(_AddToQueueRequested) _then;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tracks = null,}) {
  return _then(_AddToQueueRequested(
null == tracks ? _self._tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,
  ));
}


}

/// @nodoc


class _PlayNextRequested implements QueueEvent {
  const _PlayNextRequested(final  List<AudioTrack> tracks): _tracks = tracks;
  

 final  List<AudioTrack> _tracks;
 List<AudioTrack> get tracks {
  if (_tracks is EqualUnmodifiableListView) return _tracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tracks);
}


/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayNextRequestedCopyWith<_PlayNextRequested> get copyWith => __$PlayNextRequestedCopyWithImpl<_PlayNextRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayNextRequested&&const DeepCollectionEquality().equals(other._tracks, _tracks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tracks));

@override
String toString() {
  return 'QueueEvent.playNextRequested(tracks: $tracks)';
}


}

/// @nodoc
abstract mixin class _$PlayNextRequestedCopyWith<$Res> implements $QueueEventCopyWith<$Res> {
  factory _$PlayNextRequestedCopyWith(_PlayNextRequested value, $Res Function(_PlayNextRequested) _then) = __$PlayNextRequestedCopyWithImpl;
@useResult
$Res call({
 List<AudioTrack> tracks
});




}
/// @nodoc
class __$PlayNextRequestedCopyWithImpl<$Res>
    implements _$PlayNextRequestedCopyWith<$Res> {
  __$PlayNextRequestedCopyWithImpl(this._self, this._then);

  final _PlayNextRequested _self;
  final $Res Function(_PlayNextRequested) _then;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tracks = null,}) {
  return _then(_PlayNextRequested(
null == tracks ? _self._tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,
  ));
}


}

/// @nodoc


class _RemoveFromQueueRequested implements QueueEvent {
  const _RemoveFromQueueRequested(this.index);
  

 final  int index;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveFromQueueRequestedCopyWith<_RemoveFromQueueRequested> get copyWith => __$RemoveFromQueueRequestedCopyWithImpl<_RemoveFromQueueRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveFromQueueRequested&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'QueueEvent.removeFromQueueRequested(index: $index)';
}


}

/// @nodoc
abstract mixin class _$RemoveFromQueueRequestedCopyWith<$Res> implements $QueueEventCopyWith<$Res> {
  factory _$RemoveFromQueueRequestedCopyWith(_RemoveFromQueueRequested value, $Res Function(_RemoveFromQueueRequested) _then) = __$RemoveFromQueueRequestedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$RemoveFromQueueRequestedCopyWithImpl<$Res>
    implements _$RemoveFromQueueRequestedCopyWith<$Res> {
  __$RemoveFromQueueRequestedCopyWithImpl(this._self, this._then);

  final _RemoveFromQueueRequested _self;
  final $Res Function(_RemoveFromQueueRequested) _then;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_RemoveFromQueueRequested(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ReorderQueueRequested implements QueueEvent {
  const _ReorderQueueRequested(this.oldIndex, this.newIndex);
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReorderQueueRequestedCopyWith<_ReorderQueueRequested> get copyWith => __$ReorderQueueRequestedCopyWithImpl<_ReorderQueueRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReorderQueueRequested&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'QueueEvent.reorderQueueRequested(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class _$ReorderQueueRequestedCopyWith<$Res> implements $QueueEventCopyWith<$Res> {
  factory _$ReorderQueueRequestedCopyWith(_ReorderQueueRequested value, $Res Function(_ReorderQueueRequested) _then) = __$ReorderQueueRequestedCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class __$ReorderQueueRequestedCopyWithImpl<$Res>
    implements _$ReorderQueueRequestedCopyWith<$Res> {
  __$ReorderQueueRequestedCopyWithImpl(this._self, this._then);

  final _ReorderQueueRequested _self;
  final $Res Function(_ReorderQueueRequested) _then;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(_ReorderQueueRequested(
null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ClearQueueRequested implements QueueEvent {
  const _ClearQueueRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearQueueRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueEvent.clearQueueRequested()';
}


}




/// @nodoc


class _QueueStateUpdated implements QueueEvent {
  const _QueueStateUpdated(this.playbackState);
  

 final  PlaybackState playbackState;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueStateUpdatedCopyWith<_QueueStateUpdated> get copyWith => __$QueueStateUpdatedCopyWithImpl<_QueueStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueStateUpdated&&(identical(other.playbackState, playbackState) || other.playbackState == playbackState));
}


@override
int get hashCode => Object.hash(runtimeType,playbackState);

@override
String toString() {
  return 'QueueEvent.queueStateUpdated(playbackState: $playbackState)';
}


}

/// @nodoc
abstract mixin class _$QueueStateUpdatedCopyWith<$Res> implements $QueueEventCopyWith<$Res> {
  factory _$QueueStateUpdatedCopyWith(_QueueStateUpdated value, $Res Function(_QueueStateUpdated) _then) = __$QueueStateUpdatedCopyWithImpl;
@useResult
$Res call({
 PlaybackState playbackState
});




}
/// @nodoc
class __$QueueStateUpdatedCopyWithImpl<$Res>
    implements _$QueueStateUpdatedCopyWith<$Res> {
  __$QueueStateUpdatedCopyWithImpl(this._self, this._then);

  final _QueueStateUpdated _self;
  final $Res Function(_QueueStateUpdated) _then;

/// Create a copy of QueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playbackState = null,}) {
  return _then(_QueueStateUpdated(
null == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState,
  ));
}


}

/// @nodoc
mixin _$QueueBlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueBlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueBlocState()';
}


}

/// @nodoc
class $QueueBlocStateCopyWith<$Res>  {
$QueueBlocStateCopyWith(QueueBlocState _, $Res Function(QueueBlocState) __);
}


/// Adds pattern-matching-related methods to [QueueBlocState].
extension QueueBlocStatePatterns on QueueBlocState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<AudioTrack> queue,  int currentIndex,  AudioTrack? currentTrack)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.queue,_that.currentIndex,_that.currentTrack);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<AudioTrack> queue,  int currentIndex,  AudioTrack? currentTrack)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.queue,_that.currentIndex,_that.currentTrack);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<AudioTrack> queue,  int currentIndex,  AudioTrack? currentTrack)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.queue,_that.currentIndex,_that.currentTrack);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements QueueBlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueBlocState.initial()';
}


}




/// @nodoc


class _Loading implements QueueBlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueBlocState.loading()';
}


}




/// @nodoc


class _Loaded implements QueueBlocState {
  const _Loaded({required final  List<AudioTrack> queue, required this.currentIndex, this.currentTrack}): _queue = queue;
  

 final  List<AudioTrack> _queue;
 List<AudioTrack> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

 final  int currentIndex;
 final  AudioTrack? currentTrack;

/// Create a copy of QueueBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.currentTrack, currentTrack) || other.currentTrack == currentTrack));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_queue),currentIndex,currentTrack);

@override
String toString() {
  return 'QueueBlocState.loaded(queue: $queue, currentIndex: $currentIndex, currentTrack: $currentTrack)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $QueueBlocStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<AudioTrack> queue, int currentIndex, AudioTrack? currentTrack
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of QueueBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? queue = null,Object? currentIndex = null,Object? currentTrack = freezed,}) {
  return _then(_Loaded(
queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,currentTrack: freezed == currentTrack ? _self.currentTrack : currentTrack // ignore: cast_nullable_to_non_nullable
as AudioTrack?,
  ));
}


}

/// @nodoc


class _Error implements QueueBlocState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of QueueBlocState
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
  return 'QueueBlocState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $QueueBlocStateCopyWith<$Res> {
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

/// Create a copy of QueueBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
