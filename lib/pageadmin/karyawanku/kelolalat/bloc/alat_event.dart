part of 'alat_bloc.dart';

@freezed
abstract class AlatEvent with _$AlatEvent {
  const factory AlatEvent.getAlats({
    @Default(1) int page,
    @Default(10) int perPage,
    String? filterType,
    String? status,
    String? search,
  }) = _GetAlats;

  const factory AlatEvent.refresh({
    @Default(1) int page,
    @Default(10) int perPage,
    String? filterType,
    String? status,
    String? search,
  }) = _RefreshAlats;

  const factory AlatEvent.changeFilter({
    @Default(10) int perPage,
    String? filterType,
    String? status,
    String? search,
  }) = _ChangeFilter;


}