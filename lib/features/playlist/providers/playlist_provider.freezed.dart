// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaylistStateData {

 PlaylistInterface? get selectedPlaylist; List<TrackInterface>? get playlistTracks; bool get isLoading; Object? get error;
/// Create a copy of PlaylistStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaylistStateDataCopyWith<PlaylistStateData> get copyWith => _$PlaylistStateDataCopyWithImpl<PlaylistStateData>(this as PlaylistStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaylistStateData&&(identical(other.selectedPlaylist, selectedPlaylist) || other.selectedPlaylist == selectedPlaylist)&&const DeepCollectionEquality().equals(other.playlistTracks, playlistTracks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPlaylist,const DeepCollectionEquality().hash(playlistTracks),isLoading,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PlaylistStateData(selectedPlaylist: $selectedPlaylist, playlistTracks: $playlistTracks, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $PlaylistStateDataCopyWith<$Res>  {
  factory $PlaylistStateDataCopyWith(PlaylistStateData value, $Res Function(PlaylistStateData) _then) = _$PlaylistStateDataCopyWithImpl;
@useResult
$Res call({
 PlaylistInterface? selectedPlaylist, List<TrackInterface>? playlistTracks, bool isLoading, Object? error
});




}
/// @nodoc
class _$PlaylistStateDataCopyWithImpl<$Res>
    implements $PlaylistStateDataCopyWith<$Res> {
  _$PlaylistStateDataCopyWithImpl(this._self, this._then);

  final PlaylistStateData _self;
  final $Res Function(PlaylistStateData) _then;

/// Create a copy of PlaylistStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedPlaylist = freezed,Object? playlistTracks = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
selectedPlaylist: freezed == selectedPlaylist ? _self.selectedPlaylist : selectedPlaylist // ignore: cast_nullable_to_non_nullable
as PlaylistInterface?,playlistTracks: freezed == playlistTracks ? _self.playlistTracks : playlistTracks // ignore: cast_nullable_to_non_nullable
as List<TrackInterface>?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaylistStateData].
extension PlaylistStateDataPatterns on PlaylistStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaylistStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaylistStateData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaylistStateData value)  $default,){
final _that = this;
switch (_that) {
case _PlaylistStateData():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaylistStateData value)?  $default,){
final _that = this;
switch (_that) {
case _PlaylistStateData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlaylistInterface? selectedPlaylist,  List<TrackInterface>? playlistTracks,  bool isLoading,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaylistStateData() when $default != null:
return $default(_that.selectedPlaylist,_that.playlistTracks,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlaylistInterface? selectedPlaylist,  List<TrackInterface>? playlistTracks,  bool isLoading,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _PlaylistStateData():
return $default(_that.selectedPlaylist,_that.playlistTracks,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlaylistInterface? selectedPlaylist,  List<TrackInterface>? playlistTracks,  bool isLoading,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _PlaylistStateData() when $default != null:
return $default(_that.selectedPlaylist,_that.playlistTracks,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PlaylistStateData implements PlaylistStateData {
  const _PlaylistStateData({this.selectedPlaylist, final  List<TrackInterface>? playlistTracks, this.isLoading = false, this.error}): _playlistTracks = playlistTracks;
  

@override final  PlaylistInterface? selectedPlaylist;
 final  List<TrackInterface>? _playlistTracks;
@override List<TrackInterface>? get playlistTracks {
  final value = _playlistTracks;
  if (value == null) return null;
  if (_playlistTracks is EqualUnmodifiableListView) return _playlistTracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isLoading;
@override final  Object? error;

/// Create a copy of PlaylistStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaylistStateDataCopyWith<_PlaylistStateData> get copyWith => __$PlaylistStateDataCopyWithImpl<_PlaylistStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaylistStateData&&(identical(other.selectedPlaylist, selectedPlaylist) || other.selectedPlaylist == selectedPlaylist)&&const DeepCollectionEquality().equals(other._playlistTracks, _playlistTracks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPlaylist,const DeepCollectionEquality().hash(_playlistTracks),isLoading,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PlaylistStateData(selectedPlaylist: $selectedPlaylist, playlistTracks: $playlistTracks, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PlaylistStateDataCopyWith<$Res> implements $PlaylistStateDataCopyWith<$Res> {
  factory _$PlaylistStateDataCopyWith(_PlaylistStateData value, $Res Function(_PlaylistStateData) _then) = __$PlaylistStateDataCopyWithImpl;
@override @useResult
$Res call({
 PlaylistInterface? selectedPlaylist, List<TrackInterface>? playlistTracks, bool isLoading, Object? error
});




}
/// @nodoc
class __$PlaylistStateDataCopyWithImpl<$Res>
    implements _$PlaylistStateDataCopyWith<$Res> {
  __$PlaylistStateDataCopyWithImpl(this._self, this._then);

  final _PlaylistStateData _self;
  final $Res Function(_PlaylistStateData) _then;

/// Create a copy of PlaylistStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPlaylist = freezed,Object? playlistTracks = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_PlaylistStateData(
selectedPlaylist: freezed == selectedPlaylist ? _self.selectedPlaylist : selectedPlaylist // ignore: cast_nullable_to_non_nullable
as PlaylistInterface?,playlistTracks: freezed == playlistTracks ? _self._playlistTracks : playlistTracks // ignore: cast_nullable_to_non_nullable
as List<TrackInterface>?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
