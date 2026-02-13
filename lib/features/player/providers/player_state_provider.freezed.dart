// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerState implements DiagnosticableTreeMixin {

 String? get currentTrackId; String? get sourceId; String? get sourceName; bool get isPlaying; bool get isReady; bool get isLoading; bool get hasError; String? get errorMessage; TrackInterface? get currentTrack; int get position;
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStateCopyWith<PlayerState> get copyWith => _$PlayerStateCopyWithImpl<PlayerState>(this as PlayerState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlayerState'))
    ..add(DiagnosticsProperty('currentTrackId', currentTrackId))..add(DiagnosticsProperty('sourceId', sourceId))..add(DiagnosticsProperty('sourceName', sourceName))..add(DiagnosticsProperty('isPlaying', isPlaying))..add(DiagnosticsProperty('isReady', isReady))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('hasError', hasError))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('currentTrack', currentTrack))..add(DiagnosticsProperty('position', position));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerState&&(identical(other.currentTrackId, currentTrackId) || other.currentTrackId == currentTrackId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isReady, isReady) || other.isReady == isReady)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentTrack, currentTrack) || other.currentTrack == currentTrack)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,currentTrackId,sourceId,sourceName,isPlaying,isReady,isLoading,hasError,errorMessage,currentTrack,position);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlayerState(currentTrackId: $currentTrackId, sourceId: $sourceId, sourceName: $sourceName, isPlaying: $isPlaying, isReady: $isReady, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, currentTrack: $currentTrack, position: $position)';
}


}

/// @nodoc
abstract mixin class $PlayerStateCopyWith<$Res>  {
  factory $PlayerStateCopyWith(PlayerState value, $Res Function(PlayerState) _then) = _$PlayerStateCopyWithImpl;
@useResult
$Res call({
 String? currentTrackId, String? sourceId, String? sourceName, bool isPlaying, bool isReady, bool isLoading, bool hasError, String? errorMessage, TrackInterface? currentTrack, int position
});




}
/// @nodoc
class _$PlayerStateCopyWithImpl<$Res>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._self, this._then);

  final PlayerState _self;
  final $Res Function(PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentTrackId = freezed,Object? sourceId = freezed,Object? sourceName = freezed,Object? isPlaying = null,Object? isReady = null,Object? isLoading = null,Object? hasError = null,Object? errorMessage = freezed,Object? currentTrack = freezed,Object? position = null,}) {
  return _then(_self.copyWith(
currentTrackId: freezed == currentTrackId ? _self.currentTrackId : currentTrackId // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,sourceName: freezed == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String?,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentTrack: freezed == currentTrack ? _self.currentTrack : currentTrack // ignore: cast_nullable_to_non_nullable
as TrackInterface?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerState].
extension PlayerStatePatterns on PlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? currentTrackId,  String? sourceId,  String? sourceName,  bool isPlaying,  bool isReady,  bool isLoading,  bool hasError,  String? errorMessage,  TrackInterface? currentTrack,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.currentTrackId,_that.sourceId,_that.sourceName,_that.isPlaying,_that.isReady,_that.isLoading,_that.hasError,_that.errorMessage,_that.currentTrack,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? currentTrackId,  String? sourceId,  String? sourceName,  bool isPlaying,  bool isReady,  bool isLoading,  bool hasError,  String? errorMessage,  TrackInterface? currentTrack,  int position)  $default,) {final _that = this;
switch (_that) {
case _PlayerState():
return $default(_that.currentTrackId,_that.sourceId,_that.sourceName,_that.isPlaying,_that.isReady,_that.isLoading,_that.hasError,_that.errorMessage,_that.currentTrack,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? currentTrackId,  String? sourceId,  String? sourceName,  bool isPlaying,  bool isReady,  bool isLoading,  bool hasError,  String? errorMessage,  TrackInterface? currentTrack,  int position)?  $default,) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.currentTrackId,_that.sourceId,_that.sourceName,_that.isPlaying,_that.isReady,_that.isLoading,_that.hasError,_that.errorMessage,_that.currentTrack,_that.position);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerState with DiagnosticableTreeMixin implements PlayerState {
  const _PlayerState({this.currentTrackId, this.sourceId, this.sourceName, this.isPlaying = false, this.isReady = false, this.isLoading = false, this.hasError = false, this.errorMessage, this.currentTrack, this.position = 0});
  

@override final  String? currentTrackId;
@override final  String? sourceId;
@override final  String? sourceName;
@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool isReady;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasError;
@override final  String? errorMessage;
@override final  TrackInterface? currentTrack;
@override@JsonKey() final  int position;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerStateCopyWith<_PlayerState> get copyWith => __$PlayerStateCopyWithImpl<_PlayerState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlayerState'))
    ..add(DiagnosticsProperty('currentTrackId', currentTrackId))..add(DiagnosticsProperty('sourceId', sourceId))..add(DiagnosticsProperty('sourceName', sourceName))..add(DiagnosticsProperty('isPlaying', isPlaying))..add(DiagnosticsProperty('isReady', isReady))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('hasError', hasError))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('currentTrack', currentTrack))..add(DiagnosticsProperty('position', position));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerState&&(identical(other.currentTrackId, currentTrackId) || other.currentTrackId == currentTrackId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isReady, isReady) || other.isReady == isReady)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentTrack, currentTrack) || other.currentTrack == currentTrack)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,currentTrackId,sourceId,sourceName,isPlaying,isReady,isLoading,hasError,errorMessage,currentTrack,position);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlayerState(currentTrackId: $currentTrackId, sourceId: $sourceId, sourceName: $sourceName, isPlaying: $isPlaying, isReady: $isReady, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, currentTrack: $currentTrack, position: $position)';
}


}

/// @nodoc
abstract mixin class _$PlayerStateCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory _$PlayerStateCopyWith(_PlayerState value, $Res Function(_PlayerState) _then) = __$PlayerStateCopyWithImpl;
@override @useResult
$Res call({
 String? currentTrackId, String? sourceId, String? sourceName, bool isPlaying, bool isReady, bool isLoading, bool hasError, String? errorMessage, TrackInterface? currentTrack, int position
});




}
/// @nodoc
class __$PlayerStateCopyWithImpl<$Res>
    implements _$PlayerStateCopyWith<$Res> {
  __$PlayerStateCopyWithImpl(this._self, this._then);

  final _PlayerState _self;
  final $Res Function(_PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentTrackId = freezed,Object? sourceId = freezed,Object? sourceName = freezed,Object? isPlaying = null,Object? isReady = null,Object? isLoading = null,Object? hasError = null,Object? errorMessage = freezed,Object? currentTrack = freezed,Object? position = null,}) {
  return _then(_PlayerState(
currentTrackId: freezed == currentTrackId ? _self.currentTrackId : currentTrackId // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,sourceName: freezed == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String?,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentTrack: freezed == currentTrack ? _self.currentTrack : currentTrack // ignore: cast_nullable_to_non_nullable
as TrackInterface?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
