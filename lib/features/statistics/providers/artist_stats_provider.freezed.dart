// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist_stats_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArtistStatsState {

 List<ArtistStatsModel> get currentArtistStats; List<ArtistStatsModel> get topArtists;
/// Create a copy of ArtistStatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtistStatsStateCopyWith<ArtistStatsState> get copyWith => _$ArtistStatsStateCopyWithImpl<ArtistStatsState>(this as ArtistStatsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArtistStatsState&&const DeepCollectionEquality().equals(other.currentArtistStats, currentArtistStats)&&const DeepCollectionEquality().equals(other.topArtists, topArtists));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentArtistStats),const DeepCollectionEquality().hash(topArtists));

@override
String toString() {
  return 'ArtistStatsState(currentArtistStats: $currentArtistStats, topArtists: $topArtists)';
}


}

/// @nodoc
abstract mixin class $ArtistStatsStateCopyWith<$Res>  {
  factory $ArtistStatsStateCopyWith(ArtistStatsState value, $Res Function(ArtistStatsState) _then) = _$ArtistStatsStateCopyWithImpl;
@useResult
$Res call({
 List<ArtistStatsModel> currentArtistStats, List<ArtistStatsModel> topArtists
});




}
/// @nodoc
class _$ArtistStatsStateCopyWithImpl<$Res>
    implements $ArtistStatsStateCopyWith<$Res> {
  _$ArtistStatsStateCopyWithImpl(this._self, this._then);

  final ArtistStatsState _self;
  final $Res Function(ArtistStatsState) _then;

/// Create a copy of ArtistStatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentArtistStats = null,Object? topArtists = null,}) {
  return _then(_self.copyWith(
currentArtistStats: null == currentArtistStats ? _self.currentArtistStats : currentArtistStats // ignore: cast_nullable_to_non_nullable
as List<ArtistStatsModel>,topArtists: null == topArtists ? _self.topArtists : topArtists // ignore: cast_nullable_to_non_nullable
as List<ArtistStatsModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArtistStatsState].
extension ArtistStatsStatePatterns on ArtistStatsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArtistStatsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArtistStatsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArtistStatsState value)  $default,){
final _that = this;
switch (_that) {
case _ArtistStatsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArtistStatsState value)?  $default,){
final _that = this;
switch (_that) {
case _ArtistStatsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ArtistStatsModel> currentArtistStats,  List<ArtistStatsModel> topArtists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArtistStatsState() when $default != null:
return $default(_that.currentArtistStats,_that.topArtists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ArtistStatsModel> currentArtistStats,  List<ArtistStatsModel> topArtists)  $default,) {final _that = this;
switch (_that) {
case _ArtistStatsState():
return $default(_that.currentArtistStats,_that.topArtists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ArtistStatsModel> currentArtistStats,  List<ArtistStatsModel> topArtists)?  $default,) {final _that = this;
switch (_that) {
case _ArtistStatsState() when $default != null:
return $default(_that.currentArtistStats,_that.topArtists);case _:
  return null;

}
}

}

/// @nodoc


class _ArtistStatsState implements ArtistStatsState {
  const _ArtistStatsState({final  List<ArtistStatsModel> currentArtistStats = const [], final  List<ArtistStatsModel> topArtists = const []}): _currentArtistStats = currentArtistStats,_topArtists = topArtists;
  

 final  List<ArtistStatsModel> _currentArtistStats;
@override@JsonKey() List<ArtistStatsModel> get currentArtistStats {
  if (_currentArtistStats is EqualUnmodifiableListView) return _currentArtistStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentArtistStats);
}

 final  List<ArtistStatsModel> _topArtists;
@override@JsonKey() List<ArtistStatsModel> get topArtists {
  if (_topArtists is EqualUnmodifiableListView) return _topArtists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topArtists);
}


/// Create a copy of ArtistStatsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtistStatsStateCopyWith<_ArtistStatsState> get copyWith => __$ArtistStatsStateCopyWithImpl<_ArtistStatsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtistStatsState&&const DeepCollectionEquality().equals(other._currentArtistStats, _currentArtistStats)&&const DeepCollectionEquality().equals(other._topArtists, _topArtists));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_currentArtistStats),const DeepCollectionEquality().hash(_topArtists));

@override
String toString() {
  return 'ArtistStatsState(currentArtistStats: $currentArtistStats, topArtists: $topArtists)';
}


}

/// @nodoc
abstract mixin class _$ArtistStatsStateCopyWith<$Res> implements $ArtistStatsStateCopyWith<$Res> {
  factory _$ArtistStatsStateCopyWith(_ArtistStatsState value, $Res Function(_ArtistStatsState) _then) = __$ArtistStatsStateCopyWithImpl;
@override @useResult
$Res call({
 List<ArtistStatsModel> currentArtistStats, List<ArtistStatsModel> topArtists
});




}
/// @nodoc
class __$ArtistStatsStateCopyWithImpl<$Res>
    implements _$ArtistStatsStateCopyWith<$Res> {
  __$ArtistStatsStateCopyWithImpl(this._self, this._then);

  final _ArtistStatsState _self;
  final $Res Function(_ArtistStatsState) _then;

/// Create a copy of ArtistStatsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentArtistStats = null,Object? topArtists = null,}) {
  return _then(_ArtistStatsState(
currentArtistStats: null == currentArtistStats ? _self._currentArtistStats : currentArtistStats // ignore: cast_nullable_to_non_nullable
as List<ArtistStatsModel>,topArtists: null == topArtists ? _self._topArtists : topArtists // ignore: cast_nullable_to_non_nullable
as List<ArtistStatsModel>,
  ));
}


}

// dart format on
