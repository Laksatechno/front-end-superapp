import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pageadmin/sales/order/datasource/save_sale_ds.dart';

import 'package:yofa/pageadmin/sales/tagihansales/model/sales_models.dart';

part 'sale_detail_bloc.freezed.dart';
part 'sale_detail_event.dart';
part 'sale_detail_state.dart';

class SaleDetailBloc extends Bloc<SaleDetailEvent, SaleDetailState> {
  final SaveSaleDataSource ds;

  SaleDetailBloc({required this.ds}) : super(const SaleDetailState.initial()) {
    on<_Get>(_onGet);
    on<_Reset>((event, emit) => emit(const SaleDetailState.initial()));
  }

  Future<void> _onGet(_Get event, Emitter<SaleDetailState> emit) async {
    emit(const SaleDetailState.loading());

    final res = await ds.fetchSaleDetail(id: event.id);
    res.fold(
      (err) => emit(SaleDetailState.error(message: err)),
      (sale) => emit(SaleDetailState.loaded(sale: sale)),
    );
  }
}