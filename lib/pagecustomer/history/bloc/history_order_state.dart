part of 'history_order_bloc.dart';

@freezed
class HistoryOrderState with _$HistoryOrderState {
  const factory HistoryOrderState.initial() = _Initial;
  const factory HistoryOrderState.loading() = _Loading;

  const factory HistoryOrderState.loaded({
    required List<CustomerOrderHistory> items,
    required int page,
    required int lastPage,
    String? search,
    String? status,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;

  const factory HistoryOrderState.error(String message) = _Error;
}