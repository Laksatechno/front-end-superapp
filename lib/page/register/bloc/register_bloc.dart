import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/datasources/auth/auth_remote_datasource.dart';
import 'package:yofa/page/register/model/resgister_model.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource _remote;

  RegisterBloc(this._remote) : super(const RegisterState.initial()) {
    on<_Register>(_onRegister);
  }

  Future<void> _onRegister(
    _Register event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterState.loading());

    final result = await _remote.register(
      name: event.name,
      email: event.email,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
      noHp: event.noHp,
      alamat: event.alamat,
      tipePelanggan: event.tipePelanggan,
      jenisInstitusi: event.jenisInstitusi,
      marketingId: event.marketingId,
    );

    result.fold(
      (error) => emit(RegisterState.error(error)),
      (data) => emit(RegisterState.success(data)),
    );
  }
}