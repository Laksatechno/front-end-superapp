part of 'sales_bloc.dart';

@freezed
class SalesState with _$SalesState {
  const factory SalesState.initial() = _Initial;
  const factory SalesState.loading() = _Loading;

  const factory SalesState.loaded({
    required List<Sale> items,
    required int page,
    required int lastPage,
    String? search,
    int? year,
    String? paymentStatus,
    String? taxStatus,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;

  const factory SalesState.error(String message) = _Error;
}