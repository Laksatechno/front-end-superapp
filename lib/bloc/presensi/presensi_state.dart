part of 'presensi_bloc.dart';

@freezed
class PresensiState with _$PresensiState {
  const factory PresensiState.initial() = _Initial;
  const factory PresensiState.loading() = _Loading;
  const factory PresensiState.loaded(AddPresensiResponseModel responseModel) = _Loaded;
  const factory PresensiState.error(String message) = _Error;
}
