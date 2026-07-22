// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifikasi_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotifikasiState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotifikasiState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotifikasiState()';
}


}

/// @nodoc
class $NotifikasiStateCopyWith<$Res>  {
$NotifikasiStateCopyWith(NotifikasiState _, $Res Function(NotifikasiState) __);
}


/// Adds pattern-matching-related methods to [NotifikasiState].
extension NotifikasiStatePatterns on NotifikasiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _NotifikasiStateInitial value)?  initial,TResult Function( _NotifikasiStateLoading value)?  loading,TResult Function( _NotifikasiStateLoaded value)?  loaded,TResult Function( _NotifikasiStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotifikasiStateInitial() when initial != null:
return initial(_that);case _NotifikasiStateLoading() when loading != null:
return loading(_that);case _NotifikasiStateLoaded() when loaded != null:
return loaded(_that);case _NotifikasiStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _NotifikasiStateInitial value)  initial,required TResult Function( _NotifikasiStateLoading value)  loading,required TResult Function( _NotifikasiStateLoaded value)  loaded,required TResult Function( _NotifikasiStateError value)  error,}){
final _that = this;
switch (_that) {
case _NotifikasiStateInitial():
return initial(_that);case _NotifikasiStateLoading():
return loading(_that);case _NotifikasiStateLoaded():
return loaded(_that);case _NotifikasiStateError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _NotifikasiStateInitial value)?  initial,TResult? Function( _NotifikasiStateLoading value)?  loading,TResult? Function( _NotifikasiStateLoaded value)?  loaded,TResult? Function( _NotifikasiStateError value)?  error,}){
final _that = this;
switch (_that) {
case _NotifikasiStateInitial() when initial != null:
return initial(_that);case _NotifikasiStateLoading() when loading != null:
return loading(_that);case _NotifikasiStateLoaded() when loaded != null:
return loaded(_that);case _NotifikasiStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<NotifikasiModel> data)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotifikasiStateInitial() when initial != null:
return initial();case _NotifikasiStateLoading() when loading != null:
return loading();case _NotifikasiStateLoaded() when loaded != null:
return loaded(_that.data);case _NotifikasiStateError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<NotifikasiModel> data)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _NotifikasiStateInitial():
return initial();case _NotifikasiStateLoading():
return loading();case _NotifikasiStateLoaded():
return loaded(_that.data);case _NotifikasiStateError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<NotifikasiModel> data)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _NotifikasiStateInitial() when initial != null:
return initial();case _NotifikasiStateLoading() when loading != null:
return loading();case _NotifikasiStateLoaded() when loaded != null:
return loaded(_that.data);case _NotifikasiStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _NotifikasiStateInitial implements NotifikasiState {
  const _NotifikasiStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotifikasiStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotifikasiState.initial()';
}


}




/// @nodoc


class _NotifikasiStateLoading implements NotifikasiState {
  const _NotifikasiStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotifikasiStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotifikasiState.loading()';
}


}




/// @nodoc


class _NotifikasiStateLoaded implements NotifikasiState {
  const _NotifikasiStateLoaded({required final  List<NotifikasiModel> data}): _data = data;
  

 final  List<NotifikasiModel> _data;
 List<NotifikasiModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of NotifikasiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotifikasiStateLoadedCopyWith<_NotifikasiStateLoaded> get copyWith => __$NotifikasiStateLoadedCopyWithImpl<_NotifikasiStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotifikasiStateLoaded&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NotifikasiState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$NotifikasiStateLoadedCopyWith<$Res> implements $NotifikasiStateCopyWith<$Res> {
  factory _$NotifikasiStateLoadedCopyWith(_NotifikasiStateLoaded value, $Res Function(_NotifikasiStateLoaded) _then) = __$NotifikasiStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<NotifikasiModel> data
});




}
/// @nodoc
class __$NotifikasiStateLoadedCopyWithImpl<$Res>
    implements _$NotifikasiStateLoadedCopyWith<$Res> {
  __$NotifikasiStateLoadedCopyWithImpl(this._self, this._then);

  final _NotifikasiStateLoaded _self;
  final $Res Function(_NotifikasiStateLoaded) _then;

/// Create a copy of NotifikasiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_NotifikasiStateLoaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<NotifikasiModel>,
  ));
}


}

/// @nodoc


class _NotifikasiStateError implements NotifikasiState {
  const _NotifikasiStateError({required this.message});
  

 final  String message;

/// Create a copy of NotifikasiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotifikasiStateErrorCopyWith<_NotifikasiStateError> get copyWith => __$NotifikasiStateErrorCopyWithImpl<_NotifikasiStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotifikasiStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotifikasiState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$NotifikasiStateErrorCopyWith<$Res> implements $NotifikasiStateCopyWith<$Res> {
  factory _$NotifikasiStateErrorCopyWith(_NotifikasiStateError value, $Res Function(_NotifikasiStateError) _then) = __$NotifikasiStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$NotifikasiStateErrorCopyWithImpl<$Res>
    implements _$NotifikasiStateErrorCopyWith<$Res> {
  __$NotifikasiStateErrorCopyWithImpl(this._self, this._then);

  final _NotifikasiStateError _self;
  final $Res Function(_NotifikasiStateError) _then;

/// Create a copy of NotifikasiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_NotifikasiStateError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
