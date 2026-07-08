part of 'register_bloc.dart';

@freezed
abstract class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String noHp,
    required String alamat,
    required String tipePelanggan,
    required String jenisInstitusi,
    required int marketingId,
  }) = _Register;
}