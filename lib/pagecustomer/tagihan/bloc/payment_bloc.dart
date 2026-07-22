import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pagecustomer/tagihan/datasource/payment_datasource.dart';
import 'package:yofa/pagecustomer/tagihan/model/payment_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';
part 'payment_bloc.freezed.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentDatasource _datasource;

  PaymentBloc(this._datasource) : super(const PaymentState.initial()) {
    on<_Load>(_onLoad);
    on<_Upload>(_onUpload);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.initial());
  }

  Future<void> _onUpload(
    _Upload event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.loading());

    try {
      final result = await _datasource.uploadPaymentProof(
        id: event.tagihanId,
        file: event.file,
      );

      emit(PaymentState.loaded(result));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      emit(PaymentState.error(msg));
    }
  }
}
