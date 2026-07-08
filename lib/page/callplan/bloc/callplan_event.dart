
part of 'callplan_bloc.dart';



@freezed
class CallplanEvent with _$CallplanEvent {
  const factory CallplanEvent.fetch({
    String? filterType,
    DateTimeRange? dateRange,
  }) = _FetchCallplan;

  const factory CallplanEvent.create({
    required DateTime tanggalCp,
    required String outlet,
    required String description,
  }) = _CreateCallplan;

  const factory CallplanEvent.update({
    required int id,
    required DateTime tanggalCp,
    required String outlet,
    required String description,
  }) = _UpdateCallplan;

  const factory CallplanEvent.delete({
    required int id,
  }) = _DeleteCallplan;

  const factory CallplanEvent.refresh() = _RefreshCallplan;
}