part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loading() = _Loading;
  const factory PaymentState.loaded(PaymentModel data) = _Loaded;
  const factory PaymentState.error(String message) = _Error;
}
