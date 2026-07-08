part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;

  const factory ProductState.loaded({
    required ProductPageResponse data,
    @Default(1) int page,
    @Default(10) int perPage,
    String? search,

    Product? selected,
  }) = _Loaded;

  const factory ProductState.error(String message) = _Error;

  const factory ProductState.success(String message) = _Success;
  const factory ProductState.batchCreated(String message) = _BatchCreated;

  
}