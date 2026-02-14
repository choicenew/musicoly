// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lyric_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LyricState implements DiagnosticableTreeMixin {

 LyricData? get currentLyrics; bool get showSyncedLyrics; Duration get currentPosition; int get currentLyricIndex; bool get isEditMode; bool get isLoading; String? get error;
/// Create a copy of LyricState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LyricStateCopyWith<LyricState> get copyWith => _$LyricStateCopyWithImpl<LyricState>(this as LyricState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LyricState'))
    ..add(DiagnosticsProperty('currentLyrics', currentLyrics))..add(DiagnosticsProperty('showSyncedLyrics', showSyncedLyrics))..add(DiagnosticsProperty('currentPosition', currentPosition))..add(DiagnosticsProperty('currentLyricIndex', currentLyricIndex))..add(DiagnosticsProperty('isEditMode', isEditMode))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LyricState&&(identical(other.currentLyrics, currentLyrics) || other.currentLyrics == currentLyrics)&&(identical(other.showSyncedLyrics, showSyncedLyrics) || other.showSyncedLyrics == showSyncedLyrics)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.currentLyricIndex, currentLyricIndex) || other.currentLyricIndex == currentLyricIndex)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentLyrics,showSyncedLyrics,currentPosition,currentLyricIndex,isEditMode,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LyricState(currentLyrics: $currentLyrics, showSyncedLyrics: $showSyncedLyrics, currentPosition: $currentPosition, currentLyricIndex: $currentLyricIndex, isEditMode: $isEditMode, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $LyricStateCopyWith<$Res>  {
  factory $LyricStateCopyWith(LyricState value, $Res Function(LyricState) _then) = _$LyricStateCopyWithImpl;
@useResult
$Res call({
 LyricData? currentLyrics, bool showSyncedLyrics, Duration currentPosition, int currentLyricIndex, bool isEditMode, bool isLoading, String? error
});




}
/// @nodoc
class _$LyricStateCopyWithImpl<$Res>
    implements $LyricStateCopyWith<$Res> {
  _$LyricStateCopyWithImpl(this._self, this._then);

  final LyricState _self;
  final $Res Function(LyricState) _then;

/// Create a copy of LyricState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentLyrics = freezed,Object? showSyncedLyrics = null,Object? currentPosition = null,Object? currentLyricIndex = null,Object? isEditMode = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
currentLyrics: freezed == currentLyrics ? _self.currentLyrics : currentLyrics // ignore: cast_nullable_to_non_nullable
as LyricData?,showSyncedLyrics: null == showSyncedLyrics ? _self.showSyncedLyrics : showSyncedLyrics // ignore: cast_nullable_to_non_nullable
as bool,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as Duration,currentLyricIndex: null == currentLyricIndex ? _self.currentLyricIndex : currentLyricIndex // ignore: cast_nullable_to_non_nullable
as int,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LyricState].
extension LyricStatePatterns on LyricState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LyricState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LyricState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LyricState value)  $default,){
final _that = this;
switch (_that) {
case _LyricState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LyricState value)?  $default,){
final _that = this;
switch (_that) {
case _LyricState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LyricData? currentLyrics,  bool showSyncedLyrics,  Duration currentPosition,  int currentLyricIndex,  bool isEditMode,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LyricState() when $default != null:
return $default(_that.currentLyrics,_that.showSyncedLyrics,_that.currentPosition,_that.currentLyricIndex,_that.isEditMode,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LyricData? currentLyrics,  bool showSyncedLyrics,  Duration currentPosition,  int currentLyricIndex,  bool isEditMode,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _LyricState():
return $default(_that.currentLyrics,_that.showSyncedLyrics,_that.currentPosition,_that.currentLyricIndex,_that.isEditMode,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LyricData? currentLyrics,  bool showSyncedLyrics,  Duration currentPosition,  int currentLyricIndex,  bool isEditMode,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _LyricState() when $default != null:
return $default(_that.currentLyrics,_that.showSyncedLyrics,_that.currentPosition,_that.currentLyricIndex,_that.isEditMode,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _LyricState with DiagnosticableTreeMixin implements LyricState {
  const _LyricState({this.currentLyrics, this.showSyncedLyrics = true, this.currentPosition = Duration.zero, this.currentLyricIndex = -1, this.isEditMode = false, this.isLoading = false, this.error});
  

@override final  LyricData? currentLyrics;
@override@JsonKey() final  bool showSyncedLyrics;
@override@JsonKey() final  Duration currentPosition;
@override@JsonKey() final  int currentLyricIndex;
@override@JsonKey() final  bool isEditMode;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of LyricState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LyricStateCopyWith<_LyricState> get copyWith => __$LyricStateCopyWithImpl<_LyricState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LyricState'))
    ..add(DiagnosticsProperty('currentLyrics', currentLyrics))..add(DiagnosticsProperty('showSyncedLyrics', showSyncedLyrics))..add(DiagnosticsProperty('currentPosition', currentPosition))..add(DiagnosticsProperty('currentLyricIndex', currentLyricIndex))..add(DiagnosticsProperty('isEditMode', isEditMode))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LyricState&&(identical(other.currentLyrics, currentLyrics) || other.currentLyrics == currentLyrics)&&(identical(other.showSyncedLyrics, showSyncedLyrics) || other.showSyncedLyrics == showSyncedLyrics)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.currentLyricIndex, currentLyricIndex) || other.currentLyricIndex == currentLyricIndex)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentLyrics,showSyncedLyrics,currentPosition,currentLyricIndex,isEditMode,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LyricState(currentLyrics: $currentLyrics, showSyncedLyrics: $showSyncedLyrics, currentPosition: $currentPosition, currentLyricIndex: $currentLyricIndex, isEditMode: $isEditMode, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$LyricStateCopyWith<$Res> implements $LyricStateCopyWith<$Res> {
  factory _$LyricStateCopyWith(_LyricState value, $Res Function(_LyricState) _then) = __$LyricStateCopyWithImpl;
@override @useResult
$Res call({
 LyricData? currentLyrics, bool showSyncedLyrics, Duration currentPosition, int currentLyricIndex, bool isEditMode, bool isLoading, String? error
});




}
/// @nodoc
class __$LyricStateCopyWithImpl<$Res>
    implements _$LyricStateCopyWith<$Res> {
  __$LyricStateCopyWithImpl(this._self, this._then);

  final _LyricState _self;
  final $Res Function(_LyricState) _then;

/// Create a copy of LyricState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentLyrics = freezed,Object? showSyncedLyrics = null,Object? currentPosition = null,Object? currentLyricIndex = null,Object? isEditMode = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_LyricState(
currentLyrics: freezed == currentLyrics ? _self.currentLyrics : currentLyrics // ignore: cast_nullable_to_non_nullable
as LyricData?,showSyncedLyrics: null == showSyncedLyrics ? _self.showSyncedLyrics : showSyncedLyrics // ignore: cast_nullable_to_non_nullable
as bool,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as Duration,currentLyricIndex: null == currentLyricIndex ? _self.currentLyricIndex : currentLyricIndex // ignore: cast_nullable_to_non_nullable
as int,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
