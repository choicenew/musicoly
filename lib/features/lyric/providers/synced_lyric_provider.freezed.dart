// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'synced_lyric_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncedLyricState {

 bool get autoScroll; bool get highlightCurrentLine; bool get showTranslation; double get fontSize; double get lineSpacing;
/// Create a copy of SyncedLyricState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncedLyricStateCopyWith<SyncedLyricState> get copyWith => _$SyncedLyricStateCopyWithImpl<SyncedLyricState>(this as SyncedLyricState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncedLyricState&&(identical(other.autoScroll, autoScroll) || other.autoScroll == autoScroll)&&(identical(other.highlightCurrentLine, highlightCurrentLine) || other.highlightCurrentLine == highlightCurrentLine)&&(identical(other.showTranslation, showTranslation) || other.showTranslation == showTranslation)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.lineSpacing, lineSpacing) || other.lineSpacing == lineSpacing));
}


@override
int get hashCode => Object.hash(runtimeType,autoScroll,highlightCurrentLine,showTranslation,fontSize,lineSpacing);

@override
String toString() {
  return 'SyncedLyricState(autoScroll: $autoScroll, highlightCurrentLine: $highlightCurrentLine, showTranslation: $showTranslation, fontSize: $fontSize, lineSpacing: $lineSpacing)';
}


}

/// @nodoc
abstract mixin class $SyncedLyricStateCopyWith<$Res>  {
  factory $SyncedLyricStateCopyWith(SyncedLyricState value, $Res Function(SyncedLyricState) _then) = _$SyncedLyricStateCopyWithImpl;
@useResult
$Res call({
 bool autoScroll, bool highlightCurrentLine, bool showTranslation, double fontSize, double lineSpacing
});




}
/// @nodoc
class _$SyncedLyricStateCopyWithImpl<$Res>
    implements $SyncedLyricStateCopyWith<$Res> {
  _$SyncedLyricStateCopyWithImpl(this._self, this._then);

  final SyncedLyricState _self;
  final $Res Function(SyncedLyricState) _then;

/// Create a copy of SyncedLyricState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoScroll = null,Object? highlightCurrentLine = null,Object? showTranslation = null,Object? fontSize = null,Object? lineSpacing = null,}) {
  return _then(_self.copyWith(
autoScroll: null == autoScroll ? _self.autoScroll : autoScroll // ignore: cast_nullable_to_non_nullable
as bool,highlightCurrentLine: null == highlightCurrentLine ? _self.highlightCurrentLine : highlightCurrentLine // ignore: cast_nullable_to_non_nullable
as bool,showTranslation: null == showTranslation ? _self.showTranslation : showTranslation // ignore: cast_nullable_to_non_nullable
as bool,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,lineSpacing: null == lineSpacing ? _self.lineSpacing : lineSpacing // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncedLyricState].
extension SyncedLyricStatePatterns on SyncedLyricState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncedLyricState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncedLyricState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncedLyricState value)  $default,){
final _that = this;
switch (_that) {
case _SyncedLyricState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncedLyricState value)?  $default,){
final _that = this;
switch (_that) {
case _SyncedLyricState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool autoScroll,  bool highlightCurrentLine,  bool showTranslation,  double fontSize,  double lineSpacing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncedLyricState() when $default != null:
return $default(_that.autoScroll,_that.highlightCurrentLine,_that.showTranslation,_that.fontSize,_that.lineSpacing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool autoScroll,  bool highlightCurrentLine,  bool showTranslation,  double fontSize,  double lineSpacing)  $default,) {final _that = this;
switch (_that) {
case _SyncedLyricState():
return $default(_that.autoScroll,_that.highlightCurrentLine,_that.showTranslation,_that.fontSize,_that.lineSpacing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool autoScroll,  bool highlightCurrentLine,  bool showTranslation,  double fontSize,  double lineSpacing)?  $default,) {final _that = this;
switch (_that) {
case _SyncedLyricState() when $default != null:
return $default(_that.autoScroll,_that.highlightCurrentLine,_that.showTranslation,_that.fontSize,_that.lineSpacing);case _:
  return null;

}
}

}

/// @nodoc


class _SyncedLyricState implements SyncedLyricState {
  const _SyncedLyricState({this.autoScroll = true, this.highlightCurrentLine = true, this.showTranslation = false, this.fontSize = 16.0, this.lineSpacing = 1.5});
  

@override@JsonKey() final  bool autoScroll;
@override@JsonKey() final  bool highlightCurrentLine;
@override@JsonKey() final  bool showTranslation;
@override@JsonKey() final  double fontSize;
@override@JsonKey() final  double lineSpacing;

/// Create a copy of SyncedLyricState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncedLyricStateCopyWith<_SyncedLyricState> get copyWith => __$SyncedLyricStateCopyWithImpl<_SyncedLyricState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncedLyricState&&(identical(other.autoScroll, autoScroll) || other.autoScroll == autoScroll)&&(identical(other.highlightCurrentLine, highlightCurrentLine) || other.highlightCurrentLine == highlightCurrentLine)&&(identical(other.showTranslation, showTranslation) || other.showTranslation == showTranslation)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.lineSpacing, lineSpacing) || other.lineSpacing == lineSpacing));
}


@override
int get hashCode => Object.hash(runtimeType,autoScroll,highlightCurrentLine,showTranslation,fontSize,lineSpacing);

@override
String toString() {
  return 'SyncedLyricState(autoScroll: $autoScroll, highlightCurrentLine: $highlightCurrentLine, showTranslation: $showTranslation, fontSize: $fontSize, lineSpacing: $lineSpacing)';
}


}

/// @nodoc
abstract mixin class _$SyncedLyricStateCopyWith<$Res> implements $SyncedLyricStateCopyWith<$Res> {
  factory _$SyncedLyricStateCopyWith(_SyncedLyricState value, $Res Function(_SyncedLyricState) _then) = __$SyncedLyricStateCopyWithImpl;
@override @useResult
$Res call({
 bool autoScroll, bool highlightCurrentLine, bool showTranslation, double fontSize, double lineSpacing
});




}
/// @nodoc
class __$SyncedLyricStateCopyWithImpl<$Res>
    implements _$SyncedLyricStateCopyWith<$Res> {
  __$SyncedLyricStateCopyWithImpl(this._self, this._then);

  final _SyncedLyricState _self;
  final $Res Function(_SyncedLyricState) _then;

/// Create a copy of SyncedLyricState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoScroll = null,Object? highlightCurrentLine = null,Object? showTranslation = null,Object? fontSize = null,Object? lineSpacing = null,}) {
  return _then(_SyncedLyricState(
autoScroll: null == autoScroll ? _self.autoScroll : autoScroll // ignore: cast_nullable_to_non_nullable
as bool,highlightCurrentLine: null == highlightCurrentLine ? _self.highlightCurrentLine : highlightCurrentLine // ignore: cast_nullable_to_non_nullable
as bool,showTranslation: null == showTranslation ? _self.showTranslation : showTranslation // ignore: cast_nullable_to_non_nullable
as bool,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,lineSpacing: null == lineSpacing ? _self.lineSpacing : lineSpacing // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
