import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../datasource/save_sale_ds.dart';
import '../model/save_sale_models.dart';

part 'save_sale_event.dart';
part 'save_sale_state.dart';
part 'save_sale_bloc.freezed.dart';

class SaveSaleBloc extends Bloc<SaveSaleEvent, SaveSaleState> {
  final SaveSaleDataSource _remote;

  SaveSaleBloc(this._remote) : super(const SaveSaleState.initial()) {
    on<_Submit>(_onSubmit);
    on<_Reset>(_onReset);
    on<_UpdateSale>(_onUpdateSale);
  }

  Future<void> _onSubmit(_Submit event, Emitter<SaveSaleState> emit) async {
    emit(const SaveSaleState.loading());

    final result = await _remote.saveSale(event.request);

    result.fold(
      (err) => emit(SaveSaleState.error(err)),
      (res) => emit(SaveSaleState.success(res)),
    );
  }

  Future<void> _onUpdateSale(_UpdateSale event, Emitter<SaveSaleState> emit) async {
    emit(const SaveSaleState.loading());

    final res = await _remote.updateSale(
      saleId: event.saleId,
      request: event.request,
      tanggal: event.tanggal,
    );

    res.fold(
      (err) => emit(SaveSaleState.error(err)),
      (res) => emit(SaveSaleState.success(res)),
    );
  }

  void _onReset(_Reset event, Emitter<SaveSaleState> emit) {
    emit(const SaveSaleState.initial());
  }
}