import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pageadmin/sales/getproducts/model/customer_product_price_model.dart';
import 'package:yofa/pagecustomer/product/datasource/productuser_ds.dart';

part 'productuser_event.dart';
part 'productuser_state.dart';
part 'productuser_bloc.freezed.dart';


class ProductUserBloc
    extends Bloc<ProductUserEvent, ProductUserState> {
  final ProductUserDatasource _remote;

  ProductUserBloc(this._remote)
      : super(const ProductUserState.initial()) {
    on<_GetProductByUser>(_onGetProductByUser);
    on<_Refresh>(_onRefresh);
    on<_Clear>(_onClear);
  }

  Future<void> _onGetProductByUser(
    _GetProductByUser event,
    Emitter<ProductUserState> emit,
  ) async {
    emit(const ProductUserState.loading());

    final result = await _remote.getProductsByUser();

    result.fold(
      (err) => emit(ProductUserState.error(err)),
      (data) => emit(ProductUserState.loaded(
        data: data,
      )),
    );
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<ProductUserState> emit,
  ) async {
    final data = state.maybeWhen(
      loaded: (data) => data,
      loading: () => null,
      initial: () => null,
      error: (_) => null, orElse: () {  },
    );


    final result = await _remote.getProductsByUser();

    result.fold(
      (err) => emit(ProductUserState.error(err)),
      (data) => emit(ProductUserState.loaded(
        data: data,
      )),
    );
  }

  void _onClear(_Clear event, Emitter<ProductUserState> emit) {
    emit(const ProductUserState.initial());
  }
}
