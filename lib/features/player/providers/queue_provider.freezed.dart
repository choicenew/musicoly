// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueState {

 List<String> get queue; int get currentIndex; List<String> get history; bool get isLoading; bool get hasError; String? get errorMessage;
/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueStateCopyWith<QueueState> get copyWith => _$QueueStateCopyWithImpl<QueueState>(this as QueueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueState&&const DeepCollectionEquality().equals(other.queue, queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(queue),currentIndex,const DeepCollectionEquality().hash(history),isLoading,hasError,errorMessage);

@override
String toString() {
  return 'QueueState(queue: $queue, currentIndex: $currentIndex, history: $history, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $QueueStateCopyWith<$Res>  {
  factory $QueueStateCopyWith(QueueState value, $Res Function(QueueState) _then) = _$QueueStateCopyWithImpl;
@useResult
$Res call({
 List<String> queue, int currentIndex, List<String> history, bool isLoading, bool hasError, String? errorMessage
});




}
/// @nodoc
class _$QueueStateCopyWithImpl<$Res>
    implements $QueueStateCopyWith<$Res> {
  _$QueueStateCopyWithImpl(this._self, this._then);

  final QueueState _self;
  final $Res Function(QueueState) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? queue = null,Object? currentIndex = null,Object? history = null,Object? isLoading = null,Object? hasError = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<String>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QueueState].
extension QueueStatePatterns on QueueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueState value)  $default,){
final _that = this;
switch (_that) {
case _QueueState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueState value)?  $default,){
final _that = this;
switch (_that) {
case _QueueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> queue,  int currentIndex,  List<String> history,  bool isLoading,  bool hasError,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueState() when $default != null:
return $default(_that.queue,_that.currentIndex,_that.history,_that.isLoading,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> queue,  int currentIndex,  List<String> history,  bool isLoading,  bool hasError,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _QueueState():
return $default(_that.queue,_that.currentIndex,_that.history,_that.isLoading,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> queue,  int currentIndex,  List<String> history,  bool isLoading,  bool hasError,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _QueueState() when $default != null:
return $default(_that.queue,_that.currentIndex,_that.history,_that.isLoading,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _QueueState extends QueueState {
  const _QueueState({final  List<String> queue = const [], this.currentIndex = -1, final  List<String> history = const [], this.isLoading = false, this.hasError = false, this.errorMessage}): _queue = queue,_history = history,super._();
  

 final  List<String> _queue;
@override@JsonKey() List<String> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

@override@JsonKey() final  int currentIndex;
 final  List<String> _history;
@override@JsonKey() List<String> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasError;
@override final  String? errorMessage;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueStateCopyWith<_QueueState> get copyWith => __$QueueStateCopyWithImpl<_QueueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueState&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_queue),currentIndex,const DeepCollectionEquality().hash(_history),isLoading,hasError,errorMessage);

@override
String toString() {
  return 'QueueState(queue: $queue, currentIndex: $currentIndex, history: $history, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$QueueStateCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory _$QueueStateCopyWith(_QueueState value, $Res Function(_QueueState) _then) = __$QueueStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> queue, int currentIndex, List<String> history, bool isLoading, bool hasError, String? errorMessage
});




}
/// @nodoc
class __$QueueStateCopyWithImpl<$Res>
    implements _$QueueStateCopyWith<$Res> {
  __$QueueStateCopyWithImpl(this._self, this._then);

  final _QueueState _self;
  final $Res Function(_QueueState) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? queue = null,Object? currentIndex = null,Object? history = null,Object? isLoading = null,Object? hasError = null,Object? errorMessage = freezed,}) {
  return _then(_QueueState(
queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<String>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
