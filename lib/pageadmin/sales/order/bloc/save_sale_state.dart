part of 'save_sale_bloc.dart';

@freezed
class SaveSaleState with _$SaveSaleState {
  const factory SaveSaleState.initial() = _Initial;
  const factory SaveSaleState.loading() = _Loading;
  const factory SaveSaleState.success(SaveSaleResult result) = _Success;
  const factory SaveSaleState.error(String message) = _Error;
}