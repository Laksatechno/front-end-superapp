// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesEvent()';
}


}

/// @nodoc
class $SalesEventCopyWith<$Res>  {
$SalesEventCopyWith(SalesEvent _, $Res Function(SalesEvent) __);
}


/// Adds pattern-matching-related methods to [SalesEvent].
extension SalesEventPatterns on SalesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetSales value)?  getSales,TResult Function( _Refresh value)?  refresh,TResult Function( _LoadMore value)?  loadMore,TResult Function( _ApplyFilter value)?  applyFilter,TResult Function( _ClearFilter value)?  clearFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetSales() when getSales != null:
return getSales(_that);case _Refresh() when refresh != null:
return refresh(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ApplyFilter() when applyFilter != null:
return applyFilter(_that);case _ClearFilter() when clearFilter != null:
return clearFilter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetSales value)  getSales,required TResult Function( _Refresh value)  refresh,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _ApplyFilter value)  applyFilter,required TResult Function( _ClearFilter value)  clearFilter,}){
final _that = this;
switch (_that) {
case _GetSales():
return getSales(_that);case _Refresh():
return refresh(_that);case _LoadMore():
return loadMore(_that);case _ApplyFilter():
return applyFilter(_that);case _ClearFilter():
return clearFilter(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetSales value)?  getSales,TResult? Function( _Refresh value)?  refresh,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _ApplyFilter value)?  applyFilter,TResult? Function( _ClearFilter value)?  clearFilter,}){
final _that = this;
switch (_that) {
case _GetSales() when getSales != null:
return getSales(_that);case _Refresh() when refresh != null:
return refresh(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ApplyFilter() when applyFilter != null:
return applyFilter(_that);case _ClearFilter() when clearFilter != null:
return clearFilter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  String? search,  int? year,  String? paymentStatus,  String? taxStatus)?  getSales,TResult Function( String? search,  int? year,  String? paymentStatus,  String? taxStatus)?  refresh,TResult Function()?  loadMore,TResult Function( String? search,  int? year,  String? paymentStatus,  String? taxStatus)?  applyFilter,TResult Function()?  clearFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetSales() when getSales != null:
return getSales(_that.page,_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _Refresh() when refresh != null:
return refresh(_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _LoadMore() when loadMore != null:
return loadMore();case _ApplyFilter() when applyFilter != null:
return applyFilter(_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _ClearFilter() when clearFilter != null:
return clearFilter();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  String? search,  int? year,  String? paymentStatus,  String? taxStatus)  getSales,required TResult Function( String? search,  int? year,  String? paymentStatus,  String? taxStatus)  refresh,required TResult Function()  loadMore,required TResult Function( String? search,  int? year,  String? paymentStatus,  String? taxStatus)  applyFilter,required TResult Function()  clearFilter,}) {final _that = this;
switch (_that) {
case _GetSales():
return getSales(_that.page,_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _Refresh():
return refresh(_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _LoadMore():
return loadMore();case _ApplyFilter():
return applyFilter(_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _ClearFilter():
return clearFilter();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  String? search,  int? year,  String? paymentStatus,  String? taxStatus)?  getSales,TResult? Function( String? search,  int? year,  String? paymentStatus,  String? taxStatus)?  refresh,TResult? Function()?  loadMore,TResult? Function( String? search,  int? year,  String? paymentStatus,  String? taxStatus)?  applyFilter,TResult? Function()?  clearFilter,}) {final _that = this;
switch (_that) {
case _GetSales() when getSales != null:
return getSales(_that.page,_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _Refresh() when refresh != null:
return refresh(_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _LoadMore() when loadMore != null:
return loadMore();case _ApplyFilter() when applyFilter != null:
return applyFilter(_that.search,_that.year,_that.paymentStatus,_that.taxStatus);case _ClearFilter() when clearFilter != null:
return clearFilter();case _:
  return null;

}
}

}

/// @nodoc


class _GetSales implements SalesEvent {
  const _GetSales({this.page = 1, this.search, this.year, this.paymentStatus, this.taxStatus});
  

@JsonKey() final  int page;
 final  String? search;
 final  int? year;
 final  String? paymentStatus;
 final  String? taxStatus;

/// Create a copy of SalesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetSalesCopyWith<_GetSales> get copyWith => __$GetSalesCopyWithImpl<_GetSales>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetSales&&(identical(other.page, page) || other.page == page)&&(identical(other.search, search) || other.search == search)&&(identical(other.year, year) || other.year == year)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.taxStatus, taxStatus) || other.taxStatus == taxStatus));
}


@override
int get hashCode => Object.hash(runtimeType,page,search,year,paymentStatus,taxStatus);

@override
String toString() {
  return 'SalesEvent.getSales(page: $page, search: $search, year: $year, paymentStatus: $paymentStatus, taxStatus: $taxStatus)';
}


}

/// @nodoc
abstract mixin class _$GetSalesCopyWith<$Res> implements $SalesEventCopyWith<$Res> {
  factory _$GetSalesCopyWith(_GetSales value, $Res Function(_GetSales) _then) = __$GetSalesCopyWithImpl;
@useResult
$Res call({
 int page, String? search, int? year, String? paymentStatus, String? taxStatus
});




}
/// @nodoc
class __$GetSalesCopyWithImpl<$Res>
    implements _$GetSalesCopyWith<$Res> {
  __$GetSalesCopyWithImpl(this._self, this._then);

  final _GetSales _self;
  final $Res Function(_GetSales) _then;

/// Create a copy of SalesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? search = freezed,Object? year = freezed,Object? paymentStatus = freezed,Object? taxStatus = freezed,}) {
  return _then(_GetSales(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,taxStatus: freezed == taxStatus ? _self.taxStatus : taxStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Refresh implements SalesEvent {
  const _Refresh({this.search, this.year, this.paymentStatus, this.taxStatus});
  

 final  String? search;
 final  int? year;
 final  String? paymentStatus;
 final  String? taxStatus;

/// Create a copy of SalesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshCopyWith<_Refresh> get copyWith => __$RefreshCopyWithImpl<_Refresh>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh&&(identical(other.search, search) || other.search == search)&&(identical(other.year, year) || other.year == year)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.taxStatus, taxStatus) || other.taxStatus == taxStatus));
}


@override
int get hashCode => Object.hash(runtimeType,search,year,paymentStatus,taxStatus);

@override
String toString() {
  return 'SalesEvent.refresh(search: $search, year: $year, paymentStatus: $paymentStatus, taxStatus: $taxStatus)';
}


}

/// @nodoc
abstract mixin class _$RefreshCopyWith<$Res> implements $SalesEventCopyWith<$Res> {
  factory _$RefreshCopyWith(_Refresh value, $Res Function(_Refresh) _then) = __$RefreshCopyWithImpl;
@useResult
$Res call({
 String? search, int? year, String? paymentStatus, String? taxStatus
});




}
/// @nodoc
class __$RefreshCopyWithImpl<$Res>
    implements _$RefreshCopyWith<$Res> {
  __$RefreshCopyWithImpl(this._self, this._then);

  final _Refresh _self;
  final $Res Function(_Refresh) _then;

/// Create a copy of SalesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = freezed,Object? year = freezed,Object? paymentStatus = freezed,Object? taxStatus = freezed,}) {
  return _then(_Refresh(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,taxStatus: freezed == taxStatus ? _self.taxStatus : taxStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadMore implements SalesEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesEvent.loadMore()';
}


}




/// @nodoc


class _ApplyFilter implements SalesEvent {
  const _ApplyFilter({this.search, this.year, this.paymentStatus, this.taxStatus});
  

 final  String? search;
 final  int? year;
 final  String? paymentStatus;
 final  String? taxStatus;

/// Create a copy of SalesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyFilterCopyWith<_ApplyFilter> get copyWith => __$ApplyFilterCopyWithImpl<_ApplyFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.year, year) || other.year == year)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.taxStatus, taxStatus) || other.taxStatus == taxStatus));
}


@override
int get hashCode => Object.hash(runtimeType,search,year,paymentStatus,taxStatus);

@override
String toString() {
  return 'SalesEvent.applyFilter(search: $search, year: $year, paymentStatus: $paymentStatus, taxStatus: $taxStatus)';
}


}

/// @nodoc
abstract mixin class _$ApplyFilterCopyWith<$Res> implements $SalesEventCopyWith<$Res> {
  factory _$ApplyFilterCopyWith(_ApplyFilter value, $Res Function(_ApplyFilter) _then) = __$ApplyFilterCopyWithImpl;
@useResult
$Res call({
 String? search, int? year, String? paymentStatus, String? taxStatus
});




}
/// @nodoc
class __$ApplyFilterCopyWithImpl<$Res>
    implements _$ApplyFilterCopyWith<$Res> {
  __$ApplyFilterCopyWithImpl(this._self, this._then);

  final _ApplyFilter _self;
  final $Res Function(_ApplyFilter) _then;

/// Create a copy of SalesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = freezed,Object? year = freezed,Object? paymentStatus = freezed,Object? taxStatus = freezed,}) {
  return _then(_ApplyFilter(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,taxStatus: freezed == taxStatus ? _self.taxStatus : taxStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ClearFilter implements SalesEvent {
  const _ClearFilter();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearFilter);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesEvent.clearFilter()';
}


}




/// @nodoc
mixin _$SalesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState()';
}


}

/// @nodoc
class $SalesStateCopyWith<$Res>  {
$SalesStateCopyWith(SalesState _, $Res Function(SalesState) __);
}


/// Adds pattern-matching-related methods to [SalesState].
extension SalesStatePatterns on SalesState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Sale> items,  int page,  int lastPage,  String? search,  int? year,  String? paymentStatus,  String? taxStatus,  bool isLoadingMore)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items,_that.page,_that.lastPage,_that.search,_that.year,_that.paymentStatus,_that.taxStatus,_that.isLoadingMore);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Sale> items,  int page,  int lastPage,  String? search,  int? year,  String? paymentStatus,  String? taxStatus,  bool isLoadingMore)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.items,_that.page,_that.lastPage,_that.search,_that.year,_that.paymentStatus,_that.taxStatus,_that.isLoadingMore);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Sale> items,  int page,  int lastPage,  String? search,  int? year,  String? paymentStatus,  String? taxStatus,  bool isLoadingMore)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items,_that.page,_that.lastPage,_that.search,_that.year,_that.paymentStatus,_that.taxStatus,_that.isLoadingMore);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SalesState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.initial()';
}


}




/// @nodoc


class _Loading implements SalesState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.loading()';
}


}




/// @nodoc


class _Loaded implements SalesState {
  const _Loaded({required final  List<Sale> items, required this.page, required this.lastPage, this.search, this.year, this.paymentStatus, this.taxStatus, this.isLoadingMore = false}): _items = items;
  

 final  List<Sale> _items;
 List<Sale> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int page;
 final  int lastPage;
 final  String? search;
 final  int? year;
 final  String? paymentStatus;
 final  String? taxStatus;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.search, search) || other.search == search)&&(identical(other.year, year) || other.year == year)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.taxStatus, taxStatus) || other.taxStatus == taxStatus)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,lastPage,search,year,paymentStatus,taxStatus,isLoadingMore);

@override
String toString() {
  return 'SalesState.loaded(items: $items, page: $page, lastPage: $lastPage, search: $search, year: $year, paymentStatus: $paymentStatus, taxStatus: $taxStatus, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Sale> items, int page, int lastPage, String? search, int? year, String? paymentStatus, String? taxStatus, bool isLoadingMore
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? lastPage = null,Object? search = freezed,Object? year = freezed,Object? paymentStatus = freezed,Object? taxStatus = freezed,Object? isLoadingMore = null,}) {
  return _then(_Loaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Sale>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,taxStatus: freezed == taxStatus ? _self.taxStatus : taxStatus // ignore: cast_nullable_to_non_nullable
as String?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Error implements SalesState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SalesState
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
  return 'SalesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
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

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
