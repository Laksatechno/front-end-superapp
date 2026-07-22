// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SummaryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent()';
}


}

/// @nodoc
class $SummaryEventCopyWith<$Res>  {
$SummaryEventCopyWith(SummaryEvent _, $Res Function(SummaryEvent) __);
}


/// Adds pattern-matching-related methods to [SummaryEvent].
extension SummaryEventPatterns on SummaryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SummaryLoadEvent value)?  load,TResult Function( SummaryRefreshEvent value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SummaryLoadEvent() when load != null:
return load(_that);case SummaryRefreshEvent() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SummaryLoadEvent value)  load,required TResult Function( SummaryRefreshEvent value)  refresh,}){
final _that = this;
switch (_that) {
case SummaryLoadEvent():
return load(_that);case SummaryRefreshEvent():
return refresh(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SummaryLoadEvent value)?  load,TResult? Function( SummaryRefreshEvent value)?  refresh,}){
final _that = this;
switch (_that) {
case SummaryLoadEvent() when load != null:
return load(_that);case SummaryRefreshEvent() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SummaryLoadEvent() when load != null:
return load();case SummaryRefreshEvent() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case SummaryLoadEvent():
return load();case SummaryRefreshEvent():
return refresh();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case SummaryLoadEvent() when load != null:
return load();case SummaryRefreshEvent() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class SummaryLoadEvent implements SummaryEvent {
  const SummaryLoadEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryLoadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.load()';
}


}




/// @nodoc


class SummaryRefreshEvent implements SummaryEvent {
  const SummaryRefreshEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryRefreshEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.refresh()';
}


}




/// @nodoc
mixin _$SummaryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryState()';
}


}

/// @nodoc
class $SummaryStateCopyWith<$Res>  {
$SummaryStateCopyWith(SummaryState _, $Res Function(SummaryState) __);
}


/// Adds pattern-matching-related methods to [SummaryState].
extension SummaryStatePatterns on SummaryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SummaryInitial value)?  initial,TResult Function( SummaryLoading value)?  loading,TResult Function( SummaryLoaded value)?  loaded,TResult Function( SummaryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SummaryInitial() when initial != null:
return initial(_that);case SummaryLoading() when loading != null:
return loading(_that);case SummaryLoaded() when loaded != null:
return loaded(_that);case SummaryError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SummaryInitial value)  initial,required TResult Function( SummaryLoading value)  loading,required TResult Function( SummaryLoaded value)  loaded,required TResult Function( SummaryError value)  error,}){
final _that = this;
switch (_that) {
case SummaryInitial():
return initial(_that);case SummaryLoading():
return loading(_that);case SummaryLoaded():
return loaded(_that);case SummaryError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SummaryInitial value)?  initial,TResult? Function( SummaryLoading value)?  loading,TResult? Function( SummaryLoaded value)?  loaded,TResult? Function( SummaryError value)?  error,}){
final _that = this;
switch (_that) {
case SummaryInitial() when initial != null:
return initial(_that);case SummaryLoading() when loading != null:
return loading(_that);case SummaryLoaded() when loaded != null:
return loaded(_that);case SummaryError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SummaryModel summary)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SummaryInitial() when initial != null:
return initial();case SummaryLoading() when loading != null:
return loading();case SummaryLoaded() when loaded != null:
return loaded(_that.summary);case SummaryError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SummaryModel summary)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SummaryInitial():
return initial();case SummaryLoading():
return loading();case SummaryLoaded():
return loaded(_that.summary);case SummaryError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SummaryModel summary)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SummaryInitial() when initial != null:
return initial();case SummaryLoading() when loading != null:
return loading();case SummaryLoaded() when loaded != null:
return loaded(_that.summary);case SummaryError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SummaryInitial implements SummaryState {
  const SummaryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryState.initial()';
}


}




/// @nodoc


class SummaryLoading implements SummaryState {
  const SummaryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryState.loading()';
}


}




/// @nodoc


class SummaryLoaded implements SummaryState {
  const SummaryLoaded(this.summary);
  

 final  SummaryModel summary;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryLoadedCopyWith<SummaryLoaded> get copyWith => _$SummaryLoadedCopyWithImpl<SummaryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryLoaded&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'SummaryState.loaded(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $SummaryLoadedCopyWith<$Res> implements $SummaryStateCopyWith<$Res> {
  factory $SummaryLoadedCopyWith(SummaryLoaded value, $Res Function(SummaryLoaded) _then) = _$SummaryLoadedCopyWithImpl;
@useResult
$Res call({
 SummaryModel summary
});




}
/// @nodoc
class _$SummaryLoadedCopyWithImpl<$Res>
    implements $SummaryLoadedCopyWith<$Res> {
  _$SummaryLoadedCopyWithImpl(this._self, this._then);

  final SummaryLoaded _self;
  final $Res Function(SummaryLoaded) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,}) {
  return _then(SummaryLoaded(
null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SummaryModel,
  ));
}


}

/// @nodoc


class SummaryError implements SummaryState {
  const SummaryError(this.message);
  

 final  String message;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryErrorCopyWith<SummaryError> get copyWith => _$SummaryErrorCopyWithImpl<SummaryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SummaryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SummaryErrorCopyWith<$Res> implements $SummaryStateCopyWith<$Res> {
  factory $SummaryErrorCopyWith(SummaryError value, $Res Function(SummaryError) _then) = _$SummaryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SummaryErrorCopyWithImpl<$Res>
    implements $SummaryErrorCopyWith<$Res> {
  _$SummaryErrorCopyWithImpl(this._self, this._then);

  final SummaryError _self;
  final $Res Function(SummaryError) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SummaryError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
