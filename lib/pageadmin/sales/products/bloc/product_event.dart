part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;

  const factory ProductEvent.getProducts({
    @Default(1) int page,
    @Default(10) int perPage,
    String? search,
  }) = _GetProducts;

  const factory ProductEvent.refresh({
    @Default(1) int page,
    @Default(10) int perPage,
    String? search,
  }) = _RefreshProducts;

  const factory ProductEvent.changeSearch({
    @Default(10) int perPage,
    String? search,
  }) = _ChangeSearch;

  const factory ProductEvent.getProductDetail({
    required int id,
  }) = _GetProductDetail;

  const factory ProductEvent.addProduct({
    required CreateProductRequest request,
  }) = _AddProduct;

  const factory ProductEvent.createBatch({
    required CreateBatchRequest request,
  }) = _CreateBatch;
}