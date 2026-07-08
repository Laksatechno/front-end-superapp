part of 'callplan_bloc.dart';

@freezed
class CallplanState with _$CallplanState {
  const factory CallplanState.initial() = _Initial;

  const factory CallplanState.loading() = _Loading;

  const factory CallplanState.loaded(List<CallplanItem> data) = _Loaded;

  const factory CallplanState.error(String message) = _Error;
  const factory CallplanState.success(String message) = _Success;
}