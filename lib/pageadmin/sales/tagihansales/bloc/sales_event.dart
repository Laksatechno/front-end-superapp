part of 'sales_bloc.dart';

@freezed
class SalesEvent with _$SalesEvent {
  const factory SalesEvent.getSales({
    @Default(1) int page,
    String? search,
    int? year,
    String? paymentStatus,
    String? taxStatus,
  }) = _GetSales;

  const factory SalesEvent.refresh({
    String? search,
    int? year,
    String? paymentStatus,
    String? taxStatus,
  }) = _Refresh;

  const factory SalesEvent.loadMore() = _LoadMore;

  const factory SalesEvent.applyFilter({
    String? search,
    int? year,
    String? paymentStatus,
    String? taxStatus,
  }) = _ApplyFilter;

  const factory SalesEvent.clearFilter() = _ClearFilter;
}