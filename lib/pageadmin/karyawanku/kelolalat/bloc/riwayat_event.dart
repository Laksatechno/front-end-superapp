part of 'riwayat_bloc.dart';

@freezed
abstract class RiwayatEvent with _$RiwayatEvent {
  const factory RiwayatEvent.getRiwayats({
    String? from,
    String? to,
    String? search,
  }) = _GetRiwayats;

  const factory RiwayatEvent.refresh({
    String? from,
    String? to,
    String? search,
  }) = _RefreshRiwayats;

  const factory RiwayatEvent.changeFilter({
    String? from,
    String? to,
    String? search,
  }) = _ChangeFilter;
}