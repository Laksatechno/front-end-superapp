// lib/pagecustomer/brosur/bloc/brosur_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../datasource/brosur_datasource.dart';
import '../model/brosur_model.dart';



part 'brosur_event.dart';
part 'brosur_state.dart';
part 'brosur_bloc.freezed.dart';


class BrosurBloc extends Bloc<BrosurEvent, BrosurState> {
  final BrosurDatasource datasource;

  BrosurBloc({required this.datasource}) : super(const BrosurState.initial()) {
    on<_Fetch>(_onFetch);
    on<_Download>(_onDownload);
  }

  Future<void> _onFetch(_Fetch event, Emitter<BrosurState> emit) async {
    emit(const BrosurState.loading());
    try {
      final brosur = await datasource.getBrosur(search: event.search);
      emit(BrosurState.loaded(brosur: brosur));
    } catch (e) {
      emit(BrosurState.error(message: e.toString()));
    }
  }

  Future<void> _onDownload(_Download event, Emitter<BrosurState> emit) async {
    // Ambil list brosur yang ada
    final currentBrosur = state.maybeWhen(
      loaded: (brosur, _) => brosur,
      orElse: () => <Brosur>[],
    );

    // Set downloading state
    emit(BrosurState.loaded(brosur: currentBrosur, downloadingId: event.id));

    try {
      final filePath = await datasource.downloadBrosur(event.id, event.fileName);
      emit(BrosurState.downloadSuccess(filePath: filePath, brosur: currentBrosur));
    } catch (e) {
      emit(BrosurState.error(message: e.toString(), brosur: currentBrosur));
    }
  }
}