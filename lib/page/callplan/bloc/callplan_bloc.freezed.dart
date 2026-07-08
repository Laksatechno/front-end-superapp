// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'callplan_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallplanEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallplanEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallplanEvent()';
}


}

/// @nodoc
class $CallplanEventCopyWith<$Res>  {
$CallplanEventCopyWith(CallplanEvent _, $Res Function(CallplanEvent) __);
}


/// Adds pattern-matching-related methods to [CallplanEvent].
extension CallplanEventPatterns on CallplanEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchCallplan value)?  fetch,TResult Function( _CreateCallplan value)?  create,TResult Function( _UpdateCallplan value)?  update,TResult Function( _DeleteCallplan value)?  delete,TResult Function( _RefreshCallplan value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchCallplan() when fetch != null:
return fetch(_that);case _CreateCallplan() when create != null:
return create(_that);case _UpdateCallplan() when update != null:
return update(_that);case _DeleteCallplan() when delete != null:
return delete(_that);case _RefreshCallplan() when refresh != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchCallplan value)  fetch,required TResult Function( _CreateCallplan value)  create,required TResult Function( _UpdateCallplan value)  update,required TResult Function( _DeleteCallplan value)  delete,required TResult Function( _RefreshCallplan value)  refresh,}){
final _that = this;
switch (_that) {
case _FetchCallplan():
return fetch(_that);case _CreateCallplan():
return create(_that);case _UpdateCallplan():
return update(_that);case _DeleteCallplan():
return delete(_that);case _RefreshCallplan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchCallplan value)?  fetch,TResult? Function( _CreateCallplan value)?  create,TResult? Function( _UpdateCallplan value)?  update,TResult? Function( _DeleteCallplan value)?  delete,TResult? Function( _RefreshCallplan value)?  refresh,}){
final _that = this;
switch (_that) {
case _FetchCallplan() when fetch != null:
return fetch(_that);case _CreateCallplan() when create != null:
return create(_that);case _UpdateCallplan() when update != null:
return update(_that);case _DeleteCallplan() when delete != null:
return delete(_that);case _RefreshCallplan() when refresh != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? filterType,  DateTimeRange? dateRange)?  fetch,TResult Function( DateTime tanggalCp,  String outlet,  String description)?  create,TResult Function( int id,  DateTime tanggalCp,  String outlet,  String description)?  update,TResult Function( int id)?  delete,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchCallplan() when fetch != null:
return fetch(_that.filterType,_that.dateRange);case _CreateCallplan() when create != null:
return create(_that.tanggalCp,_that.outlet,_that.description);case _UpdateCallplan() when update != null:
return update(_that.id,_that.tanggalCp,_that.outlet,_that.description);case _DeleteCallplan() when delete != null:
return delete(_that.id);case _RefreshCallplan() when refresh != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? filterType,  DateTimeRange? dateRange)  fetch,required TResult Function( DateTime tanggalCp,  String outlet,  String description)  create,required TResult Function( int id,  DateTime tanggalCp,  String outlet,  String description)  update,required TResult Function( int id)  delete,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case _FetchCallplan():
return fetch(_that.filterType,_that.dateRange);case _CreateCallplan():
return create(_that.tanggalCp,_that.outlet,_that.description);case _UpdateCallplan():
return update(_that.id,_that.tanggalCp,_that.outlet,_that.description);case _DeleteCallplan():
return delete(_that.id);case _RefreshCallplan():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? filterType,  DateTimeRange? dateRange)?  fetch,TResult? Function( DateTime tanggalCp,  String outlet,  String description)?  create,TResult? Function( int id,  DateTime tanggalCp,  String outlet,  String description)?  update,TResult? Function( int id)?  delete,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case _FetchCallplan() when fetch != null:
return fetch(_that.filterType,_that.dateRange);case _CreateCallplan() when create != null:
return create(_that.tanggalCp,_that.outlet,_that.description);case _UpdateCallplan() when update != null:
return update(_that.id,_that.tanggalCp,_that.outlet,_that.description);case _DeleteCallplan() when delete != null:
return delete(_that.id);case _RefreshCallplan() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class _FetchCallplan implements CallplanEvent {
  const _FetchCallplan({this.filterType, this.dateRange});
  

 final  String? filterType;
 final  DateTimeRange? dateRange;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchCallplanCopyWith<_FetchCallplan> get copyWith => __$FetchCallplanCopyWithImpl<_FetchCallplan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchCallplan&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange));
}


@override
int get hashCode => Object.hash(runtimeType,filterType,dateRange);

@override
String toString() {
  return 'CallplanEvent.fetch(filterType: $filterType, dateRange: $dateRange)';
}


}

/// @nodoc
abstract mixin class _$FetchCallplanCopyWith<$Res> implements $CallplanEventCopyWith<$Res> {
  factory _$FetchCallplanCopyWith(_FetchCallplan value, $Res Function(_FetchCallplan) _then) = __$FetchCallplanCopyWithImpl;
@useResult
$Res call({
 String? filterType, DateTimeRange? dateRange
});




}
/// @nodoc
class __$FetchCallplanCopyWithImpl<$Res>
    implements _$FetchCallplanCopyWith<$Res> {
  __$FetchCallplanCopyWithImpl(this._self, this._then);

  final _FetchCallplan _self;
  final $Res Function(_FetchCallplan) _then;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filterType = freezed,Object? dateRange = freezed,}) {
  return _then(_FetchCallplan(
filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,dateRange: freezed == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateTimeRange?,
  ));
}


}

/// @nodoc


class _CreateCallplan implements CallplanEvent {
  const _CreateCallplan({required this.tanggalCp, required this.outlet, required this.description});
  

 final  DateTime tanggalCp;
 final  String outlet;
 final  String description;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCallplanCopyWith<_CreateCallplan> get copyWith => __$CreateCallplanCopyWithImpl<_CreateCallplan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateCallplan&&(identical(other.tanggalCp, tanggalCp) || other.tanggalCp == tanggalCp)&&(identical(other.outlet, outlet) || other.outlet == outlet)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,tanggalCp,outlet,description);

@override
String toString() {
  return 'CallplanEvent.create(tanggalCp: $tanggalCp, outlet: $outlet, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CreateCallplanCopyWith<$Res> implements $CallplanEventCopyWith<$Res> {
  factory _$CreateCallplanCopyWith(_CreateCallplan value, $Res Function(_CreateCallplan) _then) = __$CreateCallplanCopyWithImpl;
@useResult
$Res call({
 DateTime tanggalCp, String outlet, String description
});




}
/// @nodoc
class __$CreateCallplanCopyWithImpl<$Res>
    implements _$CreateCallplanCopyWith<$Res> {
  __$CreateCallplanCopyWithImpl(this._self, this._then);

  final _CreateCallplan _self;
  final $Res Function(_CreateCallplan) _then;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tanggalCp = null,Object? outlet = null,Object? description = null,}) {
  return _then(_CreateCallplan(
tanggalCp: null == tanggalCp ? _self.tanggalCp : tanggalCp // ignore: cast_nullable_to_non_nullable
as DateTime,outlet: null == outlet ? _self.outlet : outlet // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateCallplan implements CallplanEvent {
  const _UpdateCallplan({required this.id, required this.tanggalCp, required this.outlet, required this.description});
  

 final  int id;
 final  DateTime tanggalCp;
 final  String outlet;
 final  String description;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCallplanCopyWith<_UpdateCallplan> get copyWith => __$UpdateCallplanCopyWithImpl<_UpdateCallplan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCallplan&&(identical(other.id, id) || other.id == id)&&(identical(other.tanggalCp, tanggalCp) || other.tanggalCp == tanggalCp)&&(identical(other.outlet, outlet) || other.outlet == outlet)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,tanggalCp,outlet,description);

@override
String toString() {
  return 'CallplanEvent.update(id: $id, tanggalCp: $tanggalCp, outlet: $outlet, description: $description)';
}


}

/// @nodoc
abstract mixin class _$UpdateCallplanCopyWith<$Res> implements $CallplanEventCopyWith<$Res> {
  factory _$UpdateCallplanCopyWith(_UpdateCallplan value, $Res Function(_UpdateCallplan) _then) = __$UpdateCallplanCopyWithImpl;
@useResult
$Res call({
 int id, DateTime tanggalCp, String outlet, String description
});




}
/// @nodoc
class __$UpdateCallplanCopyWithImpl<$Res>
    implements _$UpdateCallplanCopyWith<$Res> {
  __$UpdateCallplanCopyWithImpl(this._self, this._then);

  final _UpdateCallplan _self;
  final $Res Function(_UpdateCallplan) _then;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tanggalCp = null,Object? outlet = null,Object? description = null,}) {
  return _then(_UpdateCallplan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tanggalCp: null == tanggalCp ? _self.tanggalCp : tanggalCp // ignore: cast_nullable_to_non_nullable
as DateTime,outlet: null == outlet ? _self.outlet : outlet // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeleteCallplan implements CallplanEvent {
  const _DeleteCallplan({required this.id});
  

 final  int id;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCallplanCopyWith<_DeleteCallplan> get copyWith => __$DeleteCallplanCopyWithImpl<_DeleteCallplan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteCallplan&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CallplanEvent.delete(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteCallplanCopyWith<$Res> implements $CallplanEventCopyWith<$Res> {
  factory _$DeleteCallplanCopyWith(_DeleteCallplan value, $Res Function(_DeleteCallplan) _then) = __$DeleteCallplanCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$DeleteCallplanCopyWithImpl<$Res>
    implements _$DeleteCallplanCopyWith<$Res> {
  __$DeleteCallplanCopyWithImpl(this._self, this._then);

  final _DeleteCallplan _self;
  final $Res Function(_DeleteCallplan) _then;

/// Create a copy of CallplanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeleteCallplan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RefreshCallplan implements CallplanEvent {
  const _RefreshCallplan();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshCallplan);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallplanEvent.refresh()';
}


}




/// @nodoc
mixin _$CallplanState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallplanState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallplanState()';
}


}

/// @nodoc
class $CallplanStateCopyWith<$Res>  {
$CallplanStateCopyWith(CallplanState _, $Res Function(CallplanState) __);
}


/// Adds pattern-matching-related methods to [CallplanState].
extension CallplanStatePatterns on CallplanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _Success value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _Success value)  success,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _Success():
return success(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _Success value)?  success,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CallplanItem> data)?  loaded,TResult Function( String message)?  error,TResult Function( String message)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CallplanItem> data)  loaded,required TResult Function( String message)  error,required TResult Function( String message)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.data);case _Error():
return error(_that.message);case _Success():
return success(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CallplanItem> data)?  loaded,TResult? Function( String message)?  error,TResult? Function( String message)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CallplanState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallplanState.initial()';
}


}




/// @nodoc


class _Loading implements CallplanState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallplanState.loading()';
}


}




/// @nodoc


class _Loaded implements CallplanState {
  const _Loaded(final  List<CallplanItem> data): _data = data;
  

 final  List<CallplanItem> _data;
 List<CallplanItem> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of CallplanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'CallplanState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $CallplanStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<CallplanItem> data
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of CallplanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<CallplanItem>,
  ));
}


}

/// @nodoc


class _Error implements CallplanState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of CallplanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CallplanState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CallplanStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CallplanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements CallplanState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of CallplanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CallplanState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $CallplanStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of CallplanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
