
part of 'brosur_bloc.dart';

@freezed
class BrosurEvent with _$BrosurEvent {
  const factory BrosurEvent.fetch({String? search}) = _Fetch;
  const factory BrosurEvent.download({
    required int id,
    required String fileName,
  }) = _Download;
}