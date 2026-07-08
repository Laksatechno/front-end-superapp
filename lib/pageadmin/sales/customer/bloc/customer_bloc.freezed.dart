// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerEvent()';
}


}

/// @nodoc
class $CustomerEventCopyWith<$Res>  {
$CustomerEventCopyWith(CustomerEvent _, $Res Function(CustomerEvent) __);
}


/// Adds pattern-matching-related methods to [CustomerEvent].
extension CustomerEventPatterns on CustomerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetCustomers value)?  getCustomers,TResult Function( _RefreshCustomers value)?  refresh,TResult Function( _ChangeFilter value)?  changeFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetCustomers() when getCustomers != null:
return getCustomers(_that);case _RefreshCustomers() when refresh != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetCustomers value)  getCustomers,required TResult Function( _RefreshCustomers value)  refresh,required TResult Function( _ChangeFilter value)  changeFilter,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetCustomers():
return getCustomers(_that);case _RefreshCustomers():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetCustomers value)?  getCustomers,TResult? Function( _RefreshCustomers value)?  refresh,TResult? Function( _ChangeFilter value)?  changeFilter,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetCustomers() when getCustomers != null:
return getCustomers(_that);case _RefreshCustomers() when refresh != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int page,  int perPage,  String? filterType,  String? status)?  getCustomers,TResult Function( int page,  int perPage,  String? filterType,  String? status)?  refresh,TResult Function( int perPage,  String? filterType,  String? status)?  changeFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetCustomers() when getCustomers != null:
return getCustomers(_that.page,_that.perPage,_that.filterType,_that.status);case _RefreshCustomers() when refresh != null:
return refresh(_that.page,_that.perPage,_that.filterType,_that.status);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that.perPage,_that.filterType,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int page,  int perPage,  String? filterType,  String? status)  getCustomers,required TResult Function( int page,  int perPage,  String? filterType,  String? status)  refresh,required TResult Function( int perPage,  String? filterType,  String? status)  changeFilter,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetCustomers():
return getCustomers(_that.page,_that.perPage,_that.filterType,_that.status);case _RefreshCustomers():
return refresh(_that.page,_that.perPage,_that.filterType,_that.status);case _ChangeFilter():
return changeFilter(_that.perPage,_that.filterType,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int page,  int perPage,  String? filterType,  String? status)?  getCustomers,TResult? Function( int page,  int perPage,  String? filterType,  String? status)?  refresh,TResult? Function( int perPage,  String? filterType,  String? status)?  changeFilter,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetCustomers() when getCustomers != null:
return getCustomers(_that.page,_that.perPage,_that.filterType,_that.status);case _RefreshCustomers() when refresh != null:
return refresh(_that.page,_that.perPage,_that.filterType,_that.status);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that.perPage,_that.filterType,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CustomerEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerEvent.started()';
}


}




/// @nodoc


class _GetCustomers implements CustomerEvent {
  const _GetCustomers({this.page = 1, this.perPage = 10, this.filterType, this.status});
  

@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? filterType;
 final  String? status;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetCustomersCopyWith<_GetCustomers> get copyWith => __$GetCustomersCopyWithImpl<_GetCustomers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCustomers&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,page,perPage,filterType,status);

@override
String toString() {
  return 'CustomerEvent.getCustomers(page: $page, perPage: $perPage, filterType: $filterType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GetCustomersCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory _$GetCustomersCopyWith(_GetCustomers value, $Res Function(_GetCustomers) _then) = __$GetCustomersCopyWithImpl;
@useResult
$Res call({
 int page, int perPage, String? filterType, String? status
});




}
/// @nodoc
class __$GetCustomersCopyWithImpl<$Res>
    implements _$GetCustomersCopyWith<$Res> {
  __$GetCustomersCopyWithImpl(this._self, this._then);

  final _GetCustomers _self;
  final $Res Function(_GetCustomers) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? filterType = freezed,Object? status = freezed,}) {
  return _then(_GetCustomers(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshCustomers implements CustomerEvent {
  const _RefreshCustomers({this.page = 1, this.perPage = 10, this.filterType, this.status});
  

@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? filterType;
 final  String? status;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshCustomersCopyWith<_RefreshCustomers> get copyWith => __$RefreshCustomersCopyWithImpl<_RefreshCustomers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshCustomers&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,page,perPage,filterType,status);

@override
String toString() {
  return 'CustomerEvent.refresh(page: $page, perPage: $perPage, filterType: $filterType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RefreshCustomersCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory _$RefreshCustomersCopyWith(_RefreshCustomers value, $Res Function(_RefreshCustomers) _then) = __$RefreshCustomersCopyWithImpl;
@useResult
$Res call({
 int page, int perPage, String? filterType, String? status
});




}
/// @nodoc
class __$RefreshCustomersCopyWithImpl<$Res>
    implements _$RefreshCustomersCopyWith<$Res> {
  __$RefreshCustomersCopyWithImpl(this._self, this._then);

  final _RefreshCustomers _self;
  final $Res Function(_RefreshCustomers) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? filterType = freezed,Object? status = freezed,}) {
  return _then(_RefreshCustomers(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ChangeFilter implements CustomerEvent {
  const _ChangeFilter({this.perPage = 10, this.filterType, this.status});
  

@JsonKey() final  int perPage;
 final  String? filterType;
 final  String? status;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeFilterCopyWith<_ChangeFilter> get copyWith => __$ChangeFilterCopyWithImpl<_ChangeFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeFilter&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,perPage,filterType,status);

@override
String toString() {
  return 'CustomerEvent.changeFilter(perPage: $perPage, filterType: $filterType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ChangeFilterCopyWith<$Res> implements $CustomerEventCopyWith<$Res> {
  factory _$ChangeFilterCopyWith(_ChangeFilter value, $Res Function(_ChangeFilter) _then) = __$ChangeFilterCopyWithImpl;
@useResult
$Res call({
 int perPage, String? filterType, String? status
});




}
/// @nodoc
class __$ChangeFilterCopyWithImpl<$Res>
    implements _$ChangeFilterCopyWith<$Res> {
  __$ChangeFilterCopyWithImpl(this._self, this._then);

  final _ChangeFilter _self;
  final $Res Function(_ChangeFilter) _then;

/// Create a copy of CustomerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? perPage = null,Object? filterType = freezed,Object? status = freezed,}) {
  return _then(_ChangeFilter(
perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CustomerState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerState()';
}


}

/// @nodoc
class $CustomerStateCopyWith<$Res>  {
$CustomerStateCopyWith(CustomerState _, $Res Function(CustomerState) __);
}


/// Adds pattern-matching-related methods to [CustomerState].
extension CustomerStatePatterns on CustomerState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Customer> data,  int page,  int perPage,  String? filterType,  String? status)?  loaded,TResult Function( String message)?  error,TResult Function( String message)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.page,_that.perPage,_that.filterType,_that.status);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Customer> data,  int page,  int perPage,  String? filterType,  String? status)  loaded,required TResult Function( String message)  error,required TResult Function( String message)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.data,_that.page,_that.perPage,_that.filterType,_that.status);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Customer> data,  int page,  int perPage,  String? filterType,  String? status)?  loaded,TResult? Function( String message)?  error,TResult? Function( String message)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.page,_that.perPage,_that.filterType,_that.status);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CustomerState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerState.initial()';
}


}




/// @nodoc


class _Loading implements CustomerState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerState.loading()';
}


}




/// @nodoc


class _Loaded implements CustomerState {
  const _Loaded({required final  List<Customer> data, this.page = 1, this.perPage = 10, this.filterType, this.status}): _data = data;
  

 final  List<Customer> _data;
 List<Customer> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? filterType;
 final  String? status;

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),page,perPage,filterType,status);

@override
String toString() {
  return 'CustomerState.loaded(data: $data, page: $page, perPage: $perPage, filterType: $filterType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $CustomerStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Customer> data, int page, int perPage, String? filterType, String? status
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? page = null,Object? perPage = null,Object? filterType = freezed,Object? status = freezed,}) {
  return _then(_Loaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<Customer>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error implements CustomerState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of CustomerState
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
  return 'CustomerState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CustomerStateCopyWith<$Res> {
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

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements CustomerState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of CustomerState
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
  return 'CustomerState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $CustomerStateCopyWith<$Res> {
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

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
