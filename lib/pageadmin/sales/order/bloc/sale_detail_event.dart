part of 'sale_detail_bloc.dart';

@freezed
class SaleDetailEvent with _$SaleDetailEvent {
  const factory SaleDetailEvent.started() = _Started;
  const factory SaleDetailEvent.get({required int id}) = _Get;
  const factory SaleDetailEvent.reset() = _Reset;
}