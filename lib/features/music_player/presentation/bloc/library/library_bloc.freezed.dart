// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryEvent()';
}


}

/// @nodoc
class $LibraryEventCopyWith<$Res>  {
$LibraryEventCopyWith(LibraryEvent _, $Res Function(LibraryEvent) __);
}


/// Adds pattern-matching-related methods to [LibraryEvent].
extension LibraryEventPatterns on LibraryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadTracksRequested value)?  loadTracksRequested,TResult Function( _LoadArtistsRequested value)?  loadArtistsRequested,TResult Function( _LoadAlbumsRequested value)?  loadAlbumsRequested,TResult Function( _ScanLibraryRequested value)?  scanLibraryRequested,TResult Function( _AddSingleFileRequested value)?  addSingleFileRequested,TResult Function( _SearchQueryChanged value)?  searchQueryChanged,TResult Function( _FilterByFormatRequested value)?  filterByFormatRequested,TResult Function( _LoadTracksByArtistRequested value)?  loadTracksByArtistRequested,TResult Function( _LoadTracksByAlbumRequested value)?  loadTracksByAlbumRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadTracksRequested() when loadTracksRequested != null:
return loadTracksRequested(_that);case _LoadArtistsRequested() when loadArtistsRequested != null:
return loadArtistsRequested(_that);case _LoadAlbumsRequested() when loadAlbumsRequested != null:
return loadAlbumsRequested(_that);case _ScanLibraryRequested() when scanLibraryRequested != null:
return scanLibraryRequested(_that);case _AddSingleFileRequested() when addSingleFileRequested != null:
return addSingleFileRequested(_that);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that);case _FilterByFormatRequested() when filterByFormatRequested != null:
return filterByFormatRequested(_that);case _LoadTracksByArtistRequested() when loadTracksByArtistRequested != null:
return loadTracksByArtistRequested(_that);case _LoadTracksByAlbumRequested() when loadTracksByAlbumRequested != null:
return loadTracksByAlbumRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadTracksRequested value)  loadTracksRequested,required TResult Function( _LoadArtistsRequested value)  loadArtistsRequested,required TResult Function( _LoadAlbumsRequested value)  loadAlbumsRequested,required TResult Function( _ScanLibraryRequested value)  scanLibraryRequested,required TResult Function( _AddSingleFileRequested value)  addSingleFileRequested,required TResult Function( _SearchQueryChanged value)  searchQueryChanged,required TResult Function( _FilterByFormatRequested value)  filterByFormatRequested,required TResult Function( _LoadTracksByArtistRequested value)  loadTracksByArtistRequested,required TResult Function( _LoadTracksByAlbumRequested value)  loadTracksByAlbumRequested,}){
final _that = this;
switch (_that) {
case _LoadTracksRequested():
return loadTracksRequested(_that);case _LoadArtistsRequested():
return loadArtistsRequested(_that);case _LoadAlbumsRequested():
return loadAlbumsRequested(_that);case _ScanLibraryRequested():
return scanLibraryRequested(_that);case _AddSingleFileRequested():
return addSingleFileRequested(_that);case _SearchQueryChanged():
return searchQueryChanged(_that);case _FilterByFormatRequested():
return filterByFormatRequested(_that);case _LoadTracksByArtistRequested():
return loadTracksByArtistRequested(_that);case _LoadTracksByAlbumRequested():
return loadTracksByAlbumRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadTracksRequested value)?  loadTracksRequested,TResult? Function( _LoadArtistsRequested value)?  loadArtistsRequested,TResult? Function( _LoadAlbumsRequested value)?  loadAlbumsRequested,TResult? Function( _ScanLibraryRequested value)?  scanLibraryRequested,TResult? Function( _AddSingleFileRequested value)?  addSingleFileRequested,TResult? Function( _SearchQueryChanged value)?  searchQueryChanged,TResult? Function( _FilterByFormatRequested value)?  filterByFormatRequested,TResult? Function( _LoadTracksByArtistRequested value)?  loadTracksByArtistRequested,TResult? Function( _LoadTracksByAlbumRequested value)?  loadTracksByAlbumRequested,}){
final _that = this;
switch (_that) {
case _LoadTracksRequested() when loadTracksRequested != null:
return loadTracksRequested(_that);case _LoadArtistsRequested() when loadArtistsRequested != null:
return loadArtistsRequested(_that);case _LoadAlbumsRequested() when loadAlbumsRequested != null:
return loadAlbumsRequested(_that);case _ScanLibraryRequested() when scanLibraryRequested != null:
return scanLibraryRequested(_that);case _AddSingleFileRequested() when addSingleFileRequested != null:
return addSingleFileRequested(_that);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that);case _FilterByFormatRequested() when filterByFormatRequested != null:
return filterByFormatRequested(_that);case _LoadTracksByArtistRequested() when loadTracksByArtistRequested != null:
return loadTracksByArtistRequested(_that);case _LoadTracksByAlbumRequested() when loadTracksByAlbumRequested != null:
return loadTracksByAlbumRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadTracksRequested,TResult Function()?  loadArtistsRequested,TResult Function()?  loadAlbumsRequested,TResult Function( String directoryPath)?  scanLibraryRequested,TResult Function( String filePath)?  addSingleFileRequested,TResult Function( String query)?  searchQueryChanged,TResult Function( AudioFormat? format)?  filterByFormatRequested,TResult Function( String artist)?  loadTracksByArtistRequested,TResult Function( String album)?  loadTracksByAlbumRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadTracksRequested() when loadTracksRequested != null:
return loadTracksRequested();case _LoadArtistsRequested() when loadArtistsRequested != null:
return loadArtistsRequested();case _LoadAlbumsRequested() when loadAlbumsRequested != null:
return loadAlbumsRequested();case _ScanLibraryRequested() when scanLibraryRequested != null:
return scanLibraryRequested(_that.directoryPath);case _AddSingleFileRequested() when addSingleFileRequested != null:
return addSingleFileRequested(_that.filePath);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that.query);case _FilterByFormatRequested() when filterByFormatRequested != null:
return filterByFormatRequested(_that.format);case _LoadTracksByArtistRequested() when loadTracksByArtistRequested != null:
return loadTracksByArtistRequested(_that.artist);case _LoadTracksByAlbumRequested() when loadTracksByAlbumRequested != null:
return loadTracksByAlbumRequested(_that.album);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadTracksRequested,required TResult Function()  loadArtistsRequested,required TResult Function()  loadAlbumsRequested,required TResult Function( String directoryPath)  scanLibraryRequested,required TResult Function( String filePath)  addSingleFileRequested,required TResult Function( String query)  searchQueryChanged,required TResult Function( AudioFormat? format)  filterByFormatRequested,required TResult Function( String artist)  loadTracksByArtistRequested,required TResult Function( String album)  loadTracksByAlbumRequested,}) {final _that = this;
switch (_that) {
case _LoadTracksRequested():
return loadTracksRequested();case _LoadArtistsRequested():
return loadArtistsRequested();case _LoadAlbumsRequested():
return loadAlbumsRequested();case _ScanLibraryRequested():
return scanLibraryRequested(_that.directoryPath);case _AddSingleFileRequested():
return addSingleFileRequested(_that.filePath);case _SearchQueryChanged():
return searchQueryChanged(_that.query);case _FilterByFormatRequested():
return filterByFormatRequested(_that.format);case _LoadTracksByArtistRequested():
return loadTracksByArtistRequested(_that.artist);case _LoadTracksByAlbumRequested():
return loadTracksByAlbumRequested(_that.album);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadTracksRequested,TResult? Function()?  loadArtistsRequested,TResult? Function()?  loadAlbumsRequested,TResult? Function( String directoryPath)?  scanLibraryRequested,TResult? Function( String filePath)?  addSingleFileRequested,TResult? Function( String query)?  searchQueryChanged,TResult? Function( AudioFormat? format)?  filterByFormatRequested,TResult? Function( String artist)?  loadTracksByArtistRequested,TResult? Function( String album)?  loadTracksByAlbumRequested,}) {final _that = this;
switch (_that) {
case _LoadTracksRequested() when loadTracksRequested != null:
return loadTracksRequested();case _LoadArtistsRequested() when loadArtistsRequested != null:
return loadArtistsRequested();case _LoadAlbumsRequested() when loadAlbumsRequested != null:
return loadAlbumsRequested();case _ScanLibraryRequested() when scanLibraryRequested != null:
return scanLibraryRequested(_that.directoryPath);case _AddSingleFileRequested() when addSingleFileRequested != null:
return addSingleFileRequested(_that.filePath);case _SearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that.query);case _FilterByFormatRequested() when filterByFormatRequested != null:
return filterByFormatRequested(_that.format);case _LoadTracksByArtistRequested() when loadTracksByArtistRequested != null:
return loadTracksByArtistRequested(_that.artist);case _LoadTracksByAlbumRequested() when loadTracksByAlbumRequested != null:
return loadTracksByAlbumRequested(_that.album);case _:
  return null;

}
}

}

/// @nodoc


class _LoadTracksRequested implements LibraryEvent {
  const _LoadTracksRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTracksRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryEvent.loadTracksRequested()';
}


}




/// @nodoc


class _LoadArtistsRequested implements LibraryEvent {
  const _LoadArtistsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadArtistsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryEvent.loadArtistsRequested()';
}


}




/// @nodoc


class _LoadAlbumsRequested implements LibraryEvent {
  const _LoadAlbumsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadAlbumsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryEvent.loadAlbumsRequested()';
}


}




/// @nodoc


class _ScanLibraryRequested implements LibraryEvent {
  const _ScanLibraryRequested(this.directoryPath);
  

 final  String directoryPath;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanLibraryRequestedCopyWith<_ScanLibraryRequested> get copyWith => __$ScanLibraryRequestedCopyWithImpl<_ScanLibraryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanLibraryRequested&&(identical(other.directoryPath, directoryPath) || other.directoryPath == directoryPath));
}


@override
int get hashCode => Object.hash(runtimeType,directoryPath);

@override
String toString() {
  return 'LibraryEvent.scanLibraryRequested(directoryPath: $directoryPath)';
}


}

/// @nodoc
abstract mixin class _$ScanLibraryRequestedCopyWith<$Res> implements $LibraryEventCopyWith<$Res> {
  factory _$ScanLibraryRequestedCopyWith(_ScanLibraryRequested value, $Res Function(_ScanLibraryRequested) _then) = __$ScanLibraryRequestedCopyWithImpl;
@useResult
$Res call({
 String directoryPath
});




}
/// @nodoc
class __$ScanLibraryRequestedCopyWithImpl<$Res>
    implements _$ScanLibraryRequestedCopyWith<$Res> {
  __$ScanLibraryRequestedCopyWithImpl(this._self, this._then);

  final _ScanLibraryRequested _self;
  final $Res Function(_ScanLibraryRequested) _then;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? directoryPath = null,}) {
  return _then(_ScanLibraryRequested(
null == directoryPath ? _self.directoryPath : directoryPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AddSingleFileRequested implements LibraryEvent {
  const _AddSingleFileRequested(this.filePath);
  

 final  String filePath;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddSingleFileRequestedCopyWith<_AddSingleFileRequested> get copyWith => __$AddSingleFileRequestedCopyWithImpl<_AddSingleFileRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddSingleFileRequested&&(identical(other.filePath, filePath) || other.filePath == filePath));
}


@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'LibraryEvent.addSingleFileRequested(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class _$AddSingleFileRequestedCopyWith<$Res> implements $LibraryEventCopyWith<$Res> {
  factory _$AddSingleFileRequestedCopyWith(_AddSingleFileRequested value, $Res Function(_AddSingleFileRequested) _then) = __$AddSingleFileRequestedCopyWithImpl;
@useResult
$Res call({
 String filePath
});




}
/// @nodoc
class __$AddSingleFileRequestedCopyWithImpl<$Res>
    implements _$AddSingleFileRequestedCopyWith<$Res> {
  __$AddSingleFileRequestedCopyWithImpl(this._self, this._then);

  final _AddSingleFileRequested _self;
  final $Res Function(_AddSingleFileRequested) _then;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,}) {
  return _then(_AddSingleFileRequested(
null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SearchQueryChanged implements LibraryEvent {
  const _SearchQueryChanged(this.query);
  

 final  String query;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQueryChangedCopyWith<_SearchQueryChanged> get copyWith => __$SearchQueryChangedCopyWithImpl<_SearchQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'LibraryEvent.searchQueryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchQueryChangedCopyWith<$Res> implements $LibraryEventCopyWith<$Res> {
  factory _$SearchQueryChangedCopyWith(_SearchQueryChanged value, $Res Function(_SearchQueryChanged) _then) = __$SearchQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchQueryChangedCopyWithImpl<$Res>
    implements _$SearchQueryChangedCopyWith<$Res> {
  __$SearchQueryChangedCopyWithImpl(this._self, this._then);

  final _SearchQueryChanged _self;
  final $Res Function(_SearchQueryChanged) _then;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterByFormatRequested implements LibraryEvent {
  const _FilterByFormatRequested(this.format);
  

 final  AudioFormat? format;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterByFormatRequestedCopyWith<_FilterByFormatRequested> get copyWith => __$FilterByFormatRequestedCopyWithImpl<_FilterByFormatRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterByFormatRequested&&(identical(other.format, format) || other.format == format));
}


@override
int get hashCode => Object.hash(runtimeType,format);

@override
String toString() {
  return 'LibraryEvent.filterByFormatRequested(format: $format)';
}


}

/// @nodoc
abstract mixin class _$FilterByFormatRequestedCopyWith<$Res> implements $LibraryEventCopyWith<$Res> {
  factory _$FilterByFormatRequestedCopyWith(_FilterByFormatRequested value, $Res Function(_FilterByFormatRequested) _then) = __$FilterByFormatRequestedCopyWithImpl;
@useResult
$Res call({
 AudioFormat? format
});




}
/// @nodoc
class __$FilterByFormatRequestedCopyWithImpl<$Res>
    implements _$FilterByFormatRequestedCopyWith<$Res> {
  __$FilterByFormatRequestedCopyWithImpl(this._self, this._then);

  final _FilterByFormatRequested _self;
  final $Res Function(_FilterByFormatRequested) _then;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? format = freezed,}) {
  return _then(_FilterByFormatRequested(
freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as AudioFormat?,
  ));
}


}

/// @nodoc


class _LoadTracksByArtistRequested implements LibraryEvent {
  const _LoadTracksByArtistRequested(this.artist);
  

 final  String artist;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadTracksByArtistRequestedCopyWith<_LoadTracksByArtistRequested> get copyWith => __$LoadTracksByArtistRequestedCopyWithImpl<_LoadTracksByArtistRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTracksByArtistRequested&&(identical(other.artist, artist) || other.artist == artist));
}


@override
int get hashCode => Object.hash(runtimeType,artist);

@override
String toString() {
  return 'LibraryEvent.loadTracksByArtistRequested(artist: $artist)';
}


}

/// @nodoc
abstract mixin class _$LoadTracksByArtistRequestedCopyWith<$Res> implements $LibraryEventCopyWith<$Res> {
  factory _$LoadTracksByArtistRequestedCopyWith(_LoadTracksByArtistRequested value, $Res Function(_LoadTracksByArtistRequested) _then) = __$LoadTracksByArtistRequestedCopyWithImpl;
@useResult
$Res call({
 String artist
});




}
/// @nodoc
class __$LoadTracksByArtistRequestedCopyWithImpl<$Res>
    implements _$LoadTracksByArtistRequestedCopyWith<$Res> {
  __$LoadTracksByArtistRequestedCopyWithImpl(this._self, this._then);

  final _LoadTracksByArtistRequested _self;
  final $Res Function(_LoadTracksByArtistRequested) _then;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? artist = null,}) {
  return _then(_LoadTracksByArtistRequested(
null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadTracksByAlbumRequested implements LibraryEvent {
  const _LoadTracksByAlbumRequested(this.album);
  

 final  String album;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadTracksByAlbumRequestedCopyWith<_LoadTracksByAlbumRequested> get copyWith => __$LoadTracksByAlbumRequestedCopyWithImpl<_LoadTracksByAlbumRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTracksByAlbumRequested&&(identical(other.album, album) || other.album == album));
}


@override
int get hashCode => Object.hash(runtimeType,album);

@override
String toString() {
  return 'LibraryEvent.loadTracksByAlbumRequested(album: $album)';
}


}

/// @nodoc
abstract mixin class _$LoadTracksByAlbumRequestedCopyWith<$Res> implements $LibraryEventCopyWith<$Res> {
  factory _$LoadTracksByAlbumRequestedCopyWith(_LoadTracksByAlbumRequested value, $Res Function(_LoadTracksByAlbumRequested) _then) = __$LoadTracksByAlbumRequestedCopyWithImpl;
@useResult
$Res call({
 String album
});




}
/// @nodoc
class __$LoadTracksByAlbumRequestedCopyWithImpl<$Res>
    implements _$LoadTracksByAlbumRequestedCopyWith<$Res> {
  __$LoadTracksByAlbumRequestedCopyWithImpl(this._self, this._then);

  final _LoadTracksByAlbumRequested _self;
  final $Res Function(_LoadTracksByAlbumRequested) _then;

/// Create a copy of LibraryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? album = null,}) {
  return _then(_LoadTracksByAlbumRequested(
null == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LibraryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryState()';
}


}

/// @nodoc
class $LibraryStateCopyWith<$Res>  {
$LibraryStateCopyWith(LibraryState _, $Res Function(LibraryState) __);
}


/// Adds pattern-matching-related methods to [LibraryState].
extension LibraryStatePatterns on LibraryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Scanning value)?  scanning,TResult Function( _TracksLoaded value)?  tracksLoaded,TResult Function( _ArtistsLoaded value)?  artistsLoaded,TResult Function( _AlbumsLoaded value)?  albumsLoaded,TResult Function( _SearchResults value)?  searchResults,TResult Function( _ScanComplete value)?  scanComplete,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Scanning() when scanning != null:
return scanning(_that);case _TracksLoaded() when tracksLoaded != null:
return tracksLoaded(_that);case _ArtistsLoaded() when artistsLoaded != null:
return artistsLoaded(_that);case _AlbumsLoaded() when albumsLoaded != null:
return albumsLoaded(_that);case _SearchResults() when searchResults != null:
return searchResults(_that);case _ScanComplete() when scanComplete != null:
return scanComplete(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Scanning value)  scanning,required TResult Function( _TracksLoaded value)  tracksLoaded,required TResult Function( _ArtistsLoaded value)  artistsLoaded,required TResult Function( _AlbumsLoaded value)  albumsLoaded,required TResult Function( _SearchResults value)  searchResults,required TResult Function( _ScanComplete value)  scanComplete,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Scanning():
return scanning(_that);case _TracksLoaded():
return tracksLoaded(_that);case _ArtistsLoaded():
return artistsLoaded(_that);case _AlbumsLoaded():
return albumsLoaded(_that);case _SearchResults():
return searchResults(_that);case _ScanComplete():
return scanComplete(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Scanning value)?  scanning,TResult? Function( _TracksLoaded value)?  tracksLoaded,TResult? Function( _ArtistsLoaded value)?  artistsLoaded,TResult? Function( _AlbumsLoaded value)?  albumsLoaded,TResult? Function( _SearchResults value)?  searchResults,TResult? Function( _ScanComplete value)?  scanComplete,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Scanning() when scanning != null:
return scanning(_that);case _TracksLoaded() when tracksLoaded != null:
return tracksLoaded(_that);case _ArtistsLoaded() when artistsLoaded != null:
return artistsLoaded(_that);case _AlbumsLoaded() when albumsLoaded != null:
return albumsLoaded(_that);case _SearchResults() when searchResults != null:
return searchResults(_that);case _ScanComplete() when scanComplete != null:
return scanComplete(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String directoryPath)?  scanning,TResult Function( List<AudioTrack> tracks,  AudioFormat? activeFilter)?  tracksLoaded,TResult Function( List<String> artists)?  artistsLoaded,TResult Function( List<String> albums)?  albumsLoaded,TResult Function( List<AudioTrack> results,  String query)?  searchResults,TResult Function( int tracksAdded)?  scanComplete,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Scanning() when scanning != null:
return scanning(_that.directoryPath);case _TracksLoaded() when tracksLoaded != null:
return tracksLoaded(_that.tracks,_that.activeFilter);case _ArtistsLoaded() when artistsLoaded != null:
return artistsLoaded(_that.artists);case _AlbumsLoaded() when albumsLoaded != null:
return albumsLoaded(_that.albums);case _SearchResults() when searchResults != null:
return searchResults(_that.results,_that.query);case _ScanComplete() when scanComplete != null:
return scanComplete(_that.tracksAdded);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String directoryPath)  scanning,required TResult Function( List<AudioTrack> tracks,  AudioFormat? activeFilter)  tracksLoaded,required TResult Function( List<String> artists)  artistsLoaded,required TResult Function( List<String> albums)  albumsLoaded,required TResult Function( List<AudioTrack> results,  String query)  searchResults,required TResult Function( int tracksAdded)  scanComplete,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Scanning():
return scanning(_that.directoryPath);case _TracksLoaded():
return tracksLoaded(_that.tracks,_that.activeFilter);case _ArtistsLoaded():
return artistsLoaded(_that.artists);case _AlbumsLoaded():
return albumsLoaded(_that.albums);case _SearchResults():
return searchResults(_that.results,_that.query);case _ScanComplete():
return scanComplete(_that.tracksAdded);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String directoryPath)?  scanning,TResult? Function( List<AudioTrack> tracks,  AudioFormat? activeFilter)?  tracksLoaded,TResult? Function( List<String> artists)?  artistsLoaded,TResult? Function( List<String> albums)?  albumsLoaded,TResult? Function( List<AudioTrack> results,  String query)?  searchResults,TResult? Function( int tracksAdded)?  scanComplete,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Scanning() when scanning != null:
return scanning(_that.directoryPath);case _TracksLoaded() when tracksLoaded != null:
return tracksLoaded(_that.tracks,_that.activeFilter);case _ArtistsLoaded() when artistsLoaded != null:
return artistsLoaded(_that.artists);case _AlbumsLoaded() when albumsLoaded != null:
return albumsLoaded(_that.albums);case _SearchResults() when searchResults != null:
return searchResults(_that.results,_that.query);case _ScanComplete() when scanComplete != null:
return scanComplete(_that.tracksAdded);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LibraryState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryState.initial()';
}


}




/// @nodoc


class _Loading implements LibraryState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryState.loading()';
}


}




/// @nodoc


class _Scanning implements LibraryState {
  const _Scanning(this.directoryPath);
  

 final  String directoryPath;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanningCopyWith<_Scanning> get copyWith => __$ScanningCopyWithImpl<_Scanning>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Scanning&&(identical(other.directoryPath, directoryPath) || other.directoryPath == directoryPath));
}


@override
int get hashCode => Object.hash(runtimeType,directoryPath);

@override
String toString() {
  return 'LibraryState.scanning(directoryPath: $directoryPath)';
}


}

/// @nodoc
abstract mixin class _$ScanningCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$ScanningCopyWith(_Scanning value, $Res Function(_Scanning) _then) = __$ScanningCopyWithImpl;
@useResult
$Res call({
 String directoryPath
});




}
/// @nodoc
class __$ScanningCopyWithImpl<$Res>
    implements _$ScanningCopyWith<$Res> {
  __$ScanningCopyWithImpl(this._self, this._then);

  final _Scanning _self;
  final $Res Function(_Scanning) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? directoryPath = null,}) {
  return _then(_Scanning(
null == directoryPath ? _self.directoryPath : directoryPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TracksLoaded implements LibraryState {
  const _TracksLoaded({required final  List<AudioTrack> tracks, this.activeFilter}): _tracks = tracks;
  

 final  List<AudioTrack> _tracks;
 List<AudioTrack> get tracks {
  if (_tracks is EqualUnmodifiableListView) return _tracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tracks);
}

 final  AudioFormat? activeFilter;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TracksLoadedCopyWith<_TracksLoaded> get copyWith => __$TracksLoadedCopyWithImpl<_TracksLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TracksLoaded&&const DeepCollectionEquality().equals(other._tracks, _tracks)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tracks),activeFilter);

@override
String toString() {
  return 'LibraryState.tracksLoaded(tracks: $tracks, activeFilter: $activeFilter)';
}


}

/// @nodoc
abstract mixin class _$TracksLoadedCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$TracksLoadedCopyWith(_TracksLoaded value, $Res Function(_TracksLoaded) _then) = __$TracksLoadedCopyWithImpl;
@useResult
$Res call({
 List<AudioTrack> tracks, AudioFormat? activeFilter
});




}
/// @nodoc
class __$TracksLoadedCopyWithImpl<$Res>
    implements _$TracksLoadedCopyWith<$Res> {
  __$TracksLoadedCopyWithImpl(this._self, this._then);

  final _TracksLoaded _self;
  final $Res Function(_TracksLoaded) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tracks = null,Object? activeFilter = freezed,}) {
  return _then(_TracksLoaded(
tracks: null == tracks ? _self._tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as AudioFormat?,
  ));
}


}

/// @nodoc


class _ArtistsLoaded implements LibraryState {
  const _ArtistsLoaded(final  List<String> artists): _artists = artists;
  

 final  List<String> _artists;
 List<String> get artists {
  if (_artists is EqualUnmodifiableListView) return _artists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_artists);
}


/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtistsLoadedCopyWith<_ArtistsLoaded> get copyWith => __$ArtistsLoadedCopyWithImpl<_ArtistsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtistsLoaded&&const DeepCollectionEquality().equals(other._artists, _artists));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_artists));

@override
String toString() {
  return 'LibraryState.artistsLoaded(artists: $artists)';
}


}

/// @nodoc
abstract mixin class _$ArtistsLoadedCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$ArtistsLoadedCopyWith(_ArtistsLoaded value, $Res Function(_ArtistsLoaded) _then) = __$ArtistsLoadedCopyWithImpl;
@useResult
$Res call({
 List<String> artists
});




}
/// @nodoc
class __$ArtistsLoadedCopyWithImpl<$Res>
    implements _$ArtistsLoadedCopyWith<$Res> {
  __$ArtistsLoadedCopyWithImpl(this._self, this._then);

  final _ArtistsLoaded _self;
  final $Res Function(_ArtistsLoaded) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? artists = null,}) {
  return _then(_ArtistsLoaded(
null == artists ? _self._artists : artists // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _AlbumsLoaded implements LibraryState {
  const _AlbumsLoaded(final  List<String> albums): _albums = albums;
  

 final  List<String> _albums;
 List<String> get albums {
  if (_albums is EqualUnmodifiableListView) return _albums;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_albums);
}


/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumsLoadedCopyWith<_AlbumsLoaded> get copyWith => __$AlbumsLoadedCopyWithImpl<_AlbumsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlbumsLoaded&&const DeepCollectionEquality().equals(other._albums, _albums));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_albums));

@override
String toString() {
  return 'LibraryState.albumsLoaded(albums: $albums)';
}


}

/// @nodoc
abstract mixin class _$AlbumsLoadedCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$AlbumsLoadedCopyWith(_AlbumsLoaded value, $Res Function(_AlbumsLoaded) _then) = __$AlbumsLoadedCopyWithImpl;
@useResult
$Res call({
 List<String> albums
});




}
/// @nodoc
class __$AlbumsLoadedCopyWithImpl<$Res>
    implements _$AlbumsLoadedCopyWith<$Res> {
  __$AlbumsLoadedCopyWithImpl(this._self, this._then);

  final _AlbumsLoaded _self;
  final $Res Function(_AlbumsLoaded) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? albums = null,}) {
  return _then(_AlbumsLoaded(
null == albums ? _self._albums : albums // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _SearchResults implements LibraryState {
  const _SearchResults({required final  List<AudioTrack> results, required this.query}): _results = results;
  

 final  List<AudioTrack> _results;
 List<AudioTrack> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  String query;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultsCopyWith<_SearchResults> get copyWith => __$SearchResultsCopyWithImpl<_SearchResults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResults&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),query);

@override
String toString() {
  return 'LibraryState.searchResults(results: $results, query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchResultsCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$SearchResultsCopyWith(_SearchResults value, $Res Function(_SearchResults) _then) = __$SearchResultsCopyWithImpl;
@useResult
$Res call({
 List<AudioTrack> results, String query
});




}
/// @nodoc
class __$SearchResultsCopyWithImpl<$Res>
    implements _$SearchResultsCopyWith<$Res> {
  __$SearchResultsCopyWithImpl(this._self, this._then);

  final _SearchResults _self;
  final $Res Function(_SearchResults) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? results = null,Object? query = null,}) {
  return _then(_SearchResults(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<AudioTrack>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ScanComplete implements LibraryState {
  const _ScanComplete(this.tracksAdded);
  

 final  int tracksAdded;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanCompleteCopyWith<_ScanComplete> get copyWith => __$ScanCompleteCopyWithImpl<_ScanComplete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanComplete&&(identical(other.tracksAdded, tracksAdded) || other.tracksAdded == tracksAdded));
}


@override
int get hashCode => Object.hash(runtimeType,tracksAdded);

@override
String toString() {
  return 'LibraryState.scanComplete(tracksAdded: $tracksAdded)';
}


}

/// @nodoc
abstract mixin class _$ScanCompleteCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$ScanCompleteCopyWith(_ScanComplete value, $Res Function(_ScanComplete) _then) = __$ScanCompleteCopyWithImpl;
@useResult
$Res call({
 int tracksAdded
});




}
/// @nodoc
class __$ScanCompleteCopyWithImpl<$Res>
    implements _$ScanCompleteCopyWith<$Res> {
  __$ScanCompleteCopyWithImpl(this._self, this._then);

  final _ScanComplete _self;
  final $Res Function(_ScanComplete) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tracksAdded = null,}) {
  return _then(_ScanComplete(
null == tracksAdded ? _self.tracksAdded : tracksAdded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Error implements LibraryState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of LibraryState
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
  return 'LibraryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
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

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
