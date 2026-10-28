// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlbumState {

 AlbumModel? get currentAlbum; List<TrackModel> get albumTracks; bool get isLoading; String? get error;
/// Create a copy of AlbumState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumStateCopyWith<AlbumState> get copyWith => _$AlbumStateCopyWithImpl<AlbumState>(this as AlbumState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlbumState&&(identical(other.currentAlbum, currentAlbum) || other.currentAlbum == currentAlbum)&&const DeepCollectionEquality().equals(other.albumTracks, albumTracks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentAlbum,const DeepCollectionEquality().hash(albumTracks),isLoading,error);

@override
String toString() {
  return 'AlbumState(currentAlbum: $currentAlbum, albumTracks: $albumTracks, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $AlbumStateCopyWith<$Res>  {
  factory $AlbumStateCopyWith(AlbumState value, $Res Function(AlbumState) _then) = _$AlbumStateCopyWithImpl;
@useResult
$Res call({
 AlbumModel? currentAlbum, List<TrackModel> albumTracks, bool isLoading, String? error
});




}
/// @nodoc
class _$AlbumStateCopyWithImpl<$Res>
    implements $AlbumStateCopyWith<$Res> {
  _$AlbumStateCopyWithImpl(this._self, this._then);

  final AlbumState _self;
  final $Res Function(AlbumState) _then;

/// Create a copy of AlbumState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentAlbum = freezed,Object? albumTracks = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
currentAlbum: freezed == currentAlbum ? _self.currentAlbum : currentAlbum // ignore: cast_nullable_to_non_nullable
as AlbumModel?,albumTracks: null == albumTracks ? _self.albumTracks : albumTracks // ignore: cast_nullable_to_non_nullable
as List<TrackModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlbumState].
extension AlbumStatePatterns on AlbumState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlbumState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlbumState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlbumState value)  $default,){
final _that = this;
switch (_that) {
case _AlbumState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlbumState value)?  $default,){
final _that = this;
switch (_that) {
case _AlbumState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AlbumModel? currentAlbum,  List<TrackModel> albumTracks,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlbumState() when $default != null:
return $default(_that.currentAlbum,_that.albumTracks,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AlbumModel? currentAlbum,  List<TrackModel> albumTracks,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _AlbumState():
return $default(_that.currentAlbum,_that.albumTracks,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AlbumModel? currentAlbum,  List<TrackModel> albumTracks,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _AlbumState() when $default != null:
return $default(_that.currentAlbum,_that.albumTracks,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _AlbumState implements AlbumState {
  const _AlbumState({this.currentAlbum, final  List<TrackModel> albumTracks = const [], this.isLoading = false, this.error}): _albumTracks = albumTracks;
  

@override final  AlbumModel? currentAlbum;
 final  List<TrackModel> _albumTracks;
@override@JsonKey() List<TrackModel> get albumTracks {
  if (_albumTracks is EqualUnmodifiableListView) return _albumTracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_albumTracks);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of AlbumState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumStateCopyWith<_AlbumState> get copyWith => __$AlbumStateCopyWithImpl<_AlbumState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlbumState&&(identical(other.currentAlbum, currentAlbum) || other.currentAlbum == currentAlbum)&&const DeepCollectionEquality().equals(other._albumTracks, _albumTracks)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentAlbum,const DeepCollectionEquality().hash(_albumTracks),isLoading,error);

@override
String toString() {
  return 'AlbumState(currentAlbum: $currentAlbum, albumTracks: $albumTracks, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$AlbumStateCopyWith<$Res> implements $AlbumStateCopyWith<$Res> {
  factory _$AlbumStateCopyWith(_AlbumState value, $Res Function(_AlbumState) _then) = __$AlbumStateCopyWithImpl;
@override @useResult
$Res call({
 AlbumModel? currentAlbum, List<TrackModel> albumTracks, bool isLoading, String? error
});




}
/// @nodoc
class __$AlbumStateCopyWithImpl<$Res>
    implements _$AlbumStateCopyWith<$Res> {
  __$AlbumStateCopyWithImpl(this._self, this._then);

  final _AlbumState _self;
  final $Res Function(_AlbumState) _then;

/// Create a copy of AlbumState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentAlbum = freezed,Object? albumTracks = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_AlbumState(
currentAlbum: freezed == currentAlbum ? _self.currentAlbum : currentAlbum // ignore: cast_nullable_to_non_nullable
as AlbumModel?,albumTracks: null == albumTracks ? _self._albumTracks : albumTracks // ignore: cast_nullable_to_non_nullable
as List<TrackModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
