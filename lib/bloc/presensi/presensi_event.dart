part of 'presensi_bloc.dart';

@freezed
class PresensiEvent with _$PresensiEvent {
  const factory PresensiEvent.started() = _Started;

  const factory PresensiEvent.addPresensi(
    String latitude,
    String longitude,
    String base64Image,
  ) = _AddPresensi;
}
