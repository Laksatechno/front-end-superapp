import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:yofa/pageadmin/karyawanku/kelolapresensi/datasource/kelola_presensi_ds.dart';
import 'package:yofa/pageadmin/karyawanku/kelolapresensi/models/presensi_model.dart';

part 'presensi_admin_event.dart';
part 'presensi_admin_state.dart';
part 'presensi_admin_bloc.freezed.dart';

class HistoryPresensiAdminBloc
    extends Bloc<HistoryBulananPresensiAdminEvent, HistoryBulananPresensiAdminState> {
  final KelolaPresensiRemoteDatasource _remote;

  HistoryPresensiAdminBloc(this._remote)
      : super(const HistoryBulananPresensiAdminState.initial()) {
    on<_Started>((event, emit) {
      add(const HistoryBulananPresensiAdminEvent.getPresensi());
    });

    on<_GetPresensi>(_onGet);
    on<_Refresh>(_onRefresh);
    on<_Update>(_onUpdate);
  }

  Future<void> _onGet(_GetPresensi event, Emitter<HistoryBulananPresensiAdminState> emit) async {
    emit(const HistoryBulananPresensiAdminState.loading());

    final result = await _remote.fetchRiwayatPresensi(
      filterType: event.filterType,
      dateRange: event.dateRange,
      status: event.status,
    );

    result.fold(
      (err) => emit(HistoryBulananPresensiAdminState.error(err)),
      (res) {
        final list = res.data ?? <HistoryBulananPresensi>[];
        if (list.isEmpty) {
          emit(const HistoryBulananPresensiAdminState.empty());
        } else {
          emit(HistoryBulananPresensiAdminState.loaded(list));
        }
      },
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<HistoryBulananPresensiAdminState> emit) async {
    final result = await _remote.fetchRiwayatPresensi(
      filterType: event.filterType,
      dateRange: event.dateRange,
      status: event.status,
    );

    result.fold(
      (err) => emit(HistoryBulananPresensiAdminState.error(err)),
      (res) {
        final list = res.data ?? <HistoryBulananPresensi>[];
        if (list.isEmpty) {
          emit(const HistoryBulananPresensiAdminState.empty());
        } else {
          emit(HistoryBulananPresensiAdminState.loaded(list));
        }
      },
    );
  }

  Future<void> _onUpdate(_Update event, Emitter<HistoryBulananPresensiAdminState> emit) async {
    emit(const HistoryBulananPresensiAdminState.success('Update belum dihubungkan endpoint'));
  }
}
