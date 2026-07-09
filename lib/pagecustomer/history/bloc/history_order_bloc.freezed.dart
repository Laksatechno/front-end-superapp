// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryOrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryOrderEvent()';
}


}

/// @nodoc
class $HistoryOrderEventCopyWith<$Res>  {
$HistoryOrderEventCopyWith(HistoryOrderEvent _, $Res Function(HistoryOrderEvent) __);
}


/// Adds pattern-matching-related methods to [HistoryOrderEvent].
extension HistoryOrderEventPatterns on HistoryOrderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetOrders value)?  getOrders,TResult Function( _Refresh value)?  refresh,TResult Function( _LoadMore value)?  loadMore,TResult Function( _ApplyFilter value)?  applyFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetOrders() when getOrders != null:
return getOrders(_that);case _Refresh() when refresh != null:
return refresh(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ApplyFilter() when applyFilter != null:
return applyFilter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetOrders value)  getOrders,required TResult Function( _Refresh value)  refresh,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _ApplyFilter value)  applyFilter,}){
final _that = this;
switch (_that) {
case _GetOrders():
return getOrders(_that);case _Refresh():
return refresh(_that);case _LoadMore():
return loadMore(_that);case _ApplyFilter():
return applyFilter(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetOrders value)?  getOrders,TResult? Function( _Refresh value)?  refresh,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _ApplyFilter value)?  applyFilter,}){
final _that = this;
switch (_that) {
case _GetOrders() when getOrders != null:
return getOrders(_that);case _Refresh() when refresh != null:
return refresh(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ApplyFilter() when applyFilter != null:
return applyFilter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  String? search,  String? status,  int perPage)?  getOrders,TResult Function( String? search,  String? status)?  refresh,TResult Function()?  loadMore,TResult Function( String? search,  String? status)?  applyFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetOrders() when getOrders != null:
return getOrders(_that.page,_that.search,_that.status,_that.perPage);case _Refresh() when refresh != null:
return refresh(_that.search,_that.status);case _LoadMore() when loadMore != null:
return loadMore();case _ApplyFilter() when applyFilter != null:
return applyFilter(_that.search,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  String? search,  String? status,  int perPage)  getOrders,required TResult Function( String? search,  String? status)  refresh,required TResult Function()  loadMore,required TResult Function( String? search,  String? status)  applyFilter,}) {final _that = this;
switch (_that) {
case _GetOrders():
return getOrders(_that.page,_that.search,_that.status,_that.perPage);case _Refresh():
return refresh(_that.search,_that.status);case _LoadMore():
return loadMore();case _ApplyFilter():
return applyFilter(_that.search,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  String? search,  String? status,  int perPage)?  getOrders,TResult? Function( String? search,  String? status)?  refresh,TResult? Function()?  loadMore,TResult? Function( String? search,  String? status)?  applyFilter,}) {final _that = this;
switch (_that) {
case _GetOrders() when getOrders != null:
return getOrders(_that.page,_that.search,_that.status,_that.perPage);case _Refresh() when refresh != null:
return refresh(_that.search,_that.status);case _LoadMore() when loadMore != null:
return loadMore();case _ApplyFilter() when applyFilter != null:
return applyFilter(_that.search,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _GetOrders implements HistoryOrderEvent {
  const _GetOrders({this.page = 1, this.search, this.status, this.perPage = 10});
  

@JsonKey() final  int page;
 final  String? search;
 final  String? status;
@JsonKey() final  int perPage;

/// Create a copy of HistoryOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetOrdersCopyWith<_GetOrders> get copyWith => __$GetOrdersCopyWithImpl<_GetOrders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetOrders&&(identical(other.page, page) || other.page == page)&&(identical(other.search, search) || other.search == search)&&(identical(other.status, status) || other.status == status)&&(identical(other.perPage, perPage) || other.perPage == perPage));
}


@override
int get hashCode => Object.hash(runtimeType,page,search,status,perPage);

@override
String toString() {
  return 'HistoryOrderEvent.getOrders(page: $page, search: $search, status: $status, perPage: $perPage)';
}


}

/// @nodoc
abstract mixin class _$GetOrdersCopyWith<$Res> implements $HistoryOrderEventCopyWith<$Res> {
  factory _$GetOrdersCopyWith(_GetOrders value, $Res Function(_GetOrders) _then) = __$GetOrdersCopyWithImpl;
@useResult
$Res call({
 int page, String? search, String? status, int perPage
});




}
/// @nodoc
class __$GetOrdersCopyWithImpl<$Res>
    implements _$GetOrdersCopyWith<$Res> {
  __$GetOrdersCopyWithImpl(this._self, this._then);

  final _GetOrders _self;
  final $Res Function(_GetOrders) _then;

/// Create a copy of HistoryOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? search = freezed,Object? status = freezed,Object? perPage = null,}) {
  return _then(_GetOrders(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Refresh implements HistoryOrderEvent {
  const _Refresh({this.search, this.status});
  

 final  String? search;
 final  String? status;

/// Create a copy of HistoryOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshCopyWith<_Refresh> get copyWith => __$RefreshCopyWithImpl<_Refresh>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh&&(identical(other.search, search) || other.search == search)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,search,status);

@override
String toString() {
  return 'HistoryOrderEvent.refresh(search: $search, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RefreshCopyWith<$Res> implements $HistoryOrderEventCopyWith<$Res> {
  factory _$RefreshCopyWith(_Refresh value, $Res Function(_Refresh) _then) = __$RefreshCopyWithImpl;
@useResult
$Res call({
 String? search, String? status
});




}
/// @nodoc
class __$RefreshCopyWithImpl<$Res>
    implements _$RefreshCopyWith<$Res> {
  __$RefreshCopyWithImpl(this._self, this._then);

  final _Refresh _self;
  final $Res Function(_Refresh) _then;

/// Create a copy of HistoryOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = freezed,Object? status = freezed,}) {
  return _then(_Refresh(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadMore implements HistoryOrderEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryOrderEvent.loadMore()';
}


}




/// @nodoc


class _ApplyFilter implements HistoryOrderEvent {
  const _ApplyFilter({this.search, this.status});
  

 final  String? search;
 final  String? status;

/// Create a copy of HistoryOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyFilterCopyWith<_ApplyFilter> get copyWith => __$ApplyFilterCopyWithImpl<_ApplyFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,search,status);

@override
String toString() {
  return 'HistoryOrderEvent.applyFilter(search: $search, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ApplyFilterCopyWith<$Res> implements $HistoryOrderEventCopyWith<$Res> {
  factory _$ApplyFilterCopyWith(_ApplyFilter value, $Res Function(_ApplyFilter) _then) = __$ApplyFilterCopyWithImpl;
@useResult
$Res call({
 String? search, String? status
});




}
/// @nodoc
class __$ApplyFilterCopyWithImpl<$Res>
    implements _$ApplyFilterCopyWith<$Res> {
  __$ApplyFilterCopyWithImpl(this._self, this._then);

  final _ApplyFilter _self;
  final $Res Function(_ApplyFilter) _then;

/// Create a copy of HistoryOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = freezed,Object? status = freezed,}) {
  return _then(_ApplyFilter(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$HistoryOrderState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryOrderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryOrderState()';
}


}

/// @nodoc
class $HistoryOrderStateCopyWith<$Res>  {
$HistoryOrderStateCopyWith(HistoryOrderState _, $Res Function(HistoryOrderState) __);
}


/// Adds pattern-matching-related methods to [HistoryOrderState].
extension HistoryOrderStatePatterns on HistoryOrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CustomerOrderHistory> items,  int page,  int lastPage,  String? search,  String? status,  bool isLoadingMore)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items,_that.page,_that.lastPage,_that.search,_that.status,_that.isLoadingMore);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CustomerOrderHistory> items,  int page,  int lastPage,  String? search,  String? status,  bool isLoadingMore)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.items,_that.page,_that.lastPage,_that.search,_that.status,_that.isLoadingMore);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CustomerOrderHistory> items,  int page,  int lastPage,  String? search,  String? status,  bool isLoadingMore)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items,_that.page,_that.lastPage,_that.search,_that.status,_that.isLoadingMore);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HistoryOrderState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryOrderState.initial()';
}


}




/// @nodoc


class _Loading implements HistoryOrderState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryOrderState.loading()';
}


}




/// @nodoc


class _Loaded implements HistoryOrderState {
  const _Loaded({required final  List<CustomerOrderHistory> items, required this.page, required this.lastPage, this.search, this.status, this.isLoadingMore = false}): _items = items;
  

 final  List<CustomerOrderHistory> _items;
 List<CustomerOrderHistory> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int page;
 final  int lastPage;
 final  String? search;
 final  String? status;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of HistoryOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.search, search) || other.search == search)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,lastPage,search,status,isLoadingMore);

@override
String toString() {
  return 'HistoryOrderState.loaded(items: $items, page: $page, lastPage: $lastPage, search: $search, status: $status, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $HistoryOrderStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<CustomerOrderHistory> items, int page, int lastPage, String? search, String? status, bool isLoadingMore
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of HistoryOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? lastPage = null,Object? search = freezed,Object? status = freezed,Object? isLoadingMore = null,}) {
  return _then(_Loaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CustomerOrderHistory>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Error implements HistoryOrderState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of HistoryOrderState
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
  return 'HistoryOrderState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $HistoryOrderStateCopyWith<$Res> {
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

/// Create a copy of HistoryOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
