import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pagecustomer/order/datasource/checkout_user_ds.dart';

part 'checkout_bloc.freezed.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutUserDataSource checkoutUserDataSource;

  CheckoutBloc({
    required this.checkoutUserDataSource,
  }) : super(
          const CheckoutState.initial(),
        ) {
    on<CheckoutRequested>(
      _onCheckoutRequested,
    );
  }

  Future<void> _onCheckoutRequested(
    CheckoutRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(
      const CheckoutState.loading(),
    );

    try {
      final result = await checkoutUserDataSource.checkoutUser(
        items: event.items,
        userName: event.userName,
        userAddress: event.userAddress,
        userPhone: event.userPhone,
        paymentType: event.paymentType,
      );

      result.fold(
        (failure) {
          emit(
            CheckoutState.error(
              failure.toString(),
            ),
          );
        },
        (message) {
          emit(
            CheckoutState.success(
              message,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        CheckoutState.error(
          e.toString(),
        ),
      );
    }
  }
}