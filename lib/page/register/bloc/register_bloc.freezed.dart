// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterEvent {

 String get namaInstansi; String get namaPic; String get nomorPic; String get alamat; String get email; String get password; String get passwordConfirmation;
/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterEventCopyWith<RegisterEvent> get copyWith => _$RegisterEventCopyWithImpl<RegisterEvent>(this as RegisterEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEvent&&(identical(other.namaInstansi, namaInstansi) || other.namaInstansi == namaInstansi)&&(identical(other.namaPic, namaPic) || other.namaPic == namaPic)&&(identical(other.nomorPic, nomorPic) || other.nomorPic == nomorPic)&&(identical(other.alamat, alamat) || other.alamat == alamat)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,namaInstansi,namaPic,nomorPic,alamat,email,password,passwordConfirmation);

@override
String toString() {
  return 'RegisterEvent(namaInstansi: $namaInstansi, namaPic: $namaPic, nomorPic: $nomorPic, alamat: $alamat, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
}


}

/// @nodoc
abstract mixin class $RegisterEventCopyWith<$Res>  {
  factory $RegisterEventCopyWith(RegisterEvent value, $Res Function(RegisterEvent) _then) = _$RegisterEventCopyWithImpl;
@useResult
$Res call({
 String namaInstansi, String namaPic, String nomorPic, String alamat, String email, String password, String passwordConfirmation
});




}
/// @nodoc
class _$RegisterEventCopyWithImpl<$Res>
    implements $RegisterEventCopyWith<$Res> {
  _$RegisterEventCopyWithImpl(this._self, this._then);

  final RegisterEvent _self;
  final $Res Function(RegisterEvent) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? namaInstansi = null,Object? namaPic = null,Object? nomorPic = null,Object? alamat = null,Object? email = null,Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(_self.copyWith(
namaInstansi: null == namaInstansi ? _self.namaInstansi : namaInstansi // ignore: cast_nullable_to_non_nullable
as String,namaPic: null == namaPic ? _self.namaPic : namaPic // ignore: cast_nullable_to_non_nullable
as String,nomorPic: null == nomorPic ? _self.nomorPic : nomorPic // ignore: cast_nullable_to_non_nullable
as String,alamat: null == alamat ? _self.alamat : alamat // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterEvent].
extension RegisterEventPatterns on RegisterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Register value)?  register,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Register() when register != null:
return register(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Register value)  register,}){
final _that = this;
switch (_that) {
case _Register():
return register(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Register value)?  register,}){
final _that = this;
switch (_that) {
case _Register() when register != null:
return register(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String namaInstansi,  String namaPic,  String nomorPic,  String alamat,  String email,  String password,  String passwordConfirmation)?  register,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Register() when register != null:
return register(_that.namaInstansi,_that.namaPic,_that.nomorPic,_that.alamat,_that.email,_that.password,_that.passwordConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String namaInstansi,  String namaPic,  String nomorPic,  String alamat,  String email,  String password,  String passwordConfirmation)  register,}) {final _that = this;
switch (_that) {
case _Register():
return register(_that.namaInstansi,_that.namaPic,_that.nomorPic,_that.alamat,_that.email,_that.password,_that.passwordConfirmation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String namaInstansi,  String namaPic,  String nomorPic,  String alamat,  String email,  String password,  String passwordConfirmation)?  register,}) {final _that = this;
switch (_that) {
case _Register() when register != null:
return register(_that.namaInstansi,_that.namaPic,_that.nomorPic,_that.alamat,_that.email,_that.password,_that.passwordConfirmation);case _:
  return null;

}
}

}

/// @nodoc


class _Register implements RegisterEvent {
  const _Register({required this.namaInstansi, required this.namaPic, required this.nomorPic, required this.alamat, required this.email, required this.password, required this.passwordConfirmation});
  

@override final  String namaInstansi;
@override final  String namaPic;
@override final  String nomorPic;
@override final  String alamat;
@override final  String email;
@override final  String password;
@override final  String passwordConfirmation;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCopyWith<_Register> get copyWith => __$RegisterCopyWithImpl<_Register>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Register&&(identical(other.namaInstansi, namaInstansi) || other.namaInstansi == namaInstansi)&&(identical(other.namaPic, namaPic) || other.namaPic == namaPic)&&(identical(other.nomorPic, nomorPic) || other.nomorPic == nomorPic)&&(identical(other.alamat, alamat) || other.alamat == alamat)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,namaInstansi,namaPic,nomorPic,alamat,email,password,passwordConfirmation);

@override
String toString() {
  return 'RegisterEvent.register(namaInstansi: $namaInstansi, namaPic: $namaPic, nomorPic: $nomorPic, alamat: $alamat, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
}


}

/// @nodoc
abstract mixin class _$RegisterCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory _$RegisterCopyWith(_Register value, $Res Function(_Register) _then) = __$RegisterCopyWithImpl;
@override @useResult
$Res call({
 String namaInstansi, String namaPic, String nomorPic, String alamat, String email, String password, String passwordConfirmation
});




}
/// @nodoc
class __$RegisterCopyWithImpl<$Res>
    implements _$RegisterCopyWith<$Res> {
  __$RegisterCopyWithImpl(this._self, this._then);

  final _Register _self;
  final $Res Function(_Register) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? namaInstansi = null,Object? namaPic = null,Object? nomorPic = null,Object? alamat = null,Object? email = null,Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(_Register(
namaInstansi: null == namaInstansi ? _self.namaInstansi : namaInstansi // ignore: cast_nullable_to_non_nullable
as String,namaPic: null == namaPic ? _self.namaPic : namaPic // ignore: cast_nullable_to_non_nullable
as String,nomorPic: null == nomorPic ? _self.nomorPic : nomorPic // ignore: cast_nullable_to_non_nullable
as String,alamat: null == alamat ? _self.alamat : alamat // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RegisterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState()';
}


}

/// @nodoc
class $RegisterStateCopyWith<$Res>  {
$RegisterStateCopyWith(RegisterState _, $Res Function(RegisterState) __);
}


/// Adds pattern-matching-related methods to [RegisterState].
extension RegisterStatePatterns on RegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( RegisterModel data)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.data);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( RegisterModel data)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.data);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( RegisterModel data)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.data);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RegisterState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.initial()';
}


}




/// @nodoc


class _Loading implements RegisterState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.loading()';
}


}




/// @nodoc


class _Success implements RegisterState {
  const _Success(this.data);
  

 final  RegisterModel data;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'RegisterState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 RegisterModel data
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Success(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RegisterModel,
  ));
}


}

/// @nodoc


class _Error implements RegisterState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of RegisterState
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
  return 'RegisterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
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

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
