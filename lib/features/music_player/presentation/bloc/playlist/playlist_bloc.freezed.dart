// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaylistEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaylistEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaylistEvent()';
}


}

/// @nodoc
class $PlaylistEventCopyWith<$Res>  {
$PlaylistEventCopyWith(PlaylistEvent _, $Res Function(PlaylistEvent) __);
}


/// Adds pattern-matching-related methods to [PlaylistEvent].
extension PlaylistEventPatterns on PlaylistEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadPlaylistsRequested value)?  loadPlaylistsRequested,TResult Function( _CreatePlaylistRequested value)?  createPlaylistRequested,TResult Function( _DeletePlaylistRequested value)?  deletePlaylistRequested,TResult Function( _AddTrackToPlaylistRequested value)?  addTrackToPlaylistRequested,TResult Function( _RemoveTrackFromPlaylistRequested value)?  removeTrackFromPlaylistRequested,TResult Function( _ReorderPlaylistTracksRequested value)?  reorderPlaylistTracksRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadPlaylistsRequested() when loadPlaylistsRequested != null:
return loadPlaylistsRequested(_that);case _CreatePlaylistRequested() when createPlaylistRequested != null:
return createPlaylistRequested(_that);case _DeletePlaylistRequested() when deletePlaylistRequested != null:
return deletePlaylistRequested(_that);case _AddTrackToPlaylistRequested() when addTrackToPlaylistRequested != null:
return addTrackToPlaylistRequested(_that);case _RemoveTrackFromPlaylistRequested() when removeTrackFromPlaylistRequested != null:
return removeTrackFromPlaylistRequested(_that);case _ReorderPlaylistTracksRequested() when reorderPlaylistTracksRequested != null:
return reorderPlaylistTracksRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadPlaylistsRequested value)  loadPlaylistsRequested,required TResult Function( _CreatePlaylistRequested value)  createPlaylistRequested,required TResult Function( _DeletePlaylistRequested value)  deletePlaylistRequested,required TResult Function( _AddTrackToPlaylistRequested value)  addTrackToPlaylistRequested,required TResult Function( _RemoveTrackFromPlaylistRequested value)  removeTrackFromPlaylistRequested,required TResult Function( _ReorderPlaylistTracksRequested value)  reorderPlaylistTracksRequested,}){
final _that = this;
switch (_that) {
case _LoadPlaylistsRequested():
return loadPlaylistsRequested(_that);case _CreatePlaylistRequested():
return createPlaylistRequested(_that);case _DeletePlaylistRequested():
return deletePlaylistRequested(_that);case _AddTrackToPlaylistRequested():
return addTrackToPlaylistRequested(_that);case _RemoveTrackFromPlaylistRequested():
return removeTrackFromPlaylistRequested(_that);case _ReorderPlaylistTracksRequested():
return reorderPlaylistTracksRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadPlaylistsRequested value)?  loadPlaylistsRequested,TResult? Function( _CreatePlaylistRequested value)?  createPlaylistRequested,TResult? Function( _DeletePlaylistRequested value)?  deletePlaylistRequested,TResult? Function( _AddTrackToPlaylistRequested value)?  addTrackToPlaylistRequested,TResult? Function( _RemoveTrackFromPlaylistRequested value)?  removeTrackFromPlaylistRequested,TResult? Function( _ReorderPlaylistTracksRequested value)?  reorderPlaylistTracksRequested,}){
final _that = this;
switch (_that) {
case _LoadPlaylistsRequested() when loadPlaylistsRequested != null:
return loadPlaylistsRequested(_that);case _CreatePlaylistRequested() when createPlaylistRequested != null:
return createPlaylistRequested(_that);case _DeletePlaylistRequested() when deletePlaylistRequested != null:
return deletePlaylistRequested(_that);case _AddTrackToPlaylistRequested() when addTrackToPlaylistRequested != null:
return addTrackToPlaylistRequested(_that);case _RemoveTrackFromPlaylistRequested() when removeTrackFromPlaylistRequested != null:
return removeTrackFromPlaylistRequested(_that);case _ReorderPlaylistTracksRequested() when reorderPlaylistTracksRequested != null:
return reorderPlaylistTracksRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadPlaylistsRequested,TResult Function( String name)?  createPlaylistRequested,TResult Function( String id)?  deletePlaylistRequested,TResult Function( String playlistId,  String trackId)?  addTrackToPlaylistRequested,TResult Function( String playlistId,  String trackId)?  removeTrackFromPlaylistRequested,TResult Function( String playlistId,  int oldIndex,  int newIndex)?  reorderPlaylistTracksRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadPlaylistsRequested() when loadPlaylistsRequested != null:
return loadPlaylistsRequested();case _CreatePlaylistRequested() when createPlaylistRequested != null:
return createPlaylistRequested(_that.name);case _DeletePlaylistRequested() when deletePlaylistRequested != null:
return deletePlaylistRequested(_that.id);case _AddTrackToPlaylistRequested() when addTrackToPlaylistRequested != null:
return addTrackToPlaylistRequested(_that.playlistId,_that.trackId);case _RemoveTrackFromPlaylistRequested() when removeTrackFromPlaylistRequested != null:
return removeTrackFromPlaylistRequested(_that.playlistId,_that.trackId);case _ReorderPlaylistTracksRequested() when reorderPlaylistTracksRequested != null:
return reorderPlaylistTracksRequested(_that.playlistId,_that.oldIndex,_that.newIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadPlaylistsRequested,required TResult Function( String name)  createPlaylistRequested,required TResult Function( String id)  deletePlaylistRequested,required TResult Function( String playlistId,  String trackId)  addTrackToPlaylistRequested,required TResult Function( String playlistId,  String trackId)  removeTrackFromPlaylistRequested,required TResult Function( String playlistId,  int oldIndex,  int newIndex)  reorderPlaylistTracksRequested,}) {final _that = this;
switch (_that) {
case _LoadPlaylistsRequested():
return loadPlaylistsRequested();case _CreatePlaylistRequested():
return createPlaylistRequested(_that.name);case _DeletePlaylistRequested():
return deletePlaylistRequested(_that.id);case _AddTrackToPlaylistRequested():
return addTrackToPlaylistRequested(_that.playlistId,_that.trackId);case _RemoveTrackFromPlaylistRequested():
return removeTrackFromPlaylistRequested(_that.playlistId,_that.trackId);case _ReorderPlaylistTracksRequested():
return reorderPlaylistTracksRequested(_that.playlistId,_that.oldIndex,_that.newIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadPlaylistsRequested,TResult? Function( String name)?  createPlaylistRequested,TResult? Function( String id)?  deletePlaylistRequested,TResult? Function( String playlistId,  String trackId)?  addTrackToPlaylistRequested,TResult? Function( String playlistId,  String trackId)?  removeTrackFromPlaylistRequested,TResult? Function( String playlistId,  int oldIndex,  int newIndex)?  reorderPlaylistTracksRequested,}) {final _that = this;
switch (_that) {
case _LoadPlaylistsRequested() when loadPlaylistsRequested != null:
return loadPlaylistsRequested();case _CreatePlaylistRequested() when createPlaylistRequested != null:
return createPlaylistRequested(_that.name);case _DeletePlaylistRequested() when deletePlaylistRequested != null:
return deletePlaylistRequested(_that.id);case _AddTrackToPlaylistRequested() when addTrackToPlaylistRequested != null:
return addTrackToPlaylistRequested(_that.playlistId,_that.trackId);case _RemoveTrackFromPlaylistRequested() when removeTrackFromPlaylistRequested != null:
return removeTrackFromPlaylistRequested(_that.playlistId,_that.trackId);case _ReorderPlaylistTracksRequested() when reorderPlaylistTracksRequested != null:
return reorderPlaylistTracksRequested(_that.playlistId,_that.oldIndex,_that.newIndex);case _:
  return null;

}
}

}

/// @nodoc


class _LoadPlaylistsRequested implements PlaylistEvent {
  const _LoadPlaylistsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadPlaylistsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaylistEvent.loadPlaylistsRequested()';
}


}




/// @nodoc


class _CreatePlaylistRequested implements PlaylistEvent {
  const _CreatePlaylistRequested(this.name);
  

 final  String name;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePlaylistRequestedCopyWith<_CreatePlaylistRequested> get copyWith => __$CreatePlaylistRequestedCopyWithImpl<_CreatePlaylistRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePlaylistRequested&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'PlaylistEvent.createPlaylistRequested(name: $name)';
}


}

/// @nodoc
abstract mixin class _$CreatePlaylistRequestedCopyWith<$Res> implements $PlaylistEventCopyWith<$Res> {
  factory _$CreatePlaylistRequestedCopyWith(_CreatePlaylistRequested value, $Res Function(_CreatePlaylistRequested) _then) = __$CreatePlaylistRequestedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$CreatePlaylistRequestedCopyWithImpl<$Res>
    implements _$CreatePlaylistRequestedCopyWith<$Res> {
  __$CreatePlaylistRequestedCopyWithImpl(this._self, this._then);

  final _CreatePlaylistRequested _self;
  final $Res Function(_CreatePlaylistRequested) _then;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_CreatePlaylistRequested(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeletePlaylistRequested implements PlaylistEvent {
  const _DeletePlaylistRequested(this.id);
  

 final  String id;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletePlaylistRequestedCopyWith<_DeletePlaylistRequested> get copyWith => __$DeletePlaylistRequestedCopyWithImpl<_DeletePlaylistRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeletePlaylistRequested&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PlaylistEvent.deletePlaylistRequested(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeletePlaylistRequestedCopyWith<$Res> implements $PlaylistEventCopyWith<$Res> {
  factory _$DeletePlaylistRequestedCopyWith(_DeletePlaylistRequested value, $Res Function(_DeletePlaylistRequested) _then) = __$DeletePlaylistRequestedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$DeletePlaylistRequestedCopyWithImpl<$Res>
    implements _$DeletePlaylistRequestedCopyWith<$Res> {
  __$DeletePlaylistRequestedCopyWithImpl(this._self, this._then);

  final _DeletePlaylistRequested _self;
  final $Res Function(_DeletePlaylistRequested) _then;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeletePlaylistRequested(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AddTrackToPlaylistRequested implements PlaylistEvent {
  const _AddTrackToPlaylistRequested(this.playlistId, this.trackId);
  

 final  String playlistId;
 final  String trackId;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddTrackToPlaylistRequestedCopyWith<_AddTrackToPlaylistRequested> get copyWith => __$AddTrackToPlaylistRequestedCopyWithImpl<_AddTrackToPlaylistRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddTrackToPlaylistRequested&&(identical(other.playlistId, playlistId) || other.playlistId == playlistId)&&(identical(other.trackId, trackId) || other.trackId == trackId));
}


@override
int get hashCode => Object.hash(runtimeType,playlistId,trackId);

@override
String toString() {
  return 'PlaylistEvent.addTrackToPlaylistRequested(playlistId: $playlistId, trackId: $trackId)';
}


}

/// @nodoc
abstract mixin class _$AddTrackToPlaylistRequestedCopyWith<$Res> implements $PlaylistEventCopyWith<$Res> {
  factory _$AddTrackToPlaylistRequestedCopyWith(_AddTrackToPlaylistRequested value, $Res Function(_AddTrackToPlaylistRequested) _then) = __$AddTrackToPlaylistRequestedCopyWithImpl;
@useResult
$Res call({
 String playlistId, String trackId
});




}
/// @nodoc
class __$AddTrackToPlaylistRequestedCopyWithImpl<$Res>
    implements _$AddTrackToPlaylistRequestedCopyWith<$Res> {
  __$AddTrackToPlaylistRequestedCopyWithImpl(this._self, this._then);

  final _AddTrackToPlaylistRequested _self;
  final $Res Function(_AddTrackToPlaylistRequested) _then;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playlistId = null,Object? trackId = null,}) {
  return _then(_AddTrackToPlaylistRequested(
null == playlistId ? _self.playlistId : playlistId // ignore: cast_nullable_to_non_nullable
as String,null == trackId ? _self.trackId : trackId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RemoveTrackFromPlaylistRequested implements PlaylistEvent {
  const _RemoveTrackFromPlaylistRequested(this.playlistId, this.trackId);
  

 final  String playlistId;
 final  String trackId;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveTrackFromPlaylistRequestedCopyWith<_RemoveTrackFromPlaylistRequested> get copyWith => __$RemoveTrackFromPlaylistRequestedCopyWithImpl<_RemoveTrackFromPlaylistRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveTrackFromPlaylistRequested&&(identical(other.playlistId, playlistId) || other.playlistId == playlistId)&&(identical(other.trackId, trackId) || other.trackId == trackId));
}


@override
int get hashCode => Object.hash(runtimeType,playlistId,trackId);

@override
String toString() {
  return 'PlaylistEvent.removeTrackFromPlaylistRequested(playlistId: $playlistId, trackId: $trackId)';
}


}

/// @nodoc
abstract mixin class _$RemoveTrackFromPlaylistRequestedCopyWith<$Res> implements $PlaylistEventCopyWith<$Res> {
  factory _$RemoveTrackFromPlaylistRequestedCopyWith(_RemoveTrackFromPlaylistRequested value, $Res Function(_RemoveTrackFromPlaylistRequested) _then) = __$RemoveTrackFromPlaylistRequestedCopyWithImpl;
@useResult
$Res call({
 String playlistId, String trackId
});




}
/// @nodoc
class __$RemoveTrackFromPlaylistRequestedCopyWithImpl<$Res>
    implements _$RemoveTrackFromPlaylistRequestedCopyWith<$Res> {
  __$RemoveTrackFromPlaylistRequestedCopyWithImpl(this._self, this._then);

  final _RemoveTrackFromPlaylistRequested _self;
  final $Res Function(_RemoveTrackFromPlaylistRequested) _then;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playlistId = null,Object? trackId = null,}) {
  return _then(_RemoveTrackFromPlaylistRequested(
null == playlistId ? _self.playlistId : playlistId // ignore: cast_nullable_to_non_nullable
as String,null == trackId ? _self.trackId : trackId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ReorderPlaylistTracksRequested implements PlaylistEvent {
  const _ReorderPlaylistTracksRequested(this.playlistId, this.oldIndex, this.newIndex);
  

 final  String playlistId;
 final  int oldIndex;
 final  int newIndex;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReorderPlaylistTracksRequestedCopyWith<_ReorderPlaylistTracksRequested> get copyWith => __$ReorderPlaylistTracksRequestedCopyWithImpl<_ReorderPlaylistTracksRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReorderPlaylistTracksRequested&&(identical(other.playlistId, playlistId) || other.playlistId == playlistId)&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,playlistId,oldIndex,newIndex);

@override
String toString() {
  return 'PlaylistEvent.reorderPlaylistTracksRequested(playlistId: $playlistId, oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class _$ReorderPlaylistTracksRequestedCopyWith<$Res> implements $PlaylistEventCopyWith<$Res> {
  factory _$ReorderPlaylistTracksRequestedCopyWith(_ReorderPlaylistTracksRequested value, $Res Function(_ReorderPlaylistTracksRequested) _then) = __$ReorderPlaylistTracksRequestedCopyWithImpl;
@useResult
$Res call({
 String playlistId, int oldIndex, int newIndex
});




}
/// @nodoc
class __$ReorderPlaylistTracksRequestedCopyWithImpl<$Res>
    implements _$ReorderPlaylistTracksRequestedCopyWith<$Res> {
  __$ReorderPlaylistTracksRequestedCopyWithImpl(this._self, this._then);

  final _ReorderPlaylistTracksRequested _self;
  final $Res Function(_ReorderPlaylistTracksRequested) _then;

/// Create a copy of PlaylistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playlistId = null,Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(_ReorderPlaylistTracksRequested(
null == playlistId ? _self.playlistId : playlistId // ignore: cast_nullable_to_non_nullable
as String,null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PlaylistBlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaylistBlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaylistBlocState()';
}


}

/// @nodoc
class $PlaylistBlocStateCopyWith<$Res>  {
$PlaylistBlocStateCopyWith(PlaylistBlocState _, $Res Function(PlaylistBlocState) __);
}


/// Adds pattern-matching-related methods to [PlaylistBlocState].
extension PlaylistBlocStatePatterns on PlaylistBlocState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Playlist> playlists)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.playlists);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Playlist> playlists)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.playlists);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Playlist> playlists)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.playlists);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PlaylistBlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaylistBlocState.initial()';
}


}




/// @nodoc


class _Loading implements PlaylistBlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaylistBlocState.loading()';
}


}




/// @nodoc


class _Loaded implements PlaylistBlocState {
  const _Loaded(final  List<Playlist> playlists): _playlists = playlists;
  

 final  List<Playlist> _playlists;
 List<Playlist> get playlists {
  if (_playlists is EqualUnmodifiableListView) return _playlists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playlists);
}


/// Create a copy of PlaylistBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._playlists, _playlists));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_playlists));

@override
String toString() {
  return 'PlaylistBlocState.loaded(playlists: $playlists)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $PlaylistBlocStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Playlist> playlists
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of PlaylistBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playlists = null,}) {
  return _then(_Loaded(
null == playlists ? _self._playlists : playlists // ignore: cast_nullable_to_non_nullable
as List<Playlist>,
  ));
}


}

/// @nodoc


class _Error implements PlaylistBlocState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of PlaylistBlocState
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
  return 'PlaylistBlocState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PlaylistBlocStateCopyWith<$Res> {
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

/// Create a copy of PlaylistBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
