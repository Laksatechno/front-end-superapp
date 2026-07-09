part of 'history_order_bloc.dart';

@freezed
class HistoryOrderEvent with _$HistoryOrderEvent {
  const factory HistoryOrderEvent.getOrders({
    @Default(1) int page,
    String? search,
    String? status,
    @Default(10) int perPage,
  }) = _GetOrders;

  const factory HistoryOrderEvent.refresh({
    String? search,
    String? status,
  }) = _Refresh;

  const factory HistoryOrderEvent.loadMore() = _LoadMore;

  const factory HistoryOrderEvent.applyFilter({
    String? search,
    String? status,
  }) = _ApplyFilter;
}