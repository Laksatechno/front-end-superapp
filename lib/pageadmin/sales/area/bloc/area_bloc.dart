import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/pageadmin/sales/area/datasource/area_ds.dart';

part 'area_event.dart';
part 'area_state.dart';
part 'area_bloc.freezed.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  final AreaRemoteDatasource datasource =
      AreaRemoteDatasource(http.Client());

  AreaBloc() : super(const AreaState.initial()) {
    on<AreaEventStarted>(_onStarted);
    on<AreaEventGetAreas>(_onGetAreas);
    on<AreaEventRefresh>(_onRefresh);
  }

  Future<void> _onStarted(
    AreaEventStarted event,
    Emitter<AreaState> emit,
  ) async {
    add(const AreaEvent.getAreas());
  }

  Future<void> _onGetAreas(
    AreaEventGetAreas event,
    Emitter<AreaState> emit,
  ) async {
    emit(const AreaState.loading());

    final result = await datasource.fetchArea();

    result.fold(
    (error) {
      print("AREA ERROR: $error");
      emit(AreaState.failure(error));
    },
    (data) {
      print("AREA DATA: ${data.length}");
      emit(AreaState.success(areas: data));
    },
  );
  }

  Future<void> _onRefresh(
    AreaEventRefresh event,
    Emitter<AreaState> emit,
  ) async {
    add(const AreaEvent.getAreas());
  }
}