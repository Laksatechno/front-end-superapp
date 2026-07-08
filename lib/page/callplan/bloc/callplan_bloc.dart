import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/page/callplan/datasource/callplan_datasource.dart';
import 'package:yofa/page/callplan/model/callplan_models.dart';

part 'callplan_event.dart';
part 'callplan_state.dart';
part 'callplan_bloc.freezed.dart';

class CallplanBloc extends Bloc<CallplanEvent, CallplanState> {
  final CallplanRemoteDatasource datasource;

  CallplanBloc(this.datasource) : super(const CallplanState.initial()) {
    on<_FetchCallplan>(_onFetch);
    on<_RefreshCallplan>(_onRefresh);
    on<_CreateCallplan>(_onCreate);
    on<_UpdateCallplan>(_onUpdate);
    on<_DeleteCallplan>(_onDelete);
  }

  Future<void> _onFetch(
    _FetchCallplan event,
    Emitter<CallplanState> emit,
  ) async {
    emit(const CallplanState.loading());

    final result = await datasource.fetchCallplan(
      filterType: event.filterType,
      dateRange: event.dateRange,
    );

    result.fold(
      (error) => emit(CallplanState.error(error)),
      (data) => emit(CallplanState.loaded(data)),
    );
  }

  Future<void> _onRefresh(
    _RefreshCallplan event,
    Emitter<CallplanState> emit,
  ) async {
    final result = await datasource.fetchCallplan();

    result.fold(
      (error) => emit(CallplanState.error(error)),
      (data) => emit(CallplanState.loaded(data)),
    );
  }

  Future<void> _onCreate(
    _CreateCallplan event,
    Emitter<CallplanState> emit,
  ) async {
    emit(const CallplanState.loading());

    final result = await datasource.createCallplan(
      tanggalCp: event.tanggalCp,
      outlet: event.outlet,
      description: event.description,
    );

    result.fold(
      (error) => emit(CallplanState.error(error)),
      (msg) => emit(CallplanState.success(msg)),
    );
  }

  Future<void> _onUpdate(
    _UpdateCallplan event,
    Emitter<CallplanState> emit,
  ) async {
    emit(const CallplanState.loading());

    final result = await datasource.updateCallplan(
      id: event.id,
      tanggalCp: event.tanggalCp,
      outlet: event.outlet,
      description: event.description,
    );

    result.fold(
      (error) => emit(CallplanState.error(error)),
      (msg) => emit(CallplanState.success(msg)),
    );
  }

  Future<void> _onDelete(
    _DeleteCallplan event,
    Emitter<CallplanState> emit,
  ) async {
    emit(const CallplanState.loading());

    final result = await datasource.deleteCallplan(id: event.id);

    result.fold(
      (error) => emit(CallplanState.error(error)),
      (msg) => emit(CallplanState.success(msg)),
    );
  }
}
