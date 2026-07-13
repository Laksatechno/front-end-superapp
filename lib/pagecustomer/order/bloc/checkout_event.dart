part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.checkoutRequested({
    required List<Map<String, dynamic>> items,
    required String userName,
    required String userAddress,
    required String userPhone,
    required String paymentType,
  }) = CheckoutRequested;
}