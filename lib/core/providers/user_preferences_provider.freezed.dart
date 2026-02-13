// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserPreferencesState {

 ThemeMode get themeMode; bool get amoledDark; bool get albumColorSync; int get accentColorValue;// Store as int
 String? get timeZone; bool get use24HourFormat; String get audioQuality; bool get volumeNormalization; bool get skipSilence; int get crossfadeDuration; String? get localeCode;
/// Create a copy of UserPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesStateCopyWith<UserPreferencesState> get copyWith => _$UserPreferencesStateCopyWithImpl<UserPreferencesState>(this as UserPreferencesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferencesState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.amoledDark, amoledDark) || other.amoledDark == amoledDark)&&(identical(other.albumColorSync, albumColorSync) || other.albumColorSync == albumColorSync)&&(identical(other.accentColorValue, accentColorValue) || other.accentColorValue == accentColorValue)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.use24HourFormat, use24HourFormat) || other.use24HourFormat == use24HourFormat)&&(identical(other.audioQuality, audioQuality) || other.audioQuality == audioQuality)&&(identical(other.volumeNormalization, volumeNormalization) || other.volumeNormalization == volumeNormalization)&&(identical(other.skipSilence, skipSilence) || other.skipSilence == skipSilence)&&(identical(other.crossfadeDuration, crossfadeDuration) || other.crossfadeDuration == crossfadeDuration)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,amoledDark,albumColorSync,accentColorValue,timeZone,use24HourFormat,audioQuality,volumeNormalization,skipSilence,crossfadeDuration,localeCode);

@override
String toString() {
  return 'UserPreferencesState(themeMode: $themeMode, amoledDark: $amoledDark, albumColorSync: $albumColorSync, accentColorValue: $accentColorValue, timeZone: $timeZone, use24HourFormat: $use24HourFormat, audioQuality: $audioQuality, volumeNormalization: $volumeNormalization, skipSilence: $skipSilence, crossfadeDuration: $crossfadeDuration, localeCode: $localeCode)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesStateCopyWith<$Res>  {
  factory $UserPreferencesStateCopyWith(UserPreferencesState value, $Res Function(UserPreferencesState) _then) = _$UserPreferencesStateCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, bool amoledDark, bool albumColorSync, int accentColorValue, String? timeZone, bool use24HourFormat, String audioQuality, bool volumeNormalization, bool skipSilence, int crossfadeDuration, String? localeCode
});




}
/// @nodoc
class _$UserPreferencesStateCopyWithImpl<$Res>
    implements $UserPreferencesStateCopyWith<$Res> {
  _$UserPreferencesStateCopyWithImpl(this._self, this._then);

  final UserPreferencesState _self;
  final $Res Function(UserPreferencesState) _then;

/// Create a copy of UserPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? amoledDark = null,Object? albumColorSync = null,Object? accentColorValue = null,Object? timeZone = freezed,Object? use24HourFormat = null,Object? audioQuality = null,Object? volumeNormalization = null,Object? skipSilence = null,Object? crossfadeDuration = null,Object? localeCode = freezed,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,amoledDark: null == amoledDark ? _self.amoledDark : amoledDark // ignore: cast_nullable_to_non_nullable
as bool,albumColorSync: null == albumColorSync ? _self.albumColorSync : albumColorSync // ignore: cast_nullable_to_non_nullable
as bool,accentColorValue: null == accentColorValue ? _self.accentColorValue : accentColorValue // ignore: cast_nullable_to_non_nullable
as int,timeZone: freezed == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String?,use24HourFormat: null == use24HourFormat ? _self.use24HourFormat : use24HourFormat // ignore: cast_nullable_to_non_nullable
as bool,audioQuality: null == audioQuality ? _self.audioQuality : audioQuality // ignore: cast_nullable_to_non_nullable
as String,volumeNormalization: null == volumeNormalization ? _self.volumeNormalization : volumeNormalization // ignore: cast_nullable_to_non_nullable
as bool,skipSilence: null == skipSilence ? _self.skipSilence : skipSilence // ignore: cast_nullable_to_non_nullable
as bool,crossfadeDuration: null == crossfadeDuration ? _self.crossfadeDuration : crossfadeDuration // ignore: cast_nullable_to_non_nullable
as int,localeCode: freezed == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferencesState].
extension UserPreferencesStatePatterns on UserPreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferencesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferencesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferencesState value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferencesState value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  bool amoledDark,  bool albumColorSync,  int accentColorValue,  String? timeZone,  bool use24HourFormat,  String audioQuality,  bool volumeNormalization,  bool skipSilence,  int crossfadeDuration,  String? localeCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferencesState() when $default != null:
return $default(_that.themeMode,_that.amoledDark,_that.albumColorSync,_that.accentColorValue,_that.timeZone,_that.use24HourFormat,_that.audioQuality,_that.volumeNormalization,_that.skipSilence,_that.crossfadeDuration,_that.localeCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  bool amoledDark,  bool albumColorSync,  int accentColorValue,  String? timeZone,  bool use24HourFormat,  String audioQuality,  bool volumeNormalization,  bool skipSilence,  int crossfadeDuration,  String? localeCode)  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesState():
return $default(_that.themeMode,_that.amoledDark,_that.albumColorSync,_that.accentColorValue,_that.timeZone,_that.use24HourFormat,_that.audioQuality,_that.volumeNormalization,_that.skipSilence,_that.crossfadeDuration,_that.localeCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  bool amoledDark,  bool albumColorSync,  int accentColorValue,  String? timeZone,  bool use24HourFormat,  String audioQuality,  bool volumeNormalization,  bool skipSilence,  int crossfadeDuration,  String? localeCode)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesState() when $default != null:
return $default(_that.themeMode,_that.amoledDark,_that.albumColorSync,_that.accentColorValue,_that.timeZone,_that.use24HourFormat,_that.audioQuality,_that.volumeNormalization,_that.skipSilence,_that.crossfadeDuration,_that.localeCode);case _:
  return null;

}
}

}

/// @nodoc


class _UserPreferencesState extends UserPreferencesState {
  const _UserPreferencesState({this.themeMode = ThemeMode.system, this.amoledDark = false, this.albumColorSync = true, this.accentColorValue = 0xFF2196F3, this.timeZone, this.use24HourFormat = false, this.audioQuality = 'high', this.volumeNormalization = true, this.skipSilence = false, this.crossfadeDuration = 0, this.localeCode}): super._();
  

@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  bool amoledDark;
@override@JsonKey() final  bool albumColorSync;
@override@JsonKey() final  int accentColorValue;
// Store as int
@override final  String? timeZone;
@override@JsonKey() final  bool use24HourFormat;
@override@JsonKey() final  String audioQuality;
@override@JsonKey() final  bool volumeNormalization;
@override@JsonKey() final  bool skipSilence;
@override@JsonKey() final  int crossfadeDuration;
@override final  String? localeCode;

/// Create a copy of UserPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesStateCopyWith<_UserPreferencesState> get copyWith => __$UserPreferencesStateCopyWithImpl<_UserPreferencesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferencesState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.amoledDark, amoledDark) || other.amoledDark == amoledDark)&&(identical(other.albumColorSync, albumColorSync) || other.albumColorSync == albumColorSync)&&(identical(other.accentColorValue, accentColorValue) || other.accentColorValue == accentColorValue)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.use24HourFormat, use24HourFormat) || other.use24HourFormat == use24HourFormat)&&(identical(other.audioQuality, audioQuality) || other.audioQuality == audioQuality)&&(identical(other.volumeNormalization, volumeNormalization) || other.volumeNormalization == volumeNormalization)&&(identical(other.skipSilence, skipSilence) || other.skipSilence == skipSilence)&&(identical(other.crossfadeDuration, crossfadeDuration) || other.crossfadeDuration == crossfadeDuration)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,amoledDark,albumColorSync,accentColorValue,timeZone,use24HourFormat,audioQuality,volumeNormalization,skipSilence,crossfadeDuration,localeCode);

@override
String toString() {
  return 'UserPreferencesState(themeMode: $themeMode, amoledDark: $amoledDark, albumColorSync: $albumColorSync, accentColorValue: $accentColorValue, timeZone: $timeZone, use24HourFormat: $use24HourFormat, audioQuality: $audioQuality, volumeNormalization: $volumeNormalization, skipSilence: $skipSilence, crossfadeDuration: $crossfadeDuration, localeCode: $localeCode)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesStateCopyWith<$Res> implements $UserPreferencesStateCopyWith<$Res> {
  factory _$UserPreferencesStateCopyWith(_UserPreferencesState value, $Res Function(_UserPreferencesState) _then) = __$UserPreferencesStateCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, bool amoledDark, bool albumColorSync, int accentColorValue, String? timeZone, bool use24HourFormat, String audioQuality, bool volumeNormalization, bool skipSilence, int crossfadeDuration, String? localeCode
});




}
/// @nodoc
class __$UserPreferencesStateCopyWithImpl<$Res>
    implements _$UserPreferencesStateCopyWith<$Res> {
  __$UserPreferencesStateCopyWithImpl(this._self, this._then);

  final _UserPreferencesState _self;
  final $Res Function(_UserPreferencesState) _then;

/// Create a copy of UserPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? amoledDark = null,Object? albumColorSync = null,Object? accentColorValue = null,Object? timeZone = freezed,Object? use24HourFormat = null,Object? audioQuality = null,Object? volumeNormalization = null,Object? skipSilence = null,Object? crossfadeDuration = null,Object? localeCode = freezed,}) {
  return _then(_UserPreferencesState(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,amoledDark: null == amoledDark ? _self.amoledDark : amoledDark // ignore: cast_nullable_to_non_nullable
as bool,albumColorSync: null == albumColorSync ? _self.albumColorSync : albumColorSync // ignore: cast_nullable_to_non_nullable
as bool,accentColorValue: null == accentColorValue ? _self.accentColorValue : accentColorValue // ignore: cast_nullable_to_non_nullable
as int,timeZone: freezed == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String?,use24HourFormat: null == use24HourFormat ? _self.use24HourFormat : use24HourFormat // ignore: cast_nullable_to_non_nullable
as bool,audioQuality: null == audioQuality ? _self.audioQuality : audioQuality // ignore: cast_nullable_to_non_nullable
as String,volumeNormalization: null == volumeNormalization ? _self.volumeNormalization : volumeNormalization // ignore: cast_nullable_to_non_nullable
as bool,skipSilence: null == skipSilence ? _self.skipSilence : skipSilence // ignore: cast_nullable_to_non_nullable
as bool,crossfadeDuration: null == crossfadeDuration ? _self.crossfadeDuration : crossfadeDuration // ignore: cast_nullable_to_non_nullable
as int,localeCode: freezed == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
