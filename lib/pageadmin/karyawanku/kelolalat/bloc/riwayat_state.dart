part of 'riwayat_bloc.dart';

@freezed
abstract class RiwayatState with _$RiwayatState {
  const factory RiwayatState.initial() = _Initial;
  const factory RiwayatState.loading() = _Loading;

  const factory RiwayatState.loaded({
    required List<MaintenanceModel> data,
    String? from,
    String? to,
    String? search,
  }) = _Loaded;

  const factory RiwayatState.error(String message) = _Error;
  const factory RiwayatState.success(String message) = _Success;
}