part of 'customer_products_bloc.dart';

@freezed
class CustomerProductsEvent with _$CustomerProductsEvent {
  const factory CustomerProductsEvent.getByCustomer({
    required int customerId,
  }) = _GetByCustomer;

  const factory CustomerProductsEvent.refresh({
    int? customerId,
  }) = _Refresh;

  const factory CustomerProductsEvent.clear() = _Clear;
}