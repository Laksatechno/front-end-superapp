part of 'register_bloc.dart';

@freezed
abstract class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.register({
    required String namaInstansi,
    required String namaPic,
    required String nomorPic,
    required String alamat,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) = _Register;
}
