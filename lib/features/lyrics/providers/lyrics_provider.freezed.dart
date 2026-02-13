// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lyrics_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LyricsState implements DiagnosticableTreeMixin {

 LyricsInterface? get currentLyrics; bool get showSyncedLyrics; int get currentPosition; int get currentLyricIndex; bool get isEditMode; bool get isLoading; String? get error;
/// Create a copy of LyricsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LyricsStateCopyWith<LyricsState> get copyWith => _$LyricsStateCopyWithImpl<LyricsState>(this as LyricsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LyricsState'))
    ..add(DiagnosticsProperty('currentLyrics', currentLyrics))..add(DiagnosticsProperty('showSyncedLyrics', showSyncedLyrics))..add(DiagnosticsProperty('currentPosition', currentPosition))..add(DiagnosticsProperty('currentLyricIndex', currentLyricIndex))..add(DiagnosticsProperty('isEditMode', isEditMode))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LyricsState&&(identical(other.currentLyrics, currentLyrics) || other.currentLyrics == currentLyrics)&&(identical(other.showSyncedLyrics, showSyncedLyrics) || other.showSyncedLyrics == showSyncedLyrics)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.currentLyricIndex, currentLyricIndex) || other.currentLyricIndex == currentLyricIndex)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentLyrics,showSyncedLyrics,currentPosition,currentLyricIndex,isEditMode,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LyricsState(currentLyrics: $currentLyrics, showSyncedLyrics: $showSyncedLyrics, currentPosition: $currentPosition, currentLyricIndex: $currentLyricIndex, isEditMode: $isEditMode, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $LyricsStateCopyWith<$Res>  {
  factory $LyricsStateCopyWith(LyricsState value, $Res Function(LyricsState) _then) = _$LyricsStateCopyWithImpl;
@useResult
$Res call({
 LyricsInterface? currentLyrics, bool showSyncedLyrics, int currentPosition, int currentLyricIndex, bool isEditMode, bool isLoading, String? error
});




}
/// @nodoc
class _$LyricsStateCopyWithImpl<$Res>
    implements $LyricsStateCopyWith<$Res> {
  _$LyricsStateCopyWithImpl(this._self, this._then);

  final LyricsState _self;
  final $Res Function(LyricsState) _then;

/// Create a copy of LyricsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentLyrics = freezed,Object? showSyncedLyrics = null,Object? currentPosition = null,Object? currentLyricIndex = null,Object? isEditMode = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
currentLyrics: freezed == currentLyrics ? _self.currentLyrics : currentLyrics // ignore: cast_nullable_to_non_nullable
as LyricsInterface?,showSyncedLyrics: null == showSyncedLyrics ? _self.showSyncedLyrics : showSyncedLyrics // ignore: cast_nullable_to_non_nullable
as bool,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as int,currentLyricIndex: null == currentLyricIndex ? _self.currentLyricIndex : currentLyricIndex // ignore: cast_nullable_to_non_nullable
as int,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LyricsState].
extension LyricsStatePatterns on LyricsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LyricsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LyricsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LyricsState value)  $default,){
final _that = this;
switch (_that) {
case _LyricsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LyricsState value)?  $default,){
final _that = this;
switch (_that) {
case _LyricsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LyricsInterface? currentLyrics,  bool showSyncedLyrics,  int currentPosition,  int currentLyricIndex,  bool isEditMode,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LyricsState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LyricsInterface? currentLyrics,  bool showSyncedLyrics,  int currentPosition,  int currentLyricIndex,  bool isEditMode,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _LyricsState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LyricsInterface? currentLyrics,  bool showSyncedLyrics,  int currentPosition,  int currentLyricIndex,  bool isEditMode,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _LyricsState() when $default != null:
return $default(_that.currentLyrics,_that.showSyncedLyrics,_that.currentPosition,_that.currentLyricIndex,_that.isEditMode,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _LyricsState with DiagnosticableTreeMixin implements LyricsState {
  const _LyricsState({this.currentLyrics, this.showSyncedLyrics = true, this.currentPosition = 0, this.currentLyricIndex = -1, this.isEditMode = false, this.isLoading = false, this.error});
  

@override final  LyricsInterface? currentLyrics;
@override@JsonKey() final  bool showSyncedLyrics;
@override@JsonKey() final  int currentPosition;
@override@JsonKey() final  int currentLyricIndex;
@override@JsonKey() final  bool isEditMode;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of LyricsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LyricsStateCopyWith<_LyricsState> get copyWith => __$LyricsStateCopyWithImpl<_LyricsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LyricsState'))
    ..add(DiagnosticsProperty('currentLyrics', currentLyrics))..add(DiagnosticsProperty('showSyncedLyrics', showSyncedLyrics))..add(DiagnosticsProperty('currentPosition', currentPosition))..add(DiagnosticsProperty('currentLyricIndex', currentLyricIndex))..add(DiagnosticsProperty('isEditMode', isEditMode))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LyricsState&&(identical(other.currentLyrics, currentLyrics) || other.currentLyrics == currentLyrics)&&(identical(other.showSyncedLyrics, showSyncedLyrics) || other.showSyncedLyrics == showSyncedLyrics)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.currentLyricIndex, currentLyricIndex) || other.currentLyricIndex == currentLyricIndex)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentLyrics,showSyncedLyrics,currentPosition,currentLyricIndex,isEditMode,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LyricsState(currentLyrics: $currentLyrics, showSyncedLyrics: $showSyncedLyrics, currentPosition: $currentPosition, currentLyricIndex: $currentLyricIndex, isEditMode: $isEditMode, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$LyricsStateCopyWith<$Res> implements $LyricsStateCopyWith<$Res> {
  factory _$LyricsStateCopyWith(_LyricsState value, $Res Function(_LyricsState) _then) = __$LyricsStateCopyWithImpl;
@override @useResult
$Res call({
 LyricsInterface? currentLyrics, bool showSyncedLyrics, int currentPosition, int currentLyricIndex, bool isEditMode, bool isLoading, String? error
});




}
/// @nodoc
class __$LyricsStateCopyWithImpl<$Res>
    implements _$LyricsStateCopyWith<$Res> {
  __$LyricsStateCopyWithImpl(this._self, this._then);

  final _LyricsState _self;
  final $Res Function(_LyricsState) _then;

/// Create a copy of LyricsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentLyrics = freezed,Object? showSyncedLyrics = null,Object? currentPosition = null,Object? currentLyricIndex = null,Object? isEditMode = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_LyricsState(
currentLyrics: freezed == currentLyrics ? _self.currentLyrics : currentLyrics // ignore: cast_nullable_to_non_nullable
as LyricsInterface?,showSyncedLyrics: null == showSyncedLyrics ? _self.showSyncedLyrics : showSyncedLyrics // ignore: cast_nullable_to_non_nullable
as bool,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as int,currentLyricIndex: null == currentLyricIndex ? _self.currentLyricIndex : currentLyricIndex // ignore: cast_nullable_to_non_nullable
as int,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
