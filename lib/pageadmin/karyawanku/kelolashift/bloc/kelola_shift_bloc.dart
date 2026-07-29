import 'package:flutter_bloc/flutter_bloc.dart';

part 'kelola_shift_event.dart';
part 'kelola_shift_state.dart';

class KelolaShiftBloc extends Bloc<KelolaShiftEvent, KelolaShiftState> {
  KelolaShiftBloc() : super(KelolaShiftInitial()) {
    on<LoadShiftEvent>((event, emit) async {
      emit(KelolaShiftLoading());
      // TODO: fetch data from datasource
    });
  }
}
