// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'riwayat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RiwayatEvent {

 String? get from; String? get to; String? get search;
/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiwayatEventCopyWith<RiwayatEvent> get copyWith => _$RiwayatEventCopyWithImpl<RiwayatEvent>(this as RiwayatEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiwayatEvent&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,search);

@override
String toString() {
  return 'RiwayatEvent(from: $from, to: $to, search: $search)';
}


}

/// @nodoc
abstract mixin class $RiwayatEventCopyWith<$Res>  {
  factory $RiwayatEventCopyWith(RiwayatEvent value, $Res Function(RiwayatEvent) _then) = _$RiwayatEventCopyWithImpl;
@useResult
$Res call({
 String? from, String? to, String? search
});




}
/// @nodoc
class _$RiwayatEventCopyWithImpl<$Res>
    implements $RiwayatEventCopyWith<$Res> {
  _$RiwayatEventCopyWithImpl(this._self, this._then);

  final RiwayatEvent _self;
  final $Res Function(RiwayatEvent) _then;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = freezed,Object? to = freezed,Object? search = freezed,}) {
  return _then(_self.copyWith(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RiwayatEvent].
extension RiwayatEventPatterns on RiwayatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetRiwayats value)?  getRiwayats,TResult Function( _RefreshRiwayats value)?  refresh,TResult Function( _ChangeFilter value)?  changeFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetRiwayats() when getRiwayats != null:
return getRiwayats(_that);case _RefreshRiwayats() when refresh != null:
return refresh(_that);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetRiwayats value)  getRiwayats,required TResult Function( _RefreshRiwayats value)  refresh,required TResult Function( _ChangeFilter value)  changeFilter,}){
final _that = this;
switch (_that) {
case _GetRiwayats():
return getRiwayats(_that);case _RefreshRiwayats():
return refresh(_that);case _ChangeFilter():
return changeFilter(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetRiwayats value)?  getRiwayats,TResult? Function( _RefreshRiwayats value)?  refresh,TResult? Function( _ChangeFilter value)?  changeFilter,}){
final _that = this;
switch (_that) {
case _GetRiwayats() when getRiwayats != null:
return getRiwayats(_that);case _RefreshRiwayats() when refresh != null:
return refresh(_that);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? from,  String? to,  String? search)?  getRiwayats,TResult Function( String? from,  String? to,  String? search)?  refresh,TResult Function( String? from,  String? to,  String? search)?  changeFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetRiwayats() when getRiwayats != null:
return getRiwayats(_that.from,_that.to,_that.search);case _RefreshRiwayats() when refresh != null:
return refresh(_that.from,_that.to,_that.search);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that.from,_that.to,_that.search);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? from,  String? to,  String? search)  getRiwayats,required TResult Function( String? from,  String? to,  String? search)  refresh,required TResult Function( String? from,  String? to,  String? search)  changeFilter,}) {final _that = this;
switch (_that) {
case _GetRiwayats():
return getRiwayats(_that.from,_that.to,_that.search);case _RefreshRiwayats():
return refresh(_that.from,_that.to,_that.search);case _ChangeFilter():
return changeFilter(_that.from,_that.to,_that.search);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? from,  String? to,  String? search)?  getRiwayats,TResult? Function( String? from,  String? to,  String? search)?  refresh,TResult? Function( String? from,  String? to,  String? search)?  changeFilter,}) {final _that = this;
switch (_that) {
case _GetRiwayats() when getRiwayats != null:
return getRiwayats(_that.from,_that.to,_that.search);case _RefreshRiwayats() when refresh != null:
return refresh(_that.from,_that.to,_that.search);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that.from,_that.to,_that.search);case _:
  return null;

}
}

}

/// @nodoc


class _GetRiwayats implements RiwayatEvent {
  const _GetRiwayats({this.from, this.to, this.search});
  

@override final  String? from;
@override final  String? to;
@override final  String? search;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetRiwayatsCopyWith<_GetRiwayats> get copyWith => __$GetRiwayatsCopyWithImpl<_GetRiwayats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetRiwayats&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,search);

@override
String toString() {
  return 'RiwayatEvent.getRiwayats(from: $from, to: $to, search: $search)';
}


}

/// @nodoc
abstract mixin class _$GetRiwayatsCopyWith<$Res> implements $RiwayatEventCopyWith<$Res> {
  factory _$GetRiwayatsCopyWith(_GetRiwayats value, $Res Function(_GetRiwayats) _then) = __$GetRiwayatsCopyWithImpl;
@override @useResult
$Res call({
 String? from, String? to, String? search
});




}
/// @nodoc
class __$GetRiwayatsCopyWithImpl<$Res>
    implements _$GetRiwayatsCopyWith<$Res> {
  __$GetRiwayatsCopyWithImpl(this._self, this._then);

  final _GetRiwayats _self;
  final $Res Function(_GetRiwayats) _then;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,Object? search = freezed,}) {
  return _then(_GetRiwayats(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshRiwayats implements RiwayatEvent {
  const _RefreshRiwayats({this.from, this.to, this.search});
  

@override final  String? from;
@override final  String? to;
@override final  String? search;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshRiwayatsCopyWith<_RefreshRiwayats> get copyWith => __$RefreshRiwayatsCopyWithImpl<_RefreshRiwayats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshRiwayats&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,search);

@override
String toString() {
  return 'RiwayatEvent.refresh(from: $from, to: $to, search: $search)';
}


}

/// @nodoc
abstract mixin class _$RefreshRiwayatsCopyWith<$Res> implements $RiwayatEventCopyWith<$Res> {
  factory _$RefreshRiwayatsCopyWith(_RefreshRiwayats value, $Res Function(_RefreshRiwayats) _then) = __$RefreshRiwayatsCopyWithImpl;
@override @useResult
$Res call({
 String? from, String? to, String? search
});




}
/// @nodoc
class __$RefreshRiwayatsCopyWithImpl<$Res>
    implements _$RefreshRiwayatsCopyWith<$Res> {
  __$RefreshRiwayatsCopyWithImpl(this._self, this._then);

  final _RefreshRiwayats _self;
  final $Res Function(_RefreshRiwayats) _then;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,Object? search = freezed,}) {
  return _then(_RefreshRiwayats(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ChangeFilter implements RiwayatEvent {
  const _ChangeFilter({this.from, this.to, this.search});
  

@override final  String? from;
@override final  String? to;
@override final  String? search;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeFilterCopyWith<_ChangeFilter> get copyWith => __$ChangeFilterCopyWithImpl<_ChangeFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeFilter&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,search);

@override
String toString() {
  return 'RiwayatEvent.changeFilter(from: $from, to: $to, search: $search)';
}


}

/// @nodoc
abstract mixin class _$ChangeFilterCopyWith<$Res> implements $RiwayatEventCopyWith<$Res> {
  factory _$ChangeFilterCopyWith(_ChangeFilter value, $Res Function(_ChangeFilter) _then) = __$ChangeFilterCopyWithImpl;
@override @useResult
$Res call({
 String? from, String? to, String? search
});




}
/// @nodoc
class __$ChangeFilterCopyWithImpl<$Res>
    implements _$ChangeFilterCopyWith<$Res> {
  __$ChangeFilterCopyWithImpl(this._self, this._then);

  final _ChangeFilter _self;
  final $Res Function(_ChangeFilter) _then;

/// Create a copy of RiwayatEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,Object? search = freezed,}) {
  return _then(_ChangeFilter(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$RiwayatState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiwayatState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RiwayatState()';
}


}

/// @nodoc
class $RiwayatStateCopyWith<$Res>  {
$RiwayatStateCopyWith(RiwayatState _, $Res Function(RiwayatState) __);
}


/// Adds pattern-matching-related methods to [RiwayatState].
extension RiwayatStatePatterns on RiwayatState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MaintenanceModel> data,  String? from,  String? to,  String? search)?  loaded,TResult Function( String message)?  error,TResult Function( String message)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.from,_that.to,_that.search);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MaintenanceModel> data,  String? from,  String? to,  String? search)  loaded,required TResult Function( String message)  error,required TResult Function( String message)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.data,_that.from,_that.to,_that.search);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MaintenanceModel> data,  String? from,  String? to,  String? search)?  loaded,TResult? Function( String message)?  error,TResult? Function( String message)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.from,_that.to,_that.search);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RiwayatState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RiwayatState.initial()';
}


}




/// @nodoc


class _Loading implements RiwayatState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RiwayatState.loading()';
}


}




/// @nodoc


class _Loaded implements RiwayatState {
  const _Loaded({required final  List<MaintenanceModel> data, this.from, this.to, this.search}): _data = data;
  

 final  List<MaintenanceModel> _data;
 List<MaintenanceModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

 final  String? from;
 final  String? to;
 final  String? search;

/// Create a copy of RiwayatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),from,to,search);

@override
String toString() {
  return 'RiwayatState.loaded(data: $data, from: $from, to: $to, search: $search)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $RiwayatStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<MaintenanceModel> data, String? from, String? to, String? search
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of RiwayatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? from = freezed,Object? to = freezed,Object? search = freezed,}) {
  return _then(_Loaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<MaintenanceModel>,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error implements RiwayatState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of RiwayatState
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
  return 'RiwayatState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RiwayatStateCopyWith<$Res> {
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

/// Create a copy of RiwayatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements RiwayatState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of RiwayatState
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
  return 'RiwayatState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $RiwayatStateCopyWith<$Res> {
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

/// Create a copy of RiwayatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
