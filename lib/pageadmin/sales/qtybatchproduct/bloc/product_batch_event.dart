part of 'product_batch_bloc.dart';

@freezed
class ProductBatchEvent with _$ProductBatchEvent {
  const factory ProductBatchEvent.getBatches({
    required int productId,
  }) = _GetBatches;

  const factory ProductBatchEvent.refresh({
    int? productId,
  }) = _Refresh;

  const factory ProductBatchEvent.clear() = _Clear;
}