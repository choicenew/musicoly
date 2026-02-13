// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaybackStateData {

 Duration get position; Duration get bufferedPosition; Duration get duration; PlaybackState get playbackState; double get volume; RepeatMode get repeatMode; bool get shuffleMode; String? get currentTrackId;
/// Create a copy of PlaybackStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackStateDataCopyWith<PlaybackStateData> get copyWith => _$PlaybackStateDataCopyWithImpl<PlaybackStateData>(this as PlaybackStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackStateData&&(identical(other.position, position) || other.position == position)&&(identical(other.bufferedPosition, bufferedPosition) || other.bufferedPosition == bufferedPosition)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playbackState, playbackState) || other.playbackState == playbackState)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.repeatMode, repeatMode) || other.repeatMode == repeatMode)&&(identical(other.shuffleMode, shuffleMode) || other.shuffleMode == shuffleMode)&&(identical(other.currentTrackId, currentTrackId) || other.currentTrackId == currentTrackId));
}


@override
int get hashCode => Object.hash(runtimeType,position,bufferedPosition,duration,playbackState,volume,repeatMode,shuffleMode,currentTrackId);

@override
String toString() {
  return 'PlaybackStateData(position: $position, bufferedPosition: $bufferedPosition, duration: $duration, playbackState: $playbackState, volume: $volume, repeatMode: $repeatMode, shuffleMode: $shuffleMode, currentTrackId: $currentTrackId)';
}


}

/// @nodoc
abstract mixin class $PlaybackStateDataCopyWith<$Res>  {
  factory $PlaybackStateDataCopyWith(PlaybackStateData value, $Res Function(PlaybackStateData) _then) = _$PlaybackStateDataCopyWithImpl;
@useResult
$Res call({
 Duration position, Duration bufferedPosition, Duration duration, PlaybackState playbackState, double volume, RepeatMode repeatMode, bool shuffleMode, String? currentTrackId
});




}
/// @nodoc
class _$PlaybackStateDataCopyWithImpl<$Res>
    implements $PlaybackStateDataCopyWith<$Res> {
  _$PlaybackStateDataCopyWithImpl(this._self, this._then);

  final PlaybackStateData _self;
  final $Res Function(PlaybackStateData) _then;

/// Create a copy of PlaybackStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? bufferedPosition = null,Object? duration = null,Object? playbackState = null,Object? volume = null,Object? repeatMode = null,Object? shuffleMode = null,Object? currentTrackId = freezed,}) {
  return _then(_self.copyWith(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,bufferedPosition: null == bufferedPosition ? _self.bufferedPosition : bufferedPosition // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,playbackState: null == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,repeatMode: null == repeatMode ? _self.repeatMode : repeatMode // ignore: cast_nullable_to_non_nullable
as RepeatMode,shuffleMode: null == shuffleMode ? _self.shuffleMode : shuffleMode // ignore: cast_nullable_to_non_nullable
as bool,currentTrackId: freezed == currentTrackId ? _self.currentTrackId : currentTrackId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackStateData].
extension PlaybackStateDataPatterns on PlaybackStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackStateData value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackStateData value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration position,  Duration bufferedPosition,  Duration duration,  PlaybackState playbackState,  double volume,  RepeatMode repeatMode,  bool shuffleMode,  String? currentTrackId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackStateData() when $default != null:
return $default(_that.position,_that.bufferedPosition,_that.duration,_that.playbackState,_that.volume,_that.repeatMode,_that.shuffleMode,_that.currentTrackId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration position,  Duration bufferedPosition,  Duration duration,  PlaybackState playbackState,  double volume,  RepeatMode repeatMode,  bool shuffleMode,  String? currentTrackId)  $default,) {final _that = this;
switch (_that) {
case _PlaybackStateData():
return $default(_that.position,_that.bufferedPosition,_that.duration,_that.playbackState,_that.volume,_that.repeatMode,_that.shuffleMode,_that.currentTrackId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration position,  Duration bufferedPosition,  Duration duration,  PlaybackState playbackState,  double volume,  RepeatMode repeatMode,  bool shuffleMode,  String? currentTrackId)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackStateData() when $default != null:
return $default(_that.position,_that.bufferedPosition,_that.duration,_that.playbackState,_that.volume,_that.repeatMode,_that.shuffleMode,_that.currentTrackId);case _:
  return null;

}
}

}

/// @nodoc


class _PlaybackStateData implements PlaybackStateData {
  const _PlaybackStateData({this.position = Duration.zero, this.bufferedPosition = Duration.zero, this.duration = Duration.zero, this.playbackState = PlaybackState.none, this.volume = 1.0, this.repeatMode = RepeatMode.off, this.shuffleMode = false, this.currentTrackId});
  

@override@JsonKey() final  Duration position;
@override@JsonKey() final  Duration bufferedPosition;
@override@JsonKey() final  Duration duration;
@override@JsonKey() final  PlaybackState playbackState;
@override@JsonKey() final  double volume;
@override@JsonKey() final  RepeatMode repeatMode;
@override@JsonKey() final  bool shuffleMode;
@override final  String? currentTrackId;

/// Create a copy of PlaybackStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackStateDataCopyWith<_PlaybackStateData> get copyWith => __$PlaybackStateDataCopyWithImpl<_PlaybackStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackStateData&&(identical(other.position, position) || other.position == position)&&(identical(other.bufferedPosition, bufferedPosition) || other.bufferedPosition == bufferedPosition)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playbackState, playbackState) || other.playbackState == playbackState)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.repeatMode, repeatMode) || other.repeatMode == repeatMode)&&(identical(other.shuffleMode, shuffleMode) || other.shuffleMode == shuffleMode)&&(identical(other.currentTrackId, currentTrackId) || other.currentTrackId == currentTrackId));
}


@override
int get hashCode => Object.hash(runtimeType,position,bufferedPosition,duration,playbackState,volume,repeatMode,shuffleMode,currentTrackId);

@override
String toString() {
  return 'PlaybackStateData(position: $position, bufferedPosition: $bufferedPosition, duration: $duration, playbackState: $playbackState, volume: $volume, repeatMode: $repeatMode, shuffleMode: $shuffleMode, currentTrackId: $currentTrackId)';
}


}

/// @nodoc
abstract mixin class _$PlaybackStateDataCopyWith<$Res> implements $PlaybackStateDataCopyWith<$Res> {
  factory _$PlaybackStateDataCopyWith(_PlaybackStateData value, $Res Function(_PlaybackStateData) _then) = __$PlaybackStateDataCopyWithImpl;
@override @useResult
$Res call({
 Duration position, Duration bufferedPosition, Duration duration, PlaybackState playbackState, double volume, RepeatMode repeatMode, bool shuffleMode, String? currentTrackId
});




}
/// @nodoc
class __$PlaybackStateDataCopyWithImpl<$Res>
    implements _$PlaybackStateDataCopyWith<$Res> {
  __$PlaybackStateDataCopyWithImpl(this._self, this._then);

  final _PlaybackStateData _self;
  final $Res Function(_PlaybackStateData) _then;

/// Create a copy of PlaybackStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? bufferedPosition = null,Object? duration = null,Object? playbackState = null,Object? volume = null,Object? repeatMode = null,Object? shuffleMode = null,Object? currentTrackId = freezed,}) {
  return _then(_PlaybackStateData(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,bufferedPosition: null == bufferedPosition ? _self.bufferedPosition : bufferedPosition // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,playbackState: null == playbackState ? _self.playbackState : playbackState // ignore: cast_nullable_to_non_nullable
as PlaybackState,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,repeatMode: null == repeatMode ? _self.repeatMode : repeatMode // ignore: cast_nullable_to_non_nullable
as RepeatMode,shuffleMode: null == shuffleMode ? _self.shuffleMode : shuffleMode // ignore: cast_nullable_to_non_nullable
as bool,currentTrackId: freezed == currentTrackId ? _self.currentTrackId : currentTrackId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
