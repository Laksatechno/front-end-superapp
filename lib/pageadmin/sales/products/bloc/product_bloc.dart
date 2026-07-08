import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:yofa/pageadmin/sales/products/datasource/product_ds.dart';
import 'package:yofa/pageadmin/sales/products/model/products_model.dart';
import 'package:yofa/pageadmin/sales/products/model/product_page_response.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _remote;

  ProductBloc(this._remote) : super(const ProductState.initial()) {
    on<_GetProducts>(_onGetProducts);
    on<_RefreshProducts>(_onRefreshProducts);
    on<_ChangeSearch>(_onChangeSearch);
    on<_GetProductDetail>(_onGetProductDetail);
    on<_AddProduct>(_onAddProduct);
    on<_CreateBatch>(_onCreateBatch);
  }

  Future<void> _onGetProducts(_GetProducts event, Emitter<ProductState> emit) async {
    emit(const ProductState.loading());

    final result = await _remote.fetchProducts(
      page: event.page,
      perPage: event.perPage,
      search: event.search,
    );

    result.fold(
      (err) => emit(ProductState.error(err)),
      (res) => emit(ProductState.loaded(
        data: res,
        page: event.page,
        perPage: event.perPage,
        search: event.search,
        selected: null,
      )),
    );
  }

  Future<void> _onRefreshProducts(_RefreshProducts event, Emitter<ProductState> emit) async {
    final current = state;

    //  refresh pakai parameter terakhir (kalau state loaded)
    final last = current.maybeWhen(
      loaded: (data, page, perPage, search, selected) => (
        page: page,
        perPage: perPage,
        search: search,
        selected: selected,
      ),
      orElse: () => (
        page: event.page,
        perPage: event.perPage,
        search: event.search,
        selected: null,
      ),
    );

    final result = await _remote.fetchProducts(
      page: last.page,
      perPage: last.perPage,
      search: last.search,
    );

    result.fold(
      (err) => emit(ProductState.error(err)),
      (res) => emit(ProductState.loaded(
        data: res,
        page: last.page,
        perPage: last.perPage,
        search: last.search,
        selected: last.selected, // ✅ keep selected kalau ada
      )),
    );
  }

  Future<void> _onChangeSearch(_ChangeSearch event, Emitter<ProductState> emit) async {
    // ✅ saat search berubah, load ulang dari page 1
    add(ProductEvent.getProducts(
      page: 1,
      perPage: event.perPage,
      search: event.search,
    ));
  }

  Future<void> _onGetProductDetail(_GetProductDetail event, Emitter<ProductState> emit) async {
    final prev = state;

    // ✅ keep list agar UI list tidak blank
    emit(prev.maybeWhen(
      loaded: (data, page, perPage, search, selected) => ProductState.loaded(
        data: data,
        page: page,
        perPage: perPage,
        search: search,
        selected: selected,
      ),
      orElse: () => const ProductState.loading(),
    ));

    final result = await _remote.fetchProductDetail(id: event.id);

    result.fold(
      (err) => emit(ProductState.error(err)),
      (product) {
        emit(prev.maybeWhen(
          loaded: (data, page, perPage, search, _) => ProductState.loaded(
            data: data,
            page: page,
            perPage: perPage,
            search: search,
            selected: product,
          ),
          orElse: () => ProductState.loaded(
            // fallback kosong (kalau masuk detail dari luar list)
            data: ProductPageResponse(
              currentPage: 1,
              items: const [],
              lastPage: 1,
              perPage: 10,
              total: 0,
            ),
            selected: product,
          ),
        ));
      },
    );
  }

  Future<void> _onAddProduct(
    _AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());

    final result = await _remote.addProduct(request: event.request);

    result.fold(
      (err) => emit(ProductState.error(err)),
      (res) => emit(ProductState.success(res.toString())),
    );
  }

  Future<void> _onCreateBatch(
    _CreateBatch event,
    Emitter<ProductState> emit,
  ) async {
    final prev = state;

    final result = await _remote.createBatch(request: event.request);

    await result.fold(
      (err) async {
        emit(ProductState.error(err));
      },
      (msg) async {

        // ambil ulang detail product
        final detail = await _remote.fetchProductDetail(id: event.request.productId);

        detail.fold(
          (err) => emit(ProductState.error(err)),
          (product) {
            emit(ProductState.batchCreated(msg));
            emit(prev.maybeWhen(
              loaded: (data, page, perPage, search, _) => ProductState.loaded(
                data: data,
                page: page,
                perPage: perPage,
                search: search,
                selected: product,
              ),
              orElse: () => ProductState.loaded(
                data: ProductPageResponse(
                  currentPage: 1,
                  items: const [],
                  lastPage: 1,
                  perPage: 10,
                  total: 0,
                ),
                selected: product,
              ),
            ));
          },
        );
      },
    );
  }
}