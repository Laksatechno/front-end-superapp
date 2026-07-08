part of 'productuser_bloc.dart';

@freezed
class ProductUserEvent with _$ProductUserEvent {
  const factory ProductUserEvent.getProductsByUser() = _GetProductByUser;

  const factory ProductUserEvent.refresh() = _Refresh;

  const factory ProductUserEvent.clear() = _Clear;
}