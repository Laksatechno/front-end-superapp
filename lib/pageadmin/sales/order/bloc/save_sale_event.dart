part of 'save_sale_bloc.dart';

@freezed
class SaveSaleEvent with _$SaveSaleEvent {
  const factory SaveSaleEvent.submit(SaveSaleRequest request) = _Submit;
  const factory SaveSaleEvent.updateSale({
    required int saleId,
    required SaveSaleRequest request,
    required String tanggal,
  }) = _UpdateSale;
  const factory SaveSaleEvent.reset() = _Reset;
}