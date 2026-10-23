// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_stats_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayStatsState {

 PlayStatsModel? get currentTrackStats; List<PlayStatsModel> get recentPlays; List<PlayStatsModel> get topTracks; int get totalPlayDuration; int get totalPlayCount; bool get autoRecordPlays; double get completePlayThreshold;
/// Create a copy of PlayStatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayStatsStateCopyWith<PlayStatsState> get copyWith => _$PlayStatsStateCopyWithImpl<PlayStatsState>(this as PlayStatsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayStatsState&&(identical(other.currentTrackStats, currentTrackStats) || other.currentTrackStats == currentTrackStats)&&const DeepCollectionEquality().equals(other.recentPlays, recentPlays)&&const DeepCollectionEquality().equals(other.topTracks, topTracks)&&(identical(other.totalPlayDuration, totalPlayDuration) || other.totalPlayDuration == totalPlayDuration)&&(identical(other.totalPlayCount, totalPlayCount) || other.totalPlayCount == totalPlayCount)&&(identical(other.autoRecordPlays, autoRecordPlays) || other.autoRecordPlays == autoRecordPlays)&&(identical(other.completePlayThreshold, completePlayThreshold) || other.completePlayThreshold == completePlayThreshold));
}


@override
int get hashCode => Object.hash(runtimeType,currentTrackStats,const DeepCollectionEquality().hash(recentPlays),const DeepCollectionEquality().hash(topTracks),totalPlayDuration,totalPlayCount,autoRecordPlays,completePlayThreshold);

@override
String toString() {
  return 'PlayStatsState(currentTrackStats: $currentTrackStats, recentPlays: $recentPlays, topTracks: $topTracks, totalPlayDuration: $totalPlayDuration, totalPlayCount: $totalPlayCount, autoRecordPlays: $autoRecordPlays, completePlayThreshold: $completePlayThreshold)';
}


}

/// @nodoc
abstract mixin class $PlayStatsStateCopyWith<$Res>  {
  factory $PlayStatsStateCopyWith(PlayStatsState value, $Res Function(PlayStatsState) _then) = _$PlayStatsStateCopyWithImpl;
@useResult
$Res call({
 PlayStatsModel? currentTrackStats, List<PlayStatsModel> recentPlays, List<PlayStatsModel> topTracks, int totalPlayDuration, int totalPlayCount, bool autoRecordPlays, double completePlayThreshold
});




}
/// @nodoc
class _$PlayStatsStateCopyWithImpl<$Res>
    implements $PlayStatsStateCopyWith<$Res> {
  _$PlayStatsStateCopyWithImpl(this._self, this._then);

  final PlayStatsState _self;
  final $Res Function(PlayStatsState) _then;

/// Create a copy of PlayStatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentTrackStats = freezed,Object? recentPlays = null,Object? topTracks = null,Object? totalPlayDuration = null,Object? totalPlayCount = null,Object? autoRecordPlays = null,Object? completePlayThreshold = null,}) {
  return _then(_self.copyWith(
currentTrackStats: freezed == currentTrackStats ? _self.currentTrackStats : currentTrackStats // ignore: cast_nullable_to_non_nullable
as PlayStatsModel?,recentPlays: null == recentPlays ? _self.recentPlays : recentPlays // ignore: cast_nullable_to_non_nullable
as List<PlayStatsModel>,topTracks: null == topTracks ? _self.topTracks : topTracks // ignore: cast_nullable_to_non_nullable
as List<PlayStatsModel>,totalPlayDuration: null == totalPlayDuration ? _self.totalPlayDuration : totalPlayDuration // ignore: cast_nullable_to_non_nullable
as int,totalPlayCount: null == totalPlayCount ? _self.totalPlayCount : totalPlayCount // ignore: cast_nullable_to_non_nullable
as int,autoRecordPlays: null == autoRecordPlays ? _self.autoRecordPlays : autoRecordPlays // ignore: cast_nullable_to_non_nullable
as bool,completePlayThreshold: null == completePlayThreshold ? _self.completePlayThreshold : completePlayThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayStatsState].
extension PlayStatsStatePatterns on PlayStatsState {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayStatsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayStatsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayStatsState value)  $default,){
final _that = this;
switch (_that) {
case _PlayStatsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayStatsState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayStatsState() when $default != null:
return $default(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayStatsModel? currentTrackStats,  List<PlayStatsModel> recentPlays,  List<PlayStatsModel> topTracks,  int totalPlayDuration,  int totalPlayCount,  bool autoRecordPlays,  double completePlayThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayStatsState() when $default != null:
return $default(_that.currentTrackStats,_that.recentPlays,_that.topTracks,_that.totalPlayDuration,_that.totalPlayCount,_that.autoRecordPlays,_that.completePlayThreshold);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayStatsModel? currentTrackStats,  List<PlayStatsModel> recentPlays,  List<PlayStatsModel> topTracks,  int totalPlayDuration,  int totalPlayCount,  bool autoRecordPlays,  double completePlayThreshold)  $default,) {final _that = this;
switch (_that) {
case _PlayStatsState():
return $default(_that.currentTrackStats,_that.recentPlays,_that.topTracks,_that.totalPlayDuration,_that.totalPlayCount,_that.autoRecordPlays,_that.completePlayThreshold);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayStatsModel? currentTrackStats,  List<PlayStatsModel> recentPlays,  List<PlayStatsModel> topTracks,  int totalPlayDuration,  int totalPlayCount,  bool autoRecordPlays,  double completePlayThreshold)?  $default,) {final _that = this;
switch (_that) {
case _PlayStatsState() when $default != null:
return $default(_that.currentTrackStats,_that.recentPlays,_that.topTracks,_that.totalPlayDuration,_that.totalPlayCount,_that.autoRecordPlays,_that.completePlayThreshold);case _:
  return null;

}
}

}

/// @nodoc


class _PlayStatsState implements PlayStatsState {
  const _PlayStatsState({this.currentTrackStats, final  List<PlayStatsModel> recentPlays = const [], final  List<PlayStatsModel> topTracks = const [], this.totalPlayDuration = 0, this.totalPlayCount = 0, this.autoRecordPlays = true, this.completePlayThreshold = 0.8}): _recentPlays = recentPlays,_topTracks = topTracks;
  

@override final  PlayStatsModel? currentTrackStats;
 final  List<PlayStatsModel> _recentPlays;
@override@JsonKey() List<PlayStatsModel> get recentPlays {
  if (_recentPlays is EqualUnmodifiableListView) return _recentPlays;
  return EqualUnmodifiableListView(_recentPlays);
}

 final  List<PlayStatsModel> _topTracks;
@override@JsonKey() List<PlayStatsModel> get topTracks {
  if (_topTracks is EqualUnmodifiableListView) return _topTracks;
  return EqualUnmodifiableListView(_topTracks);
}

@override@JsonKey() final  int totalPlayDuration;
@override@JsonKey() final  int totalPlayCount;
@override@JsonKey() final  bool autoRecordPlays;
@override@JsonKey() final  double completePlayThreshold;

/// Create a copy of PlayStatsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayStatsStateCopyWith<_PlayStatsState> get copyWith => __$PlayStatsStateCopyWithImpl<_PlayStatsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayStatsState&&(identical(other.currentTrackStats, currentTrackStats) || other.currentTrackStats == currentTrackStats)&&const DeepCollectionEquality().equals(other._recentPlays, _recentPlays)&&const DeepCollectionEquality().equals(other._topTracks, _topTracks)&&(identical(other.totalPlayDuration, totalPlayDuration) || other.totalPlayDuration == totalPlayDuration)&&(identical(other.totalPlayCount, totalPlayCount) || other.totalPlayCount == totalPlayCount)&&(identical(other.autoRecordPlays, autoRecordPlays) || other.autoRecordPlays == autoRecordPlays)&&(identical(other.completePlayThreshold, completePlayThreshold) || other.completePlayThreshold == completePlayThreshold));
}


@override
int get hashCode => Object.hash(runtimeType,currentTrackStats,const DeepCollectionEquality().hash(_recentPlays),const DeepCollectionEquality().hash(_topTracks),totalPlayDuration,totalPlayCount,autoRecordPlays,completePlayThreshold);

@override
String toString() {
  return 'PlayStatsState(currentTrackStats: $currentTrackStats, recentPlays: $recentPlays, topTracks: $topTracks, totalPlayDuration: $totalPlayDuration, totalPlayCount: $totalPlayCount, autoRecordPlays: $autoRecordPlays, completePlayThreshold: $completePlayThreshold)';
}


}

/// @nodoc
abstract mixin class _$PlayStatsStateCopyWith<$Res> implements $PlayStatsStateCopyWith<$Res> {
  factory _$PlayStatsStateCopyWith(_PlayStatsState value, $Res Function(_PlayStatsState) _then) = __$PlayStatsStateCopyWithImpl;
@override @useResult
$Res call({
 PlayStatsModel? currentTrackStats, List<PlayStatsModel> recentPlays, List<PlayStatsModel> topTracks, int totalPlayDuration, int totalPlayCount, bool autoRecordPlays, double completePlayThreshold
});




}
/// @nodoc
class __$PlayStatsStateCopyWithImpl<$Res>
    implements _$PlayStatsStateCopyWith<$Res> {
  __$PlayStatsStateCopyWithImpl(this._self, this._then);

  final _PlayStatsState _self;
  final $Res Function(_PlayStatsState) _then;

/// Create a copy of PlayStatsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentTrackStats = freezed,Object? recentPlays = null,Object? topTracks = null,Object? totalPlayDuration = null,Object? totalPlayCount = null,Object? autoRecordPlays = null,Object? completePlayThreshold = null,}) {
  return _then(_PlayStatsState(
currentTrackStats: freezed == currentTrackStats ? _self.currentTrackStats : currentTrackStats // ignore: cast_nullable_to_non_nullable
as PlayStatsModel?,recentPlays: null == recentPlays ? _self._recentPlays : recentPlays // ignore: cast_nullable_to_non_nullable
as List<PlayStatsModel>,topTracks: null == topTracks ? _self._topTracks : topTracks // ignore: cast_nullable_to_non_nullable
as List<PlayStatsModel>,totalPlayDuration: null == totalPlayDuration ? _self.totalPlayDuration : totalPlayDuration // ignore: cast_nullable_to_non_nullable
as int,totalPlayCount: null == totalPlayCount ? _self.totalPlayCount : totalPlayCount // ignore: cast_nullable_to_non_nullable
as int,autoRecordPlays: null == autoRecordPlays ? _self.autoRecordPlays : autoRecordPlays // ignore: cast_nullable_to_non_nullable
as bool,completePlayThreshold: null == completePlayThreshold ? _self.completePlayThreshold : completePlayThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
