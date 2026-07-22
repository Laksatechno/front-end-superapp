// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brosur_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrosurEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrosurEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BrosurEvent()';
}


}

/// @nodoc
class $BrosurEventCopyWith<$Res>  {
$BrosurEventCopyWith(BrosurEvent _, $Res Function(BrosurEvent) __);
}


/// Adds pattern-matching-related methods to [BrosurEvent].
extension BrosurEventPatterns on BrosurEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Fetch value)?  fetch,TResult Function( _Download value)?  download,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fetch() when fetch != null:
return fetch(_that);case _Download() when download != null:
return download(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Fetch value)  fetch,required TResult Function( _Download value)  download,}){
final _that = this;
switch (_that) {
case _Fetch():
return fetch(_that);case _Download():
return download(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Fetch value)?  fetch,TResult? Function( _Download value)?  download,}){
final _that = this;
switch (_that) {
case _Fetch() when fetch != null:
return fetch(_that);case _Download() when download != null:
return download(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? search)?  fetch,TResult Function( int id,  String fileName)?  download,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fetch() when fetch != null:
return fetch(_that.search);case _Download() when download != null:
return download(_that.id,_that.fileName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? search)  fetch,required TResult Function( int id,  String fileName)  download,}) {final _that = this;
switch (_that) {
case _Fetch():
return fetch(_that.search);case _Download():
return download(_that.id,_that.fileName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? search)?  fetch,TResult? Function( int id,  String fileName)?  download,}) {final _that = this;
switch (_that) {
case _Fetch() when fetch != null:
return fetch(_that.search);case _Download() when download != null:
return download(_that.id,_that.fileName);case _:
  return null;

}
}

}

/// @nodoc


class _Fetch implements BrosurEvent {
  const _Fetch({this.search});
  

 final  String? search;

/// Create a copy of BrosurEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchCopyWith<_Fetch> get copyWith => __$FetchCopyWithImpl<_Fetch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fetch&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,search);

@override
String toString() {
  return 'BrosurEvent.fetch(search: $search)';
}


}

/// @nodoc
abstract mixin class _$FetchCopyWith<$Res> implements $BrosurEventCopyWith<$Res> {
  factory _$FetchCopyWith(_Fetch value, $Res Function(_Fetch) _then) = __$FetchCopyWithImpl;
@useResult
$Res call({
 String? search
});




}
/// @nodoc
class __$FetchCopyWithImpl<$Res>
    implements _$FetchCopyWith<$Res> {
  __$FetchCopyWithImpl(this._self, this._then);

  final _Fetch _self;
  final $Res Function(_Fetch) _then;

/// Create a copy of BrosurEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = freezed,}) {
  return _then(_Fetch(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Download implements BrosurEvent {
  const _Download({required this.id, required this.fileName});
  

 final  int id;
 final  String fileName;

/// Create a copy of BrosurEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadCopyWith<_Download> get copyWith => __$DownloadCopyWithImpl<_Download>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Download&&(identical(other.id, id) || other.id == id)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}


@override
int get hashCode => Object.hash(runtimeType,id,fileName);

@override
String toString() {
  return 'BrosurEvent.download(id: $id, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class _$DownloadCopyWith<$Res> implements $BrosurEventCopyWith<$Res> {
  factory _$DownloadCopyWith(_Download value, $Res Function(_Download) _then) = __$DownloadCopyWithImpl;
@useResult
$Res call({
 int id, String fileName
});




}
/// @nodoc
class __$DownloadCopyWithImpl<$Res>
    implements _$DownloadCopyWith<$Res> {
  __$DownloadCopyWithImpl(this._self, this._then);

  final _Download _self;
  final $Res Function(_Download) _then;

/// Create a copy of BrosurEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fileName = null,}) {
  return _then(_Download(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BrosurState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrosurState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BrosurState()';
}


}

/// @nodoc
class $BrosurStateCopyWith<$Res>  {
$BrosurStateCopyWith(BrosurState _, $Res Function(BrosurState) __);
}


/// Adds pattern-matching-related methods to [BrosurState].
extension BrosurStatePatterns on BrosurState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _DownloadSuccess value)?  downloadSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _DownloadSuccess() when downloadSuccess != null:
return downloadSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _DownloadSuccess value)  downloadSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _DownloadSuccess():
return downloadSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _DownloadSuccess value)?  downloadSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _DownloadSuccess() when downloadSuccess != null:
return downloadSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Brosur> brosur,  int? downloadingId)?  loaded,TResult Function( String message,  List<Brosur> brosur)?  error,TResult Function( String filePath,  List<Brosur> brosur)?  downloadSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.brosur,_that.downloadingId);case _Error() when error != null:
return error(_that.message,_that.brosur);case _DownloadSuccess() when downloadSuccess != null:
return downloadSuccess(_that.filePath,_that.brosur);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Brosur> brosur,  int? downloadingId)  loaded,required TResult Function( String message,  List<Brosur> brosur)  error,required TResult Function( String filePath,  List<Brosur> brosur)  downloadSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.brosur,_that.downloadingId);case _Error():
return error(_that.message,_that.brosur);case _DownloadSuccess():
return downloadSuccess(_that.filePath,_that.brosur);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Brosur> brosur,  int? downloadingId)?  loaded,TResult? Function( String message,  List<Brosur> brosur)?  error,TResult? Function( String filePath,  List<Brosur> brosur)?  downloadSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.brosur,_that.downloadingId);case _Error() when error != null:
return error(_that.message,_that.brosur);case _DownloadSuccess() when downloadSuccess != null:
return downloadSuccess(_that.filePath,_that.brosur);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements BrosurState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BrosurState.initial()';
}


}




/// @nodoc


class _Loading implements BrosurState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BrosurState.loading()';
}


}




/// @nodoc


class _Loaded implements BrosurState {
  const _Loaded({required final  List<Brosur> brosur, this.downloadingId = null}): _brosur = brosur;
  

 final  List<Brosur> _brosur;
 List<Brosur> get brosur {
  if (_brosur is EqualUnmodifiableListView) return _brosur;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brosur);
}

@JsonKey() final  int? downloadingId;

/// Create a copy of BrosurState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._brosur, _brosur)&&(identical(other.downloadingId, downloadingId) || other.downloadingId == downloadingId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_brosur),downloadingId);

@override
String toString() {
  return 'BrosurState.loaded(brosur: $brosur, downloadingId: $downloadingId)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $BrosurStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Brosur> brosur, int? downloadingId
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of BrosurState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brosur = null,Object? downloadingId = freezed,}) {
  return _then(_Loaded(
brosur: null == brosur ? _self._brosur : brosur // ignore: cast_nullable_to_non_nullable
as List<Brosur>,downloadingId: freezed == downloadingId ? _self.downloadingId : downloadingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _Error implements BrosurState {
  const _Error({required this.message, final  List<Brosur> brosur = const []}): _brosur = brosur;
  

 final  String message;
 final  List<Brosur> _brosur;
@JsonKey() List<Brosur> get brosur {
  if (_brosur is EqualUnmodifiableListView) return _brosur;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brosur);
}


/// Create a copy of BrosurState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._brosur, _brosur));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_brosur));

@override
String toString() {
  return 'BrosurState.error(message: $message, brosur: $brosur)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $BrosurStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, List<Brosur> brosur
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of BrosurState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? brosur = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,brosur: null == brosur ? _self._brosur : brosur // ignore: cast_nullable_to_non_nullable
as List<Brosur>,
  ));
}


}

/// @nodoc


class _DownloadSuccess implements BrosurState {
  const _DownloadSuccess({required this.filePath, required final  List<Brosur> brosur}): _brosur = brosur;
  

 final  String filePath;
 final  List<Brosur> _brosur;
 List<Brosur> get brosur {
  if (_brosur is EqualUnmodifiableListView) return _brosur;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brosur);
}


/// Create a copy of BrosurState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadSuccessCopyWith<_DownloadSuccess> get copyWith => __$DownloadSuccessCopyWithImpl<_DownloadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadSuccess&&(identical(other.filePath, filePath) || other.filePath == filePath)&&const DeepCollectionEquality().equals(other._brosur, _brosur));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,const DeepCollectionEquality().hash(_brosur));

@override
String toString() {
  return 'BrosurState.downloadSuccess(filePath: $filePath, brosur: $brosur)';
}


}

/// @nodoc
abstract mixin class _$DownloadSuccessCopyWith<$Res> implements $BrosurStateCopyWith<$Res> {
  factory _$DownloadSuccessCopyWith(_DownloadSuccess value, $Res Function(_DownloadSuccess) _then) = __$DownloadSuccessCopyWithImpl;
@useResult
$Res call({
 String filePath, List<Brosur> brosur
});




}
/// @nodoc
class __$DownloadSuccessCopyWithImpl<$Res>
    implements _$DownloadSuccessCopyWith<$Res> {
  __$DownloadSuccessCopyWithImpl(this._self, this._then);

  final _DownloadSuccess _self;
  final $Res Function(_DownloadSuccess) _then;

/// Create a copy of BrosurState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,Object? brosur = null,}) {
  return _then(_DownloadSuccess(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,brosur: null == brosur ? _self._brosur : brosur // ignore: cast_nullable_to_non_nullable
as List<Brosur>,
  ));
}


}

// dart format on
