part of 'kelola_kunjungan_bloc.dart';

@freezed
class KelolaKunjunganState with _$KelolaKunjunganState {
  const factory KelolaKunjunganState.initial() = _Initial;
  const factory KelolaKunjunganState.loading() = _Loading;

  const factory KelolaKunjunganState.loaded(
    List<KunjunganData> items,
  ) = _Loaded;

  const factory KelolaKunjunganState.empty() = _Empty;
  const factory KelolaKunjunganState.error(String message) = _Error;
}
