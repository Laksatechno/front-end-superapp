import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pageadmin/sales/customer/datasource/customer_ds.dart';
import 'package:yofa/pageadmin/sales/customer/model/customer_model.dart';

part 'customer_bloc.freezed.dart';
part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerDataSource _remote;

  CustomerBloc(this._remote) : super(const CustomerState.initial()) {
    on<_GetCustomers>(_onGetCustomers);
    on<_RefreshCustomers>(_onRefreshCustomers);
    on<_ChangeFilter>(_onChangeFilter);
  }

  Future<void> _onGetCustomers(_GetCustomers event, Emitter<CustomerState> emit) async {
    emit(const CustomerState.loading());

    final result = await _remote.fetchCustomers(
      page: event.page,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
    );

    result.fold(
      (err) => emit(CustomerState.error(err)),
      (res) => emit(CustomerState.loaded(
        data: res,
        page: event.page,
        perPage: event.perPage,
        filterType: event.filterType,
        status: event.status,
      )),
    );
  }

  Future<void> _onRefreshCustomers(_RefreshCustomers event, Emitter<CustomerState> emit) async {
    final current = state;

    // biar refresh tetap punya parameter terakhir
    final last = current.maybeWhen(
      loaded: (data, page, perPage, filterType, status) => (
        page: page,
        perPage: perPage,
        filterType: filterType,
        status: status,
      ),
      orElse: () => (
        page: event.page,
        perPage: event.perPage,
        filterType: event.filterType,
        status: event.status,
      ),
    );

    final result = await _remote.fetchCustomers(
      page: last.page,
      perPage: last.perPage,
      filterType: last.filterType,
      status: last.status,
    );

    result.fold(
      (err) => emit(CustomerState.error(err)),
      (res) => emit(CustomerState.loaded(
        data: res,
        page: last.page,
        perPage: last.perPage,
        filterType: last.filterType,
        status: last.status,
      )),
    );
  }

  Future<void> _onChangeFilter(_ChangeFilter event, Emitter<CustomerState> emit) async {
    // saat filter berubah, load ulang dari page 1
    add(CustomerEvent.getCustomers(
      page: 1,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
    ));
  }
}