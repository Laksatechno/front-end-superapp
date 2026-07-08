part of 'customer_products_bloc.dart';

@freezed
class CustomerProductsState with _$CustomerProductsState {
  const factory CustomerProductsState.initial() = _Initial;
  const factory CustomerProductsState.loading() = _Loading;

  const factory CustomerProductsState.loaded({
    required int customerId,
    required List<CustomerProductPrice> data,
  }) = _Loaded;

  const factory CustomerProductsState.error(String message) = _Error;
}