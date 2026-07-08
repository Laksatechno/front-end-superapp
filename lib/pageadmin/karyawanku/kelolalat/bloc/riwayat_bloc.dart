import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/datasource/riwayat_ds.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/maintenance_model.dart';


part 'riwayat_bloc.freezed.dart';
part 'riwayat_event.dart';
part 'riwayat_state.dart';

class RiwayatBloc extends Bloc<RiwayatEvent, RiwayatState> {
  final RiwayatDataSource _remote;

  RiwayatBloc(this._remote) : super(const RiwayatState.initial()) {
    on<_GetRiwayats>(_onGetRiwayats);
    on<_RefreshRiwayats>(_onRefreshRiwayats);
    on<_ChangeFilter>(_onChangeFilter);
  }

  Future<void> _onGetRiwayats(
    _GetRiwayats event,
    Emitter<RiwayatState> emit,
  ) async {
    emit(const RiwayatState.loading());

    final result = await _remote.getRiwayat(
      from: event.from,
      to: event.to,
      search: event.search,
    );

    result.fold(
      (message) => emit(RiwayatState.error(message)),
      (data) => emit(
        RiwayatState.loaded(
          data: data,
          from: event.from,
          to: event.to,
          search: event.search,
        ),
      ),
    );
  }

  Future<void> _onRefreshRiwayats(
    _RefreshRiwayats event,
    Emitter<RiwayatState> emit,
  ) async {
    final result = await _remote.getRiwayat(
      from: event.from,
      to: event.to,
      search: event.search,
    );

    result.fold(
      (message) => emit(RiwayatState.error(message)),
      (data) => emit(
        RiwayatState.loaded(
          data: data,
          from: event.from,
          to: event.to,
          search: event.search,
        ),
      ),
    );
  }

  Future<void> _onChangeFilter(
    _ChangeFilter event,
    Emitter<RiwayatState> emit,
  ) async {
    emit(const RiwayatState.loading());

    final result = await _remote.getRiwayat(
      from: event.from,
      to: event.to,
      search: event.search,
    );

    result.fold(
      (message) => emit(RiwayatState.error(message)),
      (data) => emit(
        RiwayatState.loaded(
          data: data,
          from: event.from,
          to: event.to,
          search: event.search,
        ),
      ),
    );
  }
}