import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../datasource/customer_products_ds.dart';
import '../model/customer_product_price_model.dart';

part 'customer_products_event.dart';
part 'customer_products_state.dart';
part 'customer_products_bloc.freezed.dart';

class CustomerProductsBloc
    extends Bloc<CustomerProductsEvent, CustomerProductsState> {
  final CustomerProductsDataSource _remote;

  CustomerProductsBloc(this._remote)
      : super(const CustomerProductsState.initial()) {
    on<_GetByCustomer>(_onGetByCustomer);
    on<_Refresh>(_onRefresh);
    on<_Clear>(_onClear);
  }

  Future<void> _onGetByCustomer(
    _GetByCustomer event,
    Emitter<CustomerProductsState> emit,
  ) async {
    emit(const CustomerProductsState.loading());

    final result = await _remote.getProductsByCustomer(customerId: event.customerId);

    result.fold(
      (err) => emit(CustomerProductsState.error(err)),
      (data) => emit(CustomerProductsState.loaded(
        customerId: event.customerId,
        data: data,
      )),
    );
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<CustomerProductsState> emit,
  ) async {
    final currentCustomerId = state.maybeWhen(
      loaded: (customerId, data) => customerId,
      loading: () => null,
      initial: () => null,
      error: (_) => null, orElse: () {  },
    );

    final id = event.customerId ?? currentCustomerId;
    if (id == null) {
      emit(const CustomerProductsState.error('Customer ID belum dipilih'));
      return;
    }

    final result = await _remote.getProductsByCustomer(customerId: id);

    result.fold(
      (err) => emit(CustomerProductsState.error(err)),
      (data) => emit(CustomerProductsState.loaded(
        customerId: id,
        data: data,
      )),
    );
  }

  void _onClear(_Clear event, Emitter<CustomerProductsState> emit) {
    emit(const CustomerProductsState.initial());
  }
}