part of 'kelola_kunjungan_bloc.dart';

@freezed
class KelolaKunjunganEvent with _$KelolaKunjunganEvent {
  const factory KelolaKunjunganEvent.started() = _Started;

  const factory KelolaKunjunganEvent.getKunjungan({
    String? filterType,
    DateTimeRange? dateRange,
    String? status,
  }) = _GetKunjungan;

  const factory KelolaKunjunganEvent.refresh({
    String? filterType,
    DateTimeRange? dateRange,
    String? status,
  }) = _Refresh;
}
