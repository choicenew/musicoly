// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArtistState {

 ArtistModel? get currentArtist; List<TrackModel> get topTracks; List<AlbumModel> get albums; bool get isLoading; String? get error;
/// Create a copy of ArtistState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtistStateCopyWith<ArtistState> get copyWith => _$ArtistStateCopyWithImpl<ArtistState>(this as ArtistState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArtistState&&(identical(other.currentArtist, currentArtist) || other.currentArtist == currentArtist)&&const DeepCollectionEquality().equals(other.topTracks, topTracks)&&const DeepCollectionEquality().equals(other.albums, albums)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentArtist,const DeepCollectionEquality().hash(topTracks),const DeepCollectionEquality().hash(albums),isLoading,error);

@override
String toString() {
  return 'ArtistState(currentArtist: $currentArtist, topTracks: $topTracks, albums: $albums, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $ArtistStateCopyWith<$Res>  {
  factory $ArtistStateCopyWith(ArtistState value, $Res Function(ArtistState) _then) = _$ArtistStateCopyWithImpl;
@useResult
$Res call({
 ArtistModel? currentArtist, List<TrackModel> topTracks, List<AlbumModel> albums, bool isLoading, String? error
});




}
/// @nodoc
class _$ArtistStateCopyWithImpl<$Res>
    implements $ArtistStateCopyWith<$Res> {
  _$ArtistStateCopyWithImpl(this._self, this._then);

  final ArtistState _self;
  final $Res Function(ArtistState) _then;

/// Create a copy of ArtistState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentArtist = freezed,Object? topTracks = null,Object? albums = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
currentArtist: freezed == currentArtist ? _self.currentArtist : currentArtist // ignore: cast_nullable_to_non_nullable
as ArtistModel?,topTracks: null == topTracks ? _self.topTracks : topTracks // ignore: cast_nullable_to_non_nullable
as List<TrackModel>,albums: null == albums ? _self.albums : albums // ignore: cast_nullable_to_non_nullable
as List<AlbumModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArtistState].
extension ArtistStatePatterns on ArtistState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArtistState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArtistState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArtistState value)  $default,){
final _that = this;
switch (_that) {
case _ArtistState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArtistState value)?  $default,){
final _that = this;
switch (_that) {
case _ArtistState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ArtistModel? currentArtist,  List<TrackModel> topTracks,  List<AlbumModel> albums,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArtistState() when $default != null:
return $default(_that.currentArtist,_that.topTracks,_that.albums,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ArtistModel? currentArtist,  List<TrackModel> topTracks,  List<AlbumModel> albums,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ArtistState():
return $default(_that.currentArtist,_that.topTracks,_that.albums,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ArtistModel? currentArtist,  List<TrackModel> topTracks,  List<AlbumModel> albums,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ArtistState() when $default != null:
return $default(_that.currentArtist,_that.topTracks,_that.albums,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ArtistState implements ArtistState {
  const _ArtistState({this.currentArtist, final  List<TrackModel> topTracks = const [], final  List<AlbumModel> albums = const [], this.isLoading = false, this.error}): _topTracks = topTracks,_albums = albums;
  

@override final  ArtistModel? currentArtist;
 final  List<TrackModel> _topTracks;
@override@JsonKey() List<TrackModel> get topTracks {
  if (_topTracks is EqualUnmodifiableListView) return _topTracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topTracks);
}

 final  List<AlbumModel> _albums;
@override@JsonKey() List<AlbumModel> get albums {
  if (_albums is EqualUnmodifiableListView) return _albums;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_albums);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of ArtistState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtistStateCopyWith<_ArtistState> get copyWith => __$ArtistStateCopyWithImpl<_ArtistState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtistState&&(identical(other.currentArtist, currentArtist) || other.currentArtist == currentArtist)&&const DeepCollectionEquality().equals(other._topTracks, _topTracks)&&const DeepCollectionEquality().equals(other._albums, _albums)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentArtist,const DeepCollectionEquality().hash(_topTracks),const DeepCollectionEquality().hash(_albums),isLoading,error);

@override
String toString() {
  return 'ArtistState(currentArtist: $currentArtist, topTracks: $topTracks, albums: $albums, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ArtistStateCopyWith<$Res> implements $ArtistStateCopyWith<$Res> {
  factory _$ArtistStateCopyWith(_ArtistState value, $Res Function(_ArtistState) _then) = __$ArtistStateCopyWithImpl;
@override @useResult
$Res call({
 ArtistModel? currentArtist, List<TrackModel> topTracks, List<AlbumModel> albums, bool isLoading, String? error
});




}
/// @nodoc
class __$ArtistStateCopyWithImpl<$Res>
    implements _$ArtistStateCopyWith<$Res> {
  __$ArtistStateCopyWithImpl(this._self, this._then);

  final _ArtistState _self;
  final $Res Function(_ArtistState) _then;

/// Create a copy of ArtistState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentArtist = freezed,Object? topTracks = null,Object? albums = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_ArtistState(
currentArtist: freezed == currentArtist ? _self.currentArtist : currentArtist // ignore: cast_nullable_to_non_nullable
as ArtistModel?,topTracks: null == topTracks ? _self._topTracks : topTracks // ignore: cast_nullable_to_non_nullable
as List<TrackModel>,albums: null == albums ? _self._albums : albums // ignore: cast_nullable_to_non_nullable
as List<AlbumModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
