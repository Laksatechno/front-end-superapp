import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pagecustomer/history/datasource/history_order_ds.dart';
import 'package:yofa/pagecustomer/history/model/history_order_model.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';
part 'history_order_bloc.freezed.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final HistoryOrderDataSource _remote;

  HistoryOrderBloc(this._remote) : super(const HistoryOrderState.initial()) {
    on<_GetOrders>(_onGetOrders);
    on<_Refresh>(_onRefresh);
    on<_LoadMore>(_onLoadMore);
    on<_ApplyFilter>(_onApplyFilter);
  }

  Future<void> _onGetOrders(
    _GetOrders event,
    Emitter<HistoryOrderState> emit,
  ) async {
    emit(const HistoryOrderState.loading());

    try {
      final orders = await _remote.fetchOrders(
        search: event.search,
        status: event.status,
        page: event.page,
        perPage: event.perPage,
      );

      if (orders.isEmpty) {
        emit(const HistoryOrderState.error('Data pesanan tidak ditemukan'));
      } else {
        emit(HistoryOrderState.loaded(
          items: orders,
          page: event.page,
          lastPage: orders.length < event.perPage ? event.page : event.page + 1,
          search: event.search,
          status: event.status,
        ));
      }
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      emit(HistoryOrderState.error(msg));
    }
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<HistoryOrderState> emit,
  ) async {
    final current = state.maybeWhen(
      loaded: (items, page, lastPage, search, status, isLoadingMore) => (
        search: search,
        status: status,
      ),
      orElse: () => (search: event.search, status: event.status),
    );

    add(HistoryOrderEvent.getOrders(
      page: 1,
      search: current.search,
      status: current.status,
      perPage: 10,
    ));
  }

  Future<void> _onLoadMore(
    _LoadMore event,
    Emitter<HistoryOrderState> emit,
  ) async {
    final s = state;
    if (s is! _Loaded) return;
    if (s.isLoadingMore) return;
    if (s.page >= s.lastPage) return;

    emit(s.copyWith(isLoadingMore: true));

    try {
      final nextPage = s.page + 1;
      final orders = await _remote.fetchOrders(
        search: s.search,
        status: s.status,
        page: nextPage,
        perPage: 10,
      );

      emit(s.copyWith(
        items: [...s.items, ...orders],
        page: nextPage,
        lastPage: orders.length < 10 ? nextPage : nextPage + 1,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(HistoryOrderState.error(e.toString()));
    }
  }

  Future<void> _onApplyFilter(
    _ApplyFilter event,
    Emitter<HistoryOrderState> emit,
  ) async {
    add(HistoryOrderEvent.getOrders(
      page: 1,
      search: event.search,
      status: event.status,
      perPage: 10,
    ));
  }
}