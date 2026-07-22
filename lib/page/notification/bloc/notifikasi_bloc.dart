import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/page/notification/bloc/notifikasi_event.dart';
import 'package:yofa/page/notification/bloc/notifikasi_state.dart';
import 'package:yofa/page/notification/datasource/notifikasi_datasource.dart';

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiState> {
  final NotifikasiDataSource _dataSource;

  NotifikasiBloc(this._dataSource) : super(const NotifikasiState.initial()) {
    on<NotifikasiEvent>((event, emit) async {
      await event.when(
        load: () => _onLoad(emit),
      );
    });
  }

  Future<void> _onLoad(Emitter<NotifikasiState> emit) async {
    emit(const NotifikasiState.loading());
    try {
      final data = await _dataSource.getNotifikasi();
      emit(NotifikasiState.loaded(data: data));
    } catch (e) {
      emit(NotifikasiState.error(message: e.toString()));
    }
  }
}
