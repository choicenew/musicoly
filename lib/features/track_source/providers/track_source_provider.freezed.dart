// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_source_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackSourceState {

 String get activePluginId; List<String> get availablePlugins; SourceQualities get quality; SourceCodecs get codec;
/// Create a copy of TrackSourceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackSourceStateCopyWith<TrackSourceState> get copyWith => _$TrackSourceStateCopyWithImpl<TrackSourceState>(this as TrackSourceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackSourceState&&(identical(other.activePluginId, activePluginId) || other.activePluginId == activePluginId)&&const DeepCollectionEquality().equals(other.availablePlugins, availablePlugins)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.codec, codec) || other.codec == codec));
}


@override
int get hashCode => Object.hash(runtimeType,activePluginId,const DeepCollectionEquality().hash(availablePlugins),quality,codec);

@override
String toString() {
  return 'TrackSourceState(activePluginId: $activePluginId, availablePlugins: $availablePlugins, quality: $quality, codec: $codec)';
}


}

/// @nodoc
abstract mixin class $TrackSourceStateCopyWith<$Res>  {
  factory $TrackSourceStateCopyWith(TrackSourceState value, $Res Function(TrackSourceState) _then) = _$TrackSourceStateCopyWithImpl;
@useResult
$Res call({
 String activePluginId, List<String> availablePlugins, SourceQualities quality, SourceCodecs codec
});




}
/// @nodoc
class _$TrackSourceStateCopyWithImpl<$Res>
    implements $TrackSourceStateCopyWith<$Res> {
  _$TrackSourceStateCopyWithImpl(this._self, this._then);

  final TrackSourceState _self;
  final $Res Function(TrackSourceState) _then;

/// Create a copy of TrackSourceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activePluginId = null,Object? availablePlugins = null,Object? quality = null,Object? codec = null,}) {
  return _then(_self.copyWith(
activePluginId: null == activePluginId ? _self.activePluginId : activePluginId // ignore: cast_nullable_to_non_nullable
as String,availablePlugins: null == availablePlugins ? _self.availablePlugins : availablePlugins // ignore: cast_nullable_to_non_nullable
as List<String>,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as SourceQualities,codec: null == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as SourceCodecs,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackSourceState].
extension TrackSourceStatePatterns on TrackSourceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackSourceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackSourceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackSourceState value)  $default,){
final _that = this;
switch (_that) {
case _TrackSourceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackSourceState value)?  $default,){
final _that = this;
switch (_that) {
case _TrackSourceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activePluginId,  List<String> availablePlugins,  SourceQualities quality,  SourceCodecs codec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackSourceState() when $default != null:
return $default(_that.activePluginId,_that.availablePlugins,_that.quality,_that.codec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activePluginId,  List<String> availablePlugins,  SourceQualities quality,  SourceCodecs codec)  $default,) {final _that = this;
switch (_that) {
case _TrackSourceState():
return $default(_that.activePluginId,_that.availablePlugins,_that.quality,_that.codec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activePluginId,  List<String> availablePlugins,  SourceQualities quality,  SourceCodecs codec)?  $default,) {final _that = this;
switch (_that) {
case _TrackSourceState() when $default != null:
return $default(_that.activePluginId,_that.availablePlugins,_that.quality,_that.codec);case _:
  return null;

}
}

}

/// @nodoc


class _TrackSourceState implements TrackSourceState {
  const _TrackSourceState({this.activePluginId = '', final  List<String> availablePlugins = const [], this.quality = SourceQualities.high, this.codec = SourceCodecs.m4a}): _availablePlugins = availablePlugins;
  

@override@JsonKey() final  String activePluginId;
 final  List<String> _availablePlugins;
@override@JsonKey() List<String> get availablePlugins {
  if (_availablePlugins is EqualUnmodifiableListView) return _availablePlugins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePlugins);
}

@override@JsonKey() final  SourceQualities quality;
@override@JsonKey() final  SourceCodecs codec;

/// Create a copy of TrackSourceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackSourceStateCopyWith<_TrackSourceState> get copyWith => __$TrackSourceStateCopyWithImpl<_TrackSourceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackSourceState&&(identical(other.activePluginId, activePluginId) || other.activePluginId == activePluginId)&&const DeepCollectionEquality().equals(other._availablePlugins, _availablePlugins)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.codec, codec) || other.codec == codec));
}


@override
int get hashCode => Object.hash(runtimeType,activePluginId,const DeepCollectionEquality().hash(_availablePlugins),quality,codec);

@override
String toString() {
  return 'TrackSourceState(activePluginId: $activePluginId, availablePlugins: $availablePlugins, quality: $quality, codec: $codec)';
}


}

/// @nodoc
abstract mixin class _$TrackSourceStateCopyWith<$Res> implements $TrackSourceStateCopyWith<$Res> {
  factory _$TrackSourceStateCopyWith(_TrackSourceState value, $Res Function(_TrackSourceState) _then) = __$TrackSourceStateCopyWithImpl;
@override @useResult
$Res call({
 String activePluginId, List<String> availablePlugins, SourceQualities quality, SourceCodecs codec
});




}
/// @nodoc
class __$TrackSourceStateCopyWithImpl<$Res>
    implements _$TrackSourceStateCopyWith<$Res> {
  __$TrackSourceStateCopyWithImpl(this._self, this._then);

  final _TrackSourceState _self;
  final $Res Function(_TrackSourceState) _then;

/// Create a copy of TrackSourceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activePluginId = null,Object? availablePlugins = null,Object? quality = null,Object? codec = null,}) {
  return _then(_TrackSourceState(
activePluginId: null == activePluginId ? _self.activePluginId : activePluginId // ignore: cast_nullable_to_non_nullable
as String,availablePlugins: null == availablePlugins ? _self._availablePlugins : availablePlugins // ignore: cast_nullable_to_non_nullable
as List<String>,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as SourceQualities,codec: null == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as SourceCodecs,
  ));
}


}

// dart format on
