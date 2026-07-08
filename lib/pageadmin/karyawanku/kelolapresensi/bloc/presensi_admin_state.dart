part of 'presensi_admin_bloc.dart';

@freezed
class HistoryBulananPresensiAdminState with _$HistoryBulananPresensiAdminState {
  const factory HistoryBulananPresensiAdminState.initial() = _Initial;
  const factory HistoryBulananPresensiAdminState.loading() = _Loading;

  const factory HistoryBulananPresensiAdminState.loaded(
    List<HistoryBulananPresensi> items,
  ) = _Loaded;

  const factory HistoryBulananPresensiAdminState.empty() = _Empty;
  const factory HistoryBulananPresensiAdminState.error(String message) = _Error;

  // untuk feedback action (update dll)
  const factory HistoryBulananPresensiAdminState.success(String message) = _Success;
}
