part of 'presensi_admin_bloc.dart';

@freezed
class HistoryBulananPresensiAdminEvent with _$HistoryBulananPresensiAdminEvent {
  const factory HistoryBulananPresensiAdminEvent.started() = _Started;

  const factory HistoryBulananPresensiAdminEvent.getPresensi({
    String? filterType,
    DateTimeRange? dateRange,
    String? status,
  }) = _GetPresensi;

  const factory HistoryBulananPresensiAdminEvent.refresh({
    String? filterType,
    DateTimeRange? dateRange,
    String? status,
  }) = _Refresh;

  const factory HistoryBulananPresensiAdminEvent.updatePresensi(
    HistoryBulananPresensi riwayatPresensi,
  ) = _Update;
}
