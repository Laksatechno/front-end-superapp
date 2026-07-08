part of 'area_bloc.dart';

@freezed
class AreaEvent with _$AreaEvent {
  const factory AreaEvent.started() = AreaEventStarted;

  const factory AreaEvent.getAreas() = AreaEventGetAreas;

  const factory AreaEvent.refresh() = AreaEventRefresh;
}