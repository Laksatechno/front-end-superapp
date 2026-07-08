import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../datasource/marketing_ds.dart';
import '../model/marketing_models.dart';

part 'marketing_event.dart';
part 'marketing_state.dart';
part 'marketing_bloc.freezed.dart';

class MarketingBloc extends Bloc<MarketingEvent, MarketingState> {
  final MarketingDataSource _remote;

  MarketingBloc(this._remote) : super(const MarketingState.initial()) {
    on<_GetMarketing>(_onGetMarketing);
    on<_Refresh>(_onRefresh);
    on<_Clear>(_onClear);
  }

  Future<void> _onGetMarketing(_GetMarketing event, Emitter<MarketingState> emit) async {
    emit(const MarketingState.loading());

    final res = await _remote.fetchMarketingUsers();
    res.fold(
      (err) => emit(MarketingState.error(err)),
      (data) => emit(MarketingState.loaded(data)),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<MarketingState> emit) async {
    final res = await _remote.fetchMarketingUsers();
    res.fold(
      (err) => emit(MarketingState.error(err)),
      (data) => emit(MarketingState.loaded(data)),
    );
  }

  void _onClear(_Clear event, Emitter<MarketingState> emit) {
    emit(const MarketingState.initial());
  }
}