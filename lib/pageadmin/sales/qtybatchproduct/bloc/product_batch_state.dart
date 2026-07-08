part of 'product_batch_bloc.dart';

@freezed
class ProductBatchState with _$ProductBatchState {
  const factory ProductBatchState.initial() = _Initial;
  const factory ProductBatchState.loading() = _Loading;

  const factory ProductBatchState.loaded({
    required int productId,
    required ProductLite product,
    required List<ProductBatch> batches,
  }) = _Loaded;

  const factory ProductBatchState.error(String message) = _Error;
}