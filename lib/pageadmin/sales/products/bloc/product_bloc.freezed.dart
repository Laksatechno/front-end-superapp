// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent()';
}


}

/// @nodoc
class $ProductEventCopyWith<$Res>  {
$ProductEventCopyWith(ProductEvent _, $Res Function(ProductEvent) __);
}


/// Adds pattern-matching-related methods to [ProductEvent].
extension ProductEventPatterns on ProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetProducts value)?  getProducts,TResult Function( _RefreshProducts value)?  refresh,TResult Function( _ChangeSearch value)?  changeSearch,TResult Function( _GetProductDetail value)?  getProductDetail,TResult Function( _AddProduct value)?  addProduct,TResult Function( _CreateBatch value)?  createBatch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetProducts() when getProducts != null:
return getProducts(_that);case _RefreshProducts() when refresh != null:
return refresh(_that);case _ChangeSearch() when changeSearch != null:
return changeSearch(_that);case _GetProductDetail() when getProductDetail != null:
return getProductDetail(_that);case _AddProduct() when addProduct != null:
return addProduct(_that);case _CreateBatch() when createBatch != null:
return createBatch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetProducts value)  getProducts,required TResult Function( _RefreshProducts value)  refresh,required TResult Function( _ChangeSearch value)  changeSearch,required TResult Function( _GetProductDetail value)  getProductDetail,required TResult Function( _AddProduct value)  addProduct,required TResult Function( _CreateBatch value)  createBatch,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetProducts():
return getProducts(_that);case _RefreshProducts():
return refresh(_that);case _ChangeSearch():
return changeSearch(_that);case _GetProductDetail():
return getProductDetail(_that);case _AddProduct():
return addProduct(_that);case _CreateBatch():
return createBatch(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetProducts value)?  getProducts,TResult? Function( _RefreshProducts value)?  refresh,TResult? Function( _ChangeSearch value)?  changeSearch,TResult? Function( _GetProductDetail value)?  getProductDetail,TResult? Function( _AddProduct value)?  addProduct,TResult? Function( _CreateBatch value)?  createBatch,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetProducts() when getProducts != null:
return getProducts(_that);case _RefreshProducts() when refresh != null:
return refresh(_that);case _ChangeSearch() when changeSearch != null:
return changeSearch(_that);case _GetProductDetail() when getProductDetail != null:
return getProductDetail(_that);case _AddProduct() when addProduct != null:
return addProduct(_that);case _CreateBatch() when createBatch != null:
return createBatch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int page,  int perPage,  String? search)?  getProducts,TResult Function( int page,  int perPage,  String? search)?  refresh,TResult Function( int perPage,  String? search)?  changeSearch,TResult Function( int id)?  getProductDetail,TResult Function( CreateProductRequest request)?  addProduct,TResult Function( CreateBatchRequest request)?  createBatch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetProducts() when getProducts != null:
return getProducts(_that.page,_that.perPage,_that.search);case _RefreshProducts() when refresh != null:
return refresh(_that.page,_that.perPage,_that.search);case _ChangeSearch() when changeSearch != null:
return changeSearch(_that.perPage,_that.search);case _GetProductDetail() when getProductDetail != null:
return getProductDetail(_that.id);case _AddProduct() when addProduct != null:
return addProduct(_that.request);case _CreateBatch() when createBatch != null:
return createBatch(_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int page,  int perPage,  String? search)  getProducts,required TResult Function( int page,  int perPage,  String? search)  refresh,required TResult Function( int perPage,  String? search)  changeSearch,required TResult Function( int id)  getProductDetail,required TResult Function( CreateProductRequest request)  addProduct,required TResult Function( CreateBatchRequest request)  createBatch,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetProducts():
return getProducts(_that.page,_that.perPage,_that.search);case _RefreshProducts():
return refresh(_that.page,_that.perPage,_that.search);case _ChangeSearch():
return changeSearch(_that.perPage,_that.search);case _GetProductDetail():
return getProductDetail(_that.id);case _AddProduct():
return addProduct(_that.request);case _CreateBatch():
return createBatch(_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int page,  int perPage,  String? search)?  getProducts,TResult? Function( int page,  int perPage,  String? search)?  refresh,TResult? Function( int perPage,  String? search)?  changeSearch,TResult? Function( int id)?  getProductDetail,TResult? Function( CreateProductRequest request)?  addProduct,TResult? Function( CreateBatchRequest request)?  createBatch,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetProducts() when getProducts != null:
return getProducts(_that.page,_that.perPage,_that.search);case _RefreshProducts() when refresh != null:
return refresh(_that.page,_that.perPage,_that.search);case _ChangeSearch() when changeSearch != null:
return changeSearch(_that.perPage,_that.search);case _GetProductDetail() when getProductDetail != null:
return getProductDetail(_that.id);case _AddProduct() when addProduct != null:
return addProduct(_that.request);case _CreateBatch() when createBatch != null:
return createBatch(_that.request);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ProductEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent.started()';
}


}




/// @nodoc


class _GetProducts implements ProductEvent {
  const _GetProducts({this.page = 1, this.perPage = 10, this.search});
  

@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? search;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProductsCopyWith<_GetProducts> get copyWith => __$GetProductsCopyWithImpl<_GetProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProducts&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,page,perPage,search);

@override
String toString() {
  return 'ProductEvent.getProducts(page: $page, perPage: $perPage, search: $search)';
}


}

/// @nodoc
abstract mixin class _$GetProductsCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$GetProductsCopyWith(_GetProducts value, $Res Function(_GetProducts) _then) = __$GetProductsCopyWithImpl;
@useResult
$Res call({
 int page, int perPage, String? search
});




}
/// @nodoc
class __$GetProductsCopyWithImpl<$Res>
    implements _$GetProductsCopyWith<$Res> {
  __$GetProductsCopyWithImpl(this._self, this._then);

  final _GetProducts _self;
  final $Res Function(_GetProducts) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? search = freezed,}) {
  return _then(_GetProducts(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshProducts implements ProductEvent {
  const _RefreshProducts({this.page = 1, this.perPage = 10, this.search});
  

@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? search;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshProductsCopyWith<_RefreshProducts> get copyWith => __$RefreshProductsCopyWithImpl<_RefreshProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshProducts&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,page,perPage,search);

@override
String toString() {
  return 'ProductEvent.refresh(page: $page, perPage: $perPage, search: $search)';
}


}

/// @nodoc
abstract mixin class _$RefreshProductsCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$RefreshProductsCopyWith(_RefreshProducts value, $Res Function(_RefreshProducts) _then) = __$RefreshProductsCopyWithImpl;
@useResult
$Res call({
 int page, int perPage, String? search
});




}
/// @nodoc
class __$RefreshProductsCopyWithImpl<$Res>
    implements _$RefreshProductsCopyWith<$Res> {
  __$RefreshProductsCopyWithImpl(this._self, this._then);

  final _RefreshProducts _self;
  final $Res Function(_RefreshProducts) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? search = freezed,}) {
  return _then(_RefreshProducts(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ChangeSearch implements ProductEvent {
  const _ChangeSearch({this.perPage = 10, this.search});
  

@JsonKey() final  int perPage;
 final  String? search;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeSearchCopyWith<_ChangeSearch> get copyWith => __$ChangeSearchCopyWithImpl<_ChangeSearch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeSearch&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,perPage,search);

@override
String toString() {
  return 'ProductEvent.changeSearch(perPage: $perPage, search: $search)';
}


}

/// @nodoc
abstract mixin class _$ChangeSearchCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$ChangeSearchCopyWith(_ChangeSearch value, $Res Function(_ChangeSearch) _then) = __$ChangeSearchCopyWithImpl;
@useResult
$Res call({
 int perPage, String? search
});




}
/// @nodoc
class __$ChangeSearchCopyWithImpl<$Res>
    implements _$ChangeSearchCopyWith<$Res> {
  __$ChangeSearchCopyWithImpl(this._self, this._then);

  final _ChangeSearch _self;
  final $Res Function(_ChangeSearch) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? perPage = null,Object? search = freezed,}) {
  return _then(_ChangeSearch(
perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _GetProductDetail implements ProductEvent {
  const _GetProductDetail({required this.id});
  

 final  int id;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProductDetailCopyWith<_GetProductDetail> get copyWith => __$GetProductDetailCopyWithImpl<_GetProductDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProductDetail&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProductEvent.getProductDetail(id: $id)';
}


}

/// @nodoc
abstract mixin class _$GetProductDetailCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$GetProductDetailCopyWith(_GetProductDetail value, $Res Function(_GetProductDetail) _then) = __$GetProductDetailCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$GetProductDetailCopyWithImpl<$Res>
    implements _$GetProductDetailCopyWith<$Res> {
  __$GetProductDetailCopyWithImpl(this._self, this._then);

  final _GetProductDetail _self;
  final $Res Function(_GetProductDetail) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_GetProductDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddProduct implements ProductEvent {
  const _AddProduct({required this.request});
  

 final  CreateProductRequest request;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddProductCopyWith<_AddProduct> get copyWith => __$AddProductCopyWithImpl<_AddProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddProduct&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ProductEvent.addProduct(request: $request)';
}


}

/// @nodoc
abstract mixin class _$AddProductCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$AddProductCopyWith(_AddProduct value, $Res Function(_AddProduct) _then) = __$AddProductCopyWithImpl;
@useResult
$Res call({
 CreateProductRequest request
});




}
/// @nodoc
class __$AddProductCopyWithImpl<$Res>
    implements _$AddProductCopyWith<$Res> {
  __$AddProductCopyWithImpl(this._self, this._then);

  final _AddProduct _self;
  final $Res Function(_AddProduct) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_AddProduct(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateProductRequest,
  ));
}


}

/// @nodoc


class _CreateBatch implements ProductEvent {
  const _CreateBatch({required this.request});
  

 final  CreateBatchRequest request;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateBatchCopyWith<_CreateBatch> get copyWith => __$CreateBatchCopyWithImpl<_CreateBatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateBatch&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ProductEvent.createBatch(request: $request)';
}


}

/// @nodoc
abstract mixin class _$CreateBatchCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$CreateBatchCopyWith(_CreateBatch value, $Res Function(_CreateBatch) _then) = __$CreateBatchCopyWithImpl;
@useResult
$Res call({
 CreateBatchRequest request
});




}
/// @nodoc
class __$CreateBatchCopyWithImpl<$Res>
    implements _$CreateBatchCopyWith<$Res> {
  __$CreateBatchCopyWithImpl(this._self, this._then);

  final _CreateBatch _self;
  final $Res Function(_CreateBatch) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_CreateBatch(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateBatchRequest,
  ));
}


}

/// @nodoc
mixin _$ProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState()';
}


}

/// @nodoc
class $ProductStateCopyWith<$Res>  {
$ProductStateCopyWith(ProductState _, $Res Function(ProductState) __);
}


/// Adds pattern-matching-related methods to [ProductState].
extension ProductStatePatterns on ProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _Success value)?  success,TResult Function( _BatchCreated value)?  batchCreated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _BatchCreated() when batchCreated != null:
return batchCreated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _Success value)  success,required TResult Function( _BatchCreated value)  batchCreated,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _Success():
return success(_that);case _BatchCreated():
return batchCreated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _Success value)?  success,TResult? Function( _BatchCreated value)?  batchCreated,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _BatchCreated() when batchCreated != null:
return batchCreated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ProductPageResponse data,  int page,  int perPage,  String? search,  Product? selected)?  loaded,TResult Function( String message)?  error,TResult Function( String message)?  success,TResult Function( String message)?  batchCreated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.page,_that.perPage,_that.search,_that.selected);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _BatchCreated() when batchCreated != null:
return batchCreated(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ProductPageResponse data,  int page,  int perPage,  String? search,  Product? selected)  loaded,required TResult Function( String message)  error,required TResult Function( String message)  success,required TResult Function( String message)  batchCreated,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.data,_that.page,_that.perPage,_that.search,_that.selected);case _Error():
return error(_that.message);case _Success():
return success(_that.message);case _BatchCreated():
return batchCreated(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ProductPageResponse data,  int page,  int perPage,  String? search,  Product? selected)?  loaded,TResult? Function( String message)?  error,TResult? Function( String message)?  success,TResult? Function( String message)?  batchCreated,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.page,_that.perPage,_that.search,_that.selected);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _BatchCreated() when batchCreated != null:
return batchCreated(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.initial()';
}


}




/// @nodoc


class _Loading implements ProductState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.loading()';
}


}




/// @nodoc


class _Loaded implements ProductState {
  const _Loaded({required this.data, this.page = 1, this.perPage = 10, this.search, this.selected});
  

 final  ProductPageResponse data;
@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? search;
 final  Product? selected;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.data, data) || other.data == data)&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.search, search) || other.search == search)&&(identical(other.selected, selected) || other.selected == selected));
}


@override
int get hashCode => Object.hash(runtimeType,data,page,perPage,search,selected);

@override
String toString() {
  return 'ProductState.loaded(data: $data, page: $page, perPage: $perPage, search: $search, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 ProductPageResponse data, int page, int perPage, String? search, Product? selected
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? page = null,Object? perPage = null,Object? search = freezed,Object? selected = freezed,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProductPageResponse,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Product?,
  ));
}


}

/// @nodoc


class _Error implements ProductState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ProductState
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
  return 'ProductState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
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

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements ProductState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of ProductState
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
  return 'ProductState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
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

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BatchCreated implements ProductState {
  const _BatchCreated(this.message);
  

 final  String message;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatchCreatedCopyWith<_BatchCreated> get copyWith => __$BatchCreatedCopyWithImpl<_BatchCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatchCreated&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductState.batchCreated(message: $message)';
}


}

/// @nodoc
abstract mixin class _$BatchCreatedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$BatchCreatedCopyWith(_BatchCreated value, $Res Function(_BatchCreated) _then) = __$BatchCreatedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$BatchCreatedCopyWithImpl<$Res>
    implements _$BatchCreatedCopyWith<$Res> {
  __$BatchCreatedCopyWithImpl(this._self, this._then);

  final _BatchCreated _self;
  final $Res Function(_BatchCreated) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_BatchCreated(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
