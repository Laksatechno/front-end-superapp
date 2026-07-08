// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlatEvent {

 int get perPage; String? get filterType; String? get status; String? get search;
/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlatEventCopyWith<AlatEvent> get copyWith => _$AlatEventCopyWithImpl<AlatEvent>(this as AlatEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlatEvent&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,perPage,filterType,status,search);

@override
String toString() {
  return 'AlatEvent(perPage: $perPage, filterType: $filterType, status: $status, search: $search)';
}


}

/// @nodoc
abstract mixin class $AlatEventCopyWith<$Res>  {
  factory $AlatEventCopyWith(AlatEvent value, $Res Function(AlatEvent) _then) = _$AlatEventCopyWithImpl;
@useResult
$Res call({
 int perPage, String? filterType, String? status, String? search
});




}
/// @nodoc
class _$AlatEventCopyWithImpl<$Res>
    implements $AlatEventCopyWith<$Res> {
  _$AlatEventCopyWithImpl(this._self, this._then);

  final AlatEvent _self;
  final $Res Function(AlatEvent) _then;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? perPage = null,Object? filterType = freezed,Object? status = freezed,Object? search = freezed,}) {
  return _then(_self.copyWith(
perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlatEvent].
extension AlatEventPatterns on AlatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetAlats value)?  getAlats,TResult Function( _RefreshAlats value)?  refresh,TResult Function( _ChangeFilter value)?  changeFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetAlats() when getAlats != null:
return getAlats(_that);case _RefreshAlats() when refresh != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetAlats value)  getAlats,required TResult Function( _RefreshAlats value)  refresh,required TResult Function( _ChangeFilter value)  changeFilter,}){
final _that = this;
switch (_that) {
case _GetAlats():
return getAlats(_that);case _RefreshAlats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetAlats value)?  getAlats,TResult? Function( _RefreshAlats value)?  refresh,TResult? Function( _ChangeFilter value)?  changeFilter,}){
final _that = this;
switch (_that) {
case _GetAlats() when getAlats != null:
return getAlats(_that);case _RefreshAlats() when refresh != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  int perPage,  String? filterType,  String? status,  String? search)?  getAlats,TResult Function( int page,  int perPage,  String? filterType,  String? status,  String? search)?  refresh,TResult Function( int perPage,  String? filterType,  String? status,  String? search)?  changeFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetAlats() when getAlats != null:
return getAlats(_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _RefreshAlats() when refresh != null:
return refresh(_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that.perPage,_that.filterType,_that.status,_that.search);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  int perPage,  String? filterType,  String? status,  String? search)  getAlats,required TResult Function( int page,  int perPage,  String? filterType,  String? status,  String? search)  refresh,required TResult Function( int perPage,  String? filterType,  String? status,  String? search)  changeFilter,}) {final _that = this;
switch (_that) {
case _GetAlats():
return getAlats(_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _RefreshAlats():
return refresh(_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _ChangeFilter():
return changeFilter(_that.perPage,_that.filterType,_that.status,_that.search);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  int perPage,  String? filterType,  String? status,  String? search)?  getAlats,TResult? Function( int page,  int perPage,  String? filterType,  String? status,  String? search)?  refresh,TResult? Function( int perPage,  String? filterType,  String? status,  String? search)?  changeFilter,}) {final _that = this;
switch (_that) {
case _GetAlats() when getAlats != null:
return getAlats(_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _RefreshAlats() when refresh != null:
return refresh(_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _ChangeFilter() when changeFilter != null:
return changeFilter(_that.perPage,_that.filterType,_that.status,_that.search);case _:
  return null;

}
}

}

/// @nodoc


class _GetAlats implements AlatEvent {
  const _GetAlats({this.page = 1, this.perPage = 10, this.filterType, this.status, this.search});
  

@JsonKey() final  int page;
@override@JsonKey() final  int perPage;
@override final  String? filterType;
@override final  String? status;
@override final  String? search;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetAlatsCopyWith<_GetAlats> get copyWith => __$GetAlatsCopyWithImpl<_GetAlats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAlats&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,page,perPage,filterType,status,search);

@override
String toString() {
  return 'AlatEvent.getAlats(page: $page, perPage: $perPage, filterType: $filterType, status: $status, search: $search)';
}


}

/// @nodoc
abstract mixin class _$GetAlatsCopyWith<$Res> implements $AlatEventCopyWith<$Res> {
  factory _$GetAlatsCopyWith(_GetAlats value, $Res Function(_GetAlats) _then) = __$GetAlatsCopyWithImpl;
@override @useResult
$Res call({
 int page, int perPage, String? filterType, String? status, String? search
});




}
/// @nodoc
class __$GetAlatsCopyWithImpl<$Res>
    implements _$GetAlatsCopyWith<$Res> {
  __$GetAlatsCopyWithImpl(this._self, this._then);

  final _GetAlats _self;
  final $Res Function(_GetAlats) _then;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? filterType = freezed,Object? status = freezed,Object? search = freezed,}) {
  return _then(_GetAlats(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshAlats implements AlatEvent {
  const _RefreshAlats({this.page = 1, this.perPage = 10, this.filterType, this.status, this.search});
  

@JsonKey() final  int page;
@override@JsonKey() final  int perPage;
@override final  String? filterType;
@override final  String? status;
@override final  String? search;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshAlatsCopyWith<_RefreshAlats> get copyWith => __$RefreshAlatsCopyWithImpl<_RefreshAlats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshAlats&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,page,perPage,filterType,status,search);

@override
String toString() {
  return 'AlatEvent.refresh(page: $page, perPage: $perPage, filterType: $filterType, status: $status, search: $search)';
}


}

/// @nodoc
abstract mixin class _$RefreshAlatsCopyWith<$Res> implements $AlatEventCopyWith<$Res> {
  factory _$RefreshAlatsCopyWith(_RefreshAlats value, $Res Function(_RefreshAlats) _then) = __$RefreshAlatsCopyWithImpl;
@override @useResult
$Res call({
 int page, int perPage, String? filterType, String? status, String? search
});




}
/// @nodoc
class __$RefreshAlatsCopyWithImpl<$Res>
    implements _$RefreshAlatsCopyWith<$Res> {
  __$RefreshAlatsCopyWithImpl(this._self, this._then);

  final _RefreshAlats _self;
  final $Res Function(_RefreshAlats) _then;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? filterType = freezed,Object? status = freezed,Object? search = freezed,}) {
  return _then(_RefreshAlats(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ChangeFilter implements AlatEvent {
  const _ChangeFilter({this.perPage = 10, this.filterType, this.status, this.search});
  

@override@JsonKey() final  int perPage;
@override final  String? filterType;
@override final  String? status;
@override final  String? search;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeFilterCopyWith<_ChangeFilter> get copyWith => __$ChangeFilterCopyWithImpl<_ChangeFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeFilter&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,perPage,filterType,status,search);

@override
String toString() {
  return 'AlatEvent.changeFilter(perPage: $perPage, filterType: $filterType, status: $status, search: $search)';
}


}

/// @nodoc
abstract mixin class _$ChangeFilterCopyWith<$Res> implements $AlatEventCopyWith<$Res> {
  factory _$ChangeFilterCopyWith(_ChangeFilter value, $Res Function(_ChangeFilter) _then) = __$ChangeFilterCopyWithImpl;
@override @useResult
$Res call({
 int perPage, String? filterType, String? status, String? search
});




}
/// @nodoc
class __$ChangeFilterCopyWithImpl<$Res>
    implements _$ChangeFilterCopyWith<$Res> {
  __$ChangeFilterCopyWithImpl(this._self, this._then);

  final _ChangeFilter _self;
  final $Res Function(_ChangeFilter) _then;

/// Create a copy of AlatEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? perPage = null,Object? filterType = freezed,Object? status = freezed,Object? search = freezed,}) {
  return _then(_ChangeFilter(
perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AlatState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlatState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AlatState()';
}


}

/// @nodoc
class $AlatStateCopyWith<$Res>  {
$AlatStateCopyWith(AlatState _, $Res Function(AlatState) __);
}


/// Adds pattern-matching-related methods to [AlatState].
extension AlatStatePatterns on AlatState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Alat> data,  int page,  int perPage,  String? filterType,  String? status,  String? search)?  loaded,TResult Function( String message)?  error,TResult Function( String message)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Alat> data,  int page,  int perPage,  String? filterType,  String? status,  String? search)  loaded,required TResult Function( String message)  error,required TResult Function( String message)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.data,_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Alat> data,  int page,  int perPage,  String? filterType,  String? status,  String? search)?  loaded,TResult? Function( String message)?  error,TResult? Function( String message)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.data,_that.page,_that.perPage,_that.filterType,_that.status,_that.search);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AlatState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AlatState.initial()';
}


}




/// @nodoc


class _Loading implements AlatState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AlatState.loading()';
}


}




/// @nodoc


class _Loaded implements AlatState {
  const _Loaded({required final  List<Alat> data, this.page = 1, this.perPage = 10, this.filterType, this.status, this.search}): _data = data;
  

 final  List<Alat> _data;
 List<Alat> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@JsonKey() final  int page;
@JsonKey() final  int perPage;
 final  String? filterType;
 final  String? status;
 final  String? search;

/// Create a copy of AlatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.status, status) || other.status == status)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),page,perPage,filterType,status,search);

@override
String toString() {
  return 'AlatState.loaded(data: $data, page: $page, perPage: $perPage, filterType: $filterType, status: $status, search: $search)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AlatStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Alat> data, int page, int perPage, String? filterType, String? status, String? search
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AlatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? page = null,Object? perPage = null,Object? filterType = freezed,Object? status = freezed,Object? search = freezed,}) {
  return _then(_Loaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<Alat>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error implements AlatState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AlatState
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
  return 'AlatState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AlatStateCopyWith<$Res> {
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

/// Create a copy of AlatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements AlatState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of AlatState
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
  return 'AlatState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $AlatStateCopyWith<$Res> {
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

/// Create a copy of AlatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
