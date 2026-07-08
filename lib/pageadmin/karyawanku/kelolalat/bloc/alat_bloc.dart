import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/datasource/alat_datasource.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/maintenance_model.dart';

import '../model/alat_model.dart';


part 'alat_bloc.freezed.dart';
part 'alat_event.dart';
part 'alat_state.dart';

class AlatBloc extends Bloc<AlatEvent, AlatState> {
  final AlatDataSource _remote;

  AlatBloc(this._remote) : super(const AlatState.initial()) {
    on<_GetAlats>(_onGetAlats);
    on<_RefreshAlats>(_onRefreshAlats);
    on<_ChangeFilter>(_onChangeFilter);
  }

  Future<void> _onGetAlats(
    _GetAlats event,
    Emitter<AlatState> emit,
  ) async {
    emit(const AlatState.loading());

    final result = await _remote.getAlats(
      page: event.page,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
      search: event.search,
    );

    result.fold(
      (message) => emit(AlatState.error(message)),
      (data) => emit(
        AlatState.loaded(
          data: data,
          page: event.page,
          perPage: event.perPage,
          filterType: event.filterType,
          status: event.status,
          search: event.search,
        ),
      ),
    );
  }

  Future<void> _onRefreshAlats(
    _RefreshAlats event,
    Emitter<AlatState> emit,
  ) async {
    final result = await _remote.getAlats(
      page: event.page,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
      search: event.search,
    );

    result.fold(
      (message) => emit(AlatState.error(message)),
      (data) => emit(
        AlatState.loaded(
          data: data,
          page: event.page,
          perPage: event.perPage,
          filterType: event.filterType,
          status: event.status,
          search: event.search,
        ),
      ),
    );
  }

  Future<void> _onChangeFilter(
    _ChangeFilter event,
    Emitter<AlatState> emit,
  ) async {
    emit(const AlatState.loading());

    final result = await _remote.getAlats(
      page: 1,
      perPage: event.perPage,
      filterType: event.filterType,
      status: event.status,
      search: event.search,
    );

    result.fold(
      (message) => emit(AlatState.error(message)),
      (data) => emit(
        AlatState.loaded(
          data: data,
          page: 1,
          perPage: event.perPage,
          filterType: event.filterType,
          status: event.status,
          search: event.search,
        ),
      ),
    );
  }



}