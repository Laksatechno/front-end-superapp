import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:yofa/pageadmin/karyawanku/kelolakunjungan/datasource/kelola_kunjungan_ds.dart';
import 'package:yofa/pageadmin/karyawanku/kelolakunjungan/models/kunjungan_model.dart';

part 'kelola_kunjungan_event.dart';
part 'kelola_kunjungan_state.dart';
part 'kelola_kunjungan_bloc.freezed.dart';

class KelolaKunjunganBloc
    extends Bloc<KelolaKunjunganEvent, KelolaKunjunganState> {
  final KelolaKunjunganRemoteDatasource _remote;

  KelolaKunjunganBloc(this._remote)
      : super(const KelolaKunjunganState.initial()) {
    on<_Started>((event, emit) {
      add(const KelolaKunjunganEvent.getKunjungan());
    });

    on<_GetKunjungan>(_onGet);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onGet(
      _GetKunjungan event, Emitter<KelolaKunjunganState> emit) async {
    emit(const KelolaKunjunganState.loading());

    final result = await _remote.fetchRiwayatKunjungan(
      filterType: event.filterType,
      dateRange: event.dateRange,
      status: event.status,
    );

    result.fold(
      (err) => emit(KelolaKunjunganState.error(err)),
      (res) {
        final list = res.data ?? <KunjunganData>[];
        if (list.isEmpty) {
          emit(const KelolaKunjunganState.empty());
        } else {
          emit(KelolaKunjunganState.loaded(list));
        }
      },
    );
  }

  Future<void> _onRefresh(
      _Refresh event, Emitter<KelolaKunjunganState> emit) async {
    final result = await _remote.fetchRiwayatKunjungan(
      filterType: event.filterType,
      dateRange: event.dateRange,
      status: event.status,
    );

    result.fold(
      (err) => emit(KelolaKunjunganState.error(err)),
      (res) {
        final list = res.data ?? <KunjunganData>[];
        if (list.isEmpty) {
          emit(const KelolaKunjunganState.empty());
        } else {
          emit(KelolaKunjunganState.loaded(list));
        }
      },
    );
  }
}
