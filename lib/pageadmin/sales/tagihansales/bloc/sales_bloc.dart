import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../datasource/sales_ds.dart';
import '../model/sales_models.dart';

part 'sales_event.dart';
part 'sales_state.dart';
part 'sales_bloc.freezed.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SalesDataSource _remote;

  SalesBloc(this._remote) : super(const SalesState.initial()) {
    on<_GetSales>(_onGetSales);
    on<_Refresh>(_onRefresh);
    on<_LoadMore>(_onLoadMore);
    on<_ApplyFilter>(_onApplyFilter);
    on<_ClearFilter>(_onClearFilter);
  }

  Future<void> _onGetSales(_GetSales event, Emitter<SalesState> emit) async {
    emit(const SalesState.loading());

    final res = await _remote.fetchSales(
      page: event.page,
      search: event.search,
      year: event.year,
      paymentStatus: event.paymentStatus,
      taxStatus: event.taxStatus,
    );

    res.fold(
      (err) => emit(SalesState.error(err)),
      (r) => emit(SalesState.loaded(
        items: r.data.data,
        page: r.data.currentPage,
        lastPage: r.data.lastPage ?? r.data.currentPage,
        search: event.search,
        year: event.year,
        paymentStatus: event.paymentStatus,
        taxStatus: event.taxStatus,
      )),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<SalesState> emit) async {
    final current = state.maybeWhen(
      loaded: (items, page, lastPage, search, year, paymentStatus, taxStatus, isLoadingMore) => (
        search: search,
        year: year,
        paymentStatus: paymentStatus,
        taxStatus: taxStatus,
      ),
      orElse: () => (search: event.search, year: event.year, paymentStatus: event.paymentStatus, taxStatus: event.taxStatus),
    );

    add(SalesEvent.getSales(
      page: 1,
      search: current.search,
      year: current.year,
      paymentStatus: current.paymentStatus,
      taxStatus: current.taxStatus,
    ));
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<SalesState> emit) async {
    final s = state;
    if (s is! _Loaded) return;
    if (s.isLoadingMore) return;
    if (s.page >= s.lastPage) return;

    emit(s.copyWith(isLoadingMore: true));

    final nextPage = s.page + 1;
    final res = await _remote.fetchSales(
      page: nextPage,
      search: s.search,
      year: s.year,
      paymentStatus: s.paymentStatus,
      taxStatus: s.taxStatus,
    );

    res.fold(
      (err) => emit(SalesState.error(err)),
      (r) => emit(s.copyWith(
        items: [...s.items, ...r.data.data],
        page: r.data.currentPage,
        lastPage: r.data.lastPage ?? r.data.currentPage,
        isLoadingMore: false,
      )),
    );
  }

  Future<void> _onApplyFilter(_ApplyFilter event, Emitter<SalesState> emit) async {
    add(SalesEvent.getSales(
      page: 1,
      search: event.search,
      year: event.year,
      paymentStatus: event.paymentStatus,
      taxStatus: event.taxStatus,
    ));
  }

  Future<void> _onClearFilter(_ClearFilter event, Emitter<SalesState> emit) async {
    add(const SalesEvent.getSales(page: 1));
  }
}