part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {

  const factory CheckoutState.initial() = CheckoutInitial;

  const factory CheckoutState.loading() = CheckoutLoading;

  const factory CheckoutState.success(
    String message,
  ) = CheckoutSuccess;

  const factory CheckoutState.error(
    String message,
  ) = CheckoutError;
}