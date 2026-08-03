import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pageadmin/sales/customer/datasource/customer_ds.dart';
import 'package:yofa/pageadmin/sales/customer/model/customer_model.dart';

part 'customer_bloc.freezed.dart';
part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerDataSource _remote;

  // Pagination state disimpan di sini (bukan di freezed state)
  int _lastPage = 1;
  bool _isLoadingMore = false;

  bool get hasReachedMax =>
      state.maybeWhen(
        loaded: (data, page, perPage, filterType, status) => page >= _lastPage,
        orElse: () => true,
      );

  bool get isLoadingMore => _isLoadingMore;

  CustomerBloc(this._remote) : super(const CustomerState.initial()) {
    on<_GetCustomers>(_onGetCustomers);
    on<_RefreshCustomers>(_onRefreshCustomers);
    on<_ChangeFilter>(_onChangeFilter);
  }

  Future<void> _onGetCustomers(
      _GetCustomers event, Emitter<CustomerState> emit) async {
    // Jika page == 1 berarti load awal / refresh filter, tampilkan loading
    if (event.page == 1) {
      _isLoadingMore = false;
      emit(const CustomerState.loading());
    } else {
      // load more: set flag tapi jangan replace state (UI akan detect dari bloc.isLoadingMore)
      if (_isLoadingMore || hasReachedMax) return;
      _isLoadingMore = true;
      // emit ulang state loaded yang sama agar UI bisa rebuild (detect isLoadingMore)
      final current = state.maybeWhen(
        loaded: (data, page, perPage, filterType, status) =>
            CustomerState.loaded(
          data: data,
          page: page,
          perPage: perPage,
          filterType: filterType,
          status: status,
        ),
        orElse: () => null,
      );
      if (current != null) emit(current);
    }

    final result = await _remote.fetchCustomers(
      page: event.page,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
    );

    _isLoadingMore = false;

    result.fold(
      (err) => emit(CustomerState.error(err)),
      (res) {
        _lastPage = res.lastPage;

        // Jika page > 1, append data ke existing list
        if (event.page > 1) {
          final existingData = state.maybeWhen(
            loaded: (data, page, perPage, filterType, status) => data,
            orElse: () => <Customer>[],
          );
          emit(CustomerState.loaded(
            data: [...existingData, ...res.customers],
            page: event.page,
            perPage: event.perPage,
            filterType: event.filterType,
            status: event.status,
          ));
        } else {
          emit(CustomerState.loaded(
            data: res.customers,
            page: event.page,
            perPage: event.perPage,
            filterType: event.filterType,
            status: event.status,
          ));
        }
      },
    );
  }

  Future<void> _onRefreshCustomers(
      _RefreshCustomers event, Emitter<CustomerState> emit) async {
    _lastPage = 1;
    _isLoadingMore = false;

    final last = state.maybeWhen(
      loaded: (data, page, perPage, filterType, status) => (
        perPage: perPage,
        filterType: filterType,
        status: status,
      ),
      orElse: () => (
        perPage: event.perPage,
        filterType: event.filterType,
        status: event.status,
      ),
    );

    emit(const CustomerState.loading());

    final result = await _remote.fetchCustomers(
      page: 1,
      perPage: last.perPage,
      filterType: last.filterType,
      status: last.status,
    );

    result.fold(
      (err) => emit(CustomerState.error(err)),
      (res) {
        _lastPage = res.lastPage;
        emit(CustomerState.loaded(
          data: res.customers,
          page: 1,
          perPage: last.perPage,
          filterType: last.filterType,
          status: last.status,
        ));
      },
    );
  }

  Future<void> _onChangeFilter(
      _ChangeFilter event, Emitter<CustomerState> emit) async {
    add(CustomerEvent.getCustomers(
      page: 1,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
    ));
  }

  /// Dipanggil dari UI saat scroll ke bawah
  void loadNextPage() {
    final current = state.maybeWhen(
      loaded: (data, page, perPage, filterType, status) => (
        page: page,
        perPage: perPage,
        filterType: filterType,
        status: status,
      ),
      orElse: () => null,
    );
    if (current == null || _isLoadingMore || hasReachedMax) return;

    add(CustomerEvent.getCustomers(
      page: current.page + 1,
      perPage: current.perPage,
      filterType: current.filterType,
      status: current.status,
    ));
  }
}
