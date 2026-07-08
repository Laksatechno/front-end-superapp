part of 'sale_detail_bloc.dart';

@freezed
class SaleDetailState with _$SaleDetailState {
  const factory SaleDetailState.initial() = _Initial;
  const factory SaleDetailState.loading() = _Loading;
  const factory SaleDetailState.loaded({required Sale sale}) = _Loaded;
  const factory SaleDetailState.error({required String message}) = _Error;
}