// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kelola_kunjungan_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KelolaKunjunganEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KelolaKunjunganEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KelolaKunjunganEvent()';
}


}

/// @nodoc
class $KelolaKunjunganEventCopyWith<$Res>  {
$KelolaKunjunganEventCopyWith(KelolaKunjunganEvent _, $Res Function(KelolaKunjunganEvent) __);
}


/// Adds pattern-matching-related methods to [KelolaKunjunganEvent].
extension KelolaKunjunganEventPatterns on KelolaKunjunganEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetKunjungan value)?  getKunjungan,TResult Function( _Refresh value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetKunjungan() when getKunjungan != null:
return getKunjungan(_that);case _Refresh() when refresh != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetKunjungan value)  getKunjungan,required TResult Function( _Refresh value)  refresh,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetKunjungan():
return getKunjungan(_that);case _Refresh():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetKunjungan value)?  getKunjungan,TResult? Function( _Refresh value)?  refresh,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetKunjungan() when getKunjungan != null:
return getKunjungan(_that);case _Refresh() when refresh != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String? filterType,  DateTimeRange? dateRange,  String? status)?  getKunjungan,TResult Function( String? filterType,  DateTimeRange? dateRange,  String? status)?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetKunjungan() when getKunjungan != null:
return getKunjungan(_that.filterType,_that.dateRange,_that.status);case _Refresh() when refresh != null:
return refresh(_that.filterType,_that.dateRange,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String? filterType,  DateTimeRange? dateRange,  String? status)  getKunjungan,required TResult Function( String? filterType,  DateTimeRange? dateRange,  String? status)  refresh,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetKunjungan():
return getKunjungan(_that.filterType,_that.dateRange,_that.status);case _Refresh():
return refresh(_that.filterType,_that.dateRange,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String? filterType,  DateTimeRange? dateRange,  String? status)?  getKunjungan,TResult? Function( String? filterType,  DateTimeRange? dateRange,  String? status)?  refresh,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetKunjungan() when getKunjungan != null:
return getKunjungan(_that.filterType,_that.dateRange,_that.status);case _Refresh() when refresh != null:
return refresh(_that.filterType,_that.dateRange,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements KelolaKunjunganEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KelolaKunjunganEvent.started()';
}


}




/// @nodoc


class _GetKunjungan implements KelolaKunjunganEvent {
  const _GetKunjungan({this.filterType, this.dateRange, this.status});
  

 final  String? filterType;
 final  DateTimeRange? dateRange;
 final  String? status;

/// Create a copy of KelolaKunjunganEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetKunjunganCopyWith<_GetKunjungan> get copyWith => __$GetKunjunganCopyWithImpl<_GetKunjungan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetKunjungan&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,filterType,dateRange,status);

@override
String toString() {
  return 'KelolaKunjunganEvent.getKunjungan(filterType: $filterType, dateRange: $dateRange, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GetKunjunganCopyWith<$Res> implements $KelolaKunjunganEventCopyWith<$Res> {
  factory _$GetKunjunganCopyWith(_GetKunjungan value, $Res Function(_GetKunjungan) _then) = __$GetKunjunganCopyWithImpl;
@useResult
$Res call({
 String? filterType, DateTimeRange? dateRange, String? status
});




}
/// @nodoc
class __$GetKunjunganCopyWithImpl<$Res>
    implements _$GetKunjunganCopyWith<$Res> {
  __$GetKunjunganCopyWithImpl(this._self, this._then);

  final _GetKunjungan _self;
  final $Res Function(_GetKunjungan) _then;

/// Create a copy of KelolaKunjunganEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filterType = freezed,Object? dateRange = freezed,Object? status = freezed,}) {
  return _then(_GetKunjungan(
filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,dateRange: freezed == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateTimeRange?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Refresh implements KelolaKunjunganEvent {
  const _Refresh({this.filterType, this.dateRange, this.status});
  

 final  String? filterType;
 final  DateTimeRange? dateRange;
 final  String? status;

/// Create a copy of KelolaKunjunganEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshCopyWith<_Refresh> get copyWith => __$RefreshCopyWithImpl<_Refresh>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,filterType,dateRange,status);

@override
String toString() {
  return 'KelolaKunjunganEvent.refresh(filterType: $filterType, dateRange: $dateRange, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RefreshCopyWith<$Res> implements $KelolaKunjunganEventCopyWith<$Res> {
  factory _$RefreshCopyWith(_Refresh value, $Res Function(_Refresh) _then) = __$RefreshCopyWithImpl;
@useResult
$Res call({
 String? filterType, DateTimeRange? dateRange, String? status
});




}
/// @nodoc
class __$RefreshCopyWithImpl<$Res>
    implements _$RefreshCopyWith<$Res> {
  __$RefreshCopyWithImpl(this._self, this._then);

  final _Refresh _self;
  final $Res Function(_Refresh) _then;

/// Create a copy of KelolaKunjunganEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filterType = freezed,Object? dateRange = freezed,Object? status = freezed,}) {
  return _then(_Refresh(
filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,dateRange: freezed == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateTimeRange?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$KelolaKunjunganState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KelolaKunjunganState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KelolaKunjunganState()';
}


}

/// @nodoc
class $KelolaKunjunganStateCopyWith<$Res>  {
$KelolaKunjunganStateCopyWith(KelolaKunjunganState _, $Res Function(KelolaKunjunganState) __);
}


/// Adds pattern-matching-related methods to [KelolaKunjunganState].
extension KelolaKunjunganStatePatterns on KelolaKunjunganState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Empty value)?  empty,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Empty value)  empty,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Empty():
return empty(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Empty value)?  empty,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<KunjunganData> items)?  loaded,TResult Function()?  empty,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items);case _Empty() when empty != null:
return empty();case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<KunjunganData> items)  loaded,required TResult Function()  empty,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.items);case _Empty():
return empty();case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<KunjunganData> items)?  loaded,TResult? Function()?  empty,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items);case _Empty() when empty != null:
return empty();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements KelolaKunjunganState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KelolaKunjunganState.initial()';
}


}




/// @nodoc


class _Loading implements KelolaKunjunganState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KelolaKunjunganState.loading()';
}


}




/// @nodoc


class _Loaded implements KelolaKunjunganState {
  const _Loaded(final  List<KunjunganData> items): _items = items;
  

 final  List<KunjunganData> _items;
 List<KunjunganData> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of KelolaKunjunganState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'KelolaKunjunganState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $KelolaKunjunganStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<KunjunganData> items
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of KelolaKunjunganState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_Loaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<KunjunganData>,
  ));
}


}

/// @nodoc


class _Empty implements KelolaKunjunganState {
  const _Empty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KelolaKunjunganState.empty()';
}


}




/// @nodoc


class _Error implements KelolaKunjunganState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of KelolaKunjunganState
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
  return 'KelolaKunjunganState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $KelolaKunjunganStateCopyWith<$Res> {
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

/// Create a copy of KelolaKunjunganState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
