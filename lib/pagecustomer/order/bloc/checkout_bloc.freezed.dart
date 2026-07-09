// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {

 List<Map<String, dynamic>> get items; String get userName; String get userAddress; String get userPhone;
/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutEventCopyWith<CheckoutEvent> get copyWith => _$CheckoutEventCopyWithImpl<CheckoutEvent>(this as CheckoutEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAddress, userAddress) || other.userAddress == userAddress)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),userName,userAddress,userPhone);

@override
String toString() {
  return 'CheckoutEvent(items: $items, userName: $userName, userAddress: $userAddress, userPhone: $userPhone)';
}


}

/// @nodoc
abstract mixin class $CheckoutEventCopyWith<$Res>  {
  factory $CheckoutEventCopyWith(CheckoutEvent value, $Res Function(CheckoutEvent) _then) = _$CheckoutEventCopyWithImpl;
@useResult
$Res call({
 List<Map<String, dynamic>> items, String userName, String userAddress, String userPhone
});




}
/// @nodoc
class _$CheckoutEventCopyWithImpl<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  _$CheckoutEventCopyWithImpl(this._self, this._then);

  final CheckoutEvent _self;
  final $Res Function(CheckoutEvent) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? userName = null,Object? userAddress = null,Object? userPhone = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAddress: null == userAddress ? _self.userAddress : userAddress // ignore: cast_nullable_to_non_nullable
as String,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutRequested value)?  checkoutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutRequested() when checkoutRequested != null:
return checkoutRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutRequested value)  checkoutRequested,}){
final _that = this;
switch (_that) {
case CheckoutRequested():
return checkoutRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutRequested value)?  checkoutRequested,}){
final _that = this;
switch (_that) {
case CheckoutRequested() when checkoutRequested != null:
return checkoutRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Map<String, dynamic>> items,  String userName,  String userAddress,  String userPhone)?  checkoutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutRequested() when checkoutRequested != null:
return checkoutRequested(_that.items,_that.userName,_that.userAddress,_that.userPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Map<String, dynamic>> items,  String userName,  String userAddress,  String userPhone)  checkoutRequested,}) {final _that = this;
switch (_that) {
case CheckoutRequested():
return checkoutRequested(_that.items,_that.userName,_that.userAddress,_that.userPhone);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Map<String, dynamic>> items,  String userName,  String userAddress,  String userPhone)?  checkoutRequested,}) {final _that = this;
switch (_that) {
case CheckoutRequested() when checkoutRequested != null:
return checkoutRequested(_that.items,_that.userName,_that.userAddress,_that.userPhone);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutRequested implements CheckoutEvent {
  const CheckoutRequested({required final  List<Map<String, dynamic>> items, required this.userName, required this.userAddress, required this.userPhone}): _items = items;
  

 final  List<Map<String, dynamic>> _items;
@override List<Map<String, dynamic>> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String userName;
@override final  String userAddress;
@override final  String userPhone;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutRequestedCopyWith<CheckoutRequested> get copyWith => _$CheckoutRequestedCopyWithImpl<CheckoutRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutRequested&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAddress, userAddress) || other.userAddress == userAddress)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),userName,userAddress,userPhone);

@override
String toString() {
  return 'CheckoutEvent.checkoutRequested(items: $items, userName: $userName, userAddress: $userAddress, userPhone: $userPhone)';
}


}

/// @nodoc
abstract mixin class $CheckoutRequestedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutRequestedCopyWith(CheckoutRequested value, $Res Function(CheckoutRequested) _then) = _$CheckoutRequestedCopyWithImpl;
@override @useResult
$Res call({
 List<Map<String, dynamic>> items, String userName, String userAddress, String userPhone
});




}
/// @nodoc
class _$CheckoutRequestedCopyWithImpl<$Res>
    implements $CheckoutRequestedCopyWith<$Res> {
  _$CheckoutRequestedCopyWithImpl(this._self, this._then);

  final CheckoutRequested _self;
  final $Res Function(CheckoutRequested) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? userName = null,Object? userAddress = null,Object? userPhone = null,}) {
  return _then(CheckoutRequested(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAddress: null == userAddress ? _self.userAddress : userAddress // ignore: cast_nullable_to_non_nullable
as String,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CheckoutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState()';
}


}

/// @nodoc
class $CheckoutStateCopyWith<$Res>  {
$CheckoutStateCopyWith(CheckoutState _, $Res Function(CheckoutState) __);
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutInitial value)?  initial,TResult Function( CheckoutLoading value)?  loading,TResult Function( CheckoutSuccess value)?  success,TResult Function( CheckoutError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial(_that);case CheckoutLoading() when loading != null:
return loading(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutInitial value)  initial,required TResult Function( CheckoutLoading value)  loading,required TResult Function( CheckoutSuccess value)  success,required TResult Function( CheckoutError value)  error,}){
final _that = this;
switch (_that) {
case CheckoutInitial():
return initial(_that);case CheckoutLoading():
return loading(_that);case CheckoutSuccess():
return success(_that);case CheckoutError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutInitial value)?  initial,TResult? Function( CheckoutLoading value)?  loading,TResult? Function( CheckoutSuccess value)?  success,TResult? Function( CheckoutError value)?  error,}){
final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial(_that);case CheckoutLoading() when loading != null:
return loading(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial();case CheckoutLoading() when loading != null:
return loading();case CheckoutSuccess() when success != null:
return success(_that.message);case CheckoutError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CheckoutInitial():
return initial();case CheckoutLoading():
return loading();case CheckoutSuccess():
return success(_that.message);case CheckoutError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial();case CheckoutLoading() when loading != null:
return loading();case CheckoutSuccess() when success != null:
return success(_that.message);case CheckoutError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutInitial implements CheckoutState {
  const CheckoutInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.initial()';
}


}




/// @nodoc


class CheckoutLoading implements CheckoutState {
  const CheckoutLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.loading()';
}


}




/// @nodoc


class CheckoutSuccess implements CheckoutState {
  const CheckoutSuccess(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSuccessCopyWith<CheckoutSuccess> get copyWith => _$CheckoutSuccessCopyWithImpl<CheckoutSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class $CheckoutSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutSuccessCopyWith(CheckoutSuccess value, $Res Function(CheckoutSuccess) _then) = _$CheckoutSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CheckoutSuccessCopyWithImpl<$Res>
    implements $CheckoutSuccessCopyWith<$Res> {
  _$CheckoutSuccessCopyWithImpl(this._self, this._then);

  final CheckoutSuccess _self;
  final $Res Function(CheckoutSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CheckoutSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutError implements CheckoutState {
  const CheckoutError(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutErrorCopyWith<CheckoutError> get copyWith => _$CheckoutErrorCopyWithImpl<CheckoutError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CheckoutErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutErrorCopyWith(CheckoutError value, $Res Function(CheckoutError) _then) = _$CheckoutErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CheckoutErrorCopyWithImpl<$Res>
    implements $CheckoutErrorCopyWith<$Res> {
  _$CheckoutErrorCopyWithImpl(this._self, this._then);

  final CheckoutError _self;
  final $Res Function(CheckoutError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CheckoutError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
