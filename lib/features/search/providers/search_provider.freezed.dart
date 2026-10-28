// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchStateData {

 String get query; bool get isSearching; List<SourceInfo> get results; Object? get error;
/// Create a copy of SearchStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateDataCopyWith<SearchStateData> get copyWith => _$SearchStateDataCopyWithImpl<SearchStateData>(this as SearchStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchStateData&&(identical(other.query, query) || other.query == query)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,query,isSearching,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'SearchStateData(query: $query, isSearching: $isSearching, results: $results, error: $error)';
}


}

/// @nodoc
abstract mixin class $SearchStateDataCopyWith<$Res>  {
  factory $SearchStateDataCopyWith(SearchStateData value, $Res Function(SearchStateData) _then) = _$SearchStateDataCopyWithImpl;
@useResult
$Res call({
 String query, bool isSearching, List<SourceInfo> results, Object? error
});




}
/// @nodoc
class _$SearchStateDataCopyWithImpl<$Res>
    implements $SearchStateDataCopyWith<$Res> {
  _$SearchStateDataCopyWithImpl(this._self, this._then);

  final SearchStateData _self;
  final $Res Function(SearchStateData) _then;

/// Create a copy of SearchStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? isSearching = null,Object? results = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<SourceInfo>,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchStateData].
extension SearchStateDataPatterns on SearchStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchStateData value)  $default,){
final _that = this;
switch (_that) {
case _SearchStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchStateData value)?  $default,){
final _that = this;
switch (_that) {
case _SearchStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  bool isSearching,  List<SourceInfo> results,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchStateData() when $default != null:
return $default(_that.query,_that.isSearching,_that.results,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  bool isSearching,  List<SourceInfo> results,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _SearchStateData():
return $default(_that.query,_that.isSearching,_that.results,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  bool isSearching,  List<SourceInfo> results,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _SearchStateData() when $default != null:
return $default(_that.query,_that.isSearching,_that.results,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SearchStateData implements SearchStateData {
  const _SearchStateData({this.query = '', this.isSearching = false, final  List<SourceInfo> results = const [], this.error}): _results = results;
  

@override@JsonKey() final  String query;
@override@JsonKey() final  bool isSearching;
 final  List<SourceInfo> _results;
@override@JsonKey() List<SourceInfo> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  Object? error;

/// Create a copy of SearchStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateDataCopyWith<_SearchStateData> get copyWith => __$SearchStateDataCopyWithImpl<_SearchStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchStateData&&(identical(other.query, query) || other.query == query)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,query,isSearching,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'SearchStateData(query: $query, isSearching: $isSearching, results: $results, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SearchStateDataCopyWith<$Res> implements $SearchStateDataCopyWith<$Res> {
  factory _$SearchStateDataCopyWith(_SearchStateData value, $Res Function(_SearchStateData) _then) = __$SearchStateDataCopyWithImpl;
@override @useResult
$Res call({
 String query, bool isSearching, List<SourceInfo> results, Object? error
});




}
/// @nodoc
class __$SearchStateDataCopyWithImpl<$Res>
    implements _$SearchStateDataCopyWith<$Res> {
  __$SearchStateDataCopyWithImpl(this._self, this._then);

  final _SearchStateData _self;
  final $Res Function(_SearchStateData) _then;

/// Create a copy of SearchStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? isSearching = null,Object? results = null,Object? error = freezed,}) {
  return _then(_SearchStateData(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<SourceInfo>,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
