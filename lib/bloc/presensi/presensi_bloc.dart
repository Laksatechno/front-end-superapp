import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/models/response/add_presensi_response.dart';
import 'package:yofa/datasources/presensi/presensi_datasource.dart';

part 'presensi_bloc.freezed.dart';
part 'presensi_event.dart';
part 'presensi_state.dart';

class PresensiBloc extends Bloc<PresensiEvent, PresensiState> {
  final PresensiDatasource datasource;

  PresensiBloc(this.datasource) : super(const PresensiState.initial()) {
    on<_Started>((event, emit) {
      emit(const PresensiState.initial());
    });

    on<_AddPresensi>((event, emit) async {
      emit(const PresensiState.loading());

      final requestModel = CheckinCheckOutRequest(
        latitude: event.latitude,
        longitude: event.longitude,
        pictureBase64: event.base64Image,
      );

      final result = await datasource.addPresensi(requestModel);

      result.fold(
        (failure) => emit(PresensiState.error(failure)),
        (success) => emit(PresensiState.loaded(success)),
      );
    });
  }
}
