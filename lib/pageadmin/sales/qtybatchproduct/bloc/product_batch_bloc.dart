import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../datasource/product_batch_ds.dart';
import '../model/product_batch_models.dart';

part 'product_batch_event.dart';
part 'product_batch_state.dart';
part 'product_batch_bloc.freezed.dart';

class ProductBatchBloc extends Bloc<ProductBatchEvent, ProductBatchState> {
  final ProductBatchDataSourc _remote;

  ProductBatchBloc(this._remote) : super(const ProductBatchState.initial()) {
    on<_GetBatches>(_onGetBatches);
    on<_Refresh>(_onRefresh);
    on<_Clear>(_onClear);
  }

  Future<void> _onGetBatches(_GetBatches event, Emitter<ProductBatchState> emit) async {
    emit(const ProductBatchState.loading());

    final result = await _remote.fetchProductBatches(productId: event.productId);

    result.fold(
      (err) => emit(ProductBatchState.error(err)),
      (res) => emit(ProductBatchState.loaded(
        productId: event.productId,
        product: res.product,
        batches: res.batches,
      )),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<ProductBatchState> emit) async {
    final lastProductId = state.maybeWhen(
      loaded: (productId, product, batches) => productId,
      orElse: () => null,
    );

    final id = event.productId ?? lastProductId;
    if (id == null) {
      emit(const ProductBatchState.error('Product ID belum dipilih'));
      return;
    }

    final result = await _remote.fetchProductBatches(productId: id);

    result.fold(
      (err) => emit(ProductBatchState.error(err)),
      (res) => emit(ProductBatchState.loaded(
        productId: id,
        product: res.product,
        batches: res.batches,
      )),
    );
  }

  void _onClear(_Clear event, Emitter<ProductBatchState> emit) {
    emit(const ProductBatchState.initial());
  }
}