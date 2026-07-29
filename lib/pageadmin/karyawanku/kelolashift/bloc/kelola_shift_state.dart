part of 'kelola_shift_bloc.dart';

abstract class KelolaShiftState {}

class KelolaShiftInitial extends KelolaShiftState {}

class KelolaShiftLoading extends KelolaShiftState {}

class KelolaShiftLoaded extends KelolaShiftState {
  final List<dynamic> data;
  KelolaShiftLoaded(this.data);
}

class KelolaShiftError extends KelolaShiftState {
  final String message;
  KelolaShiftError(this.message);
}
