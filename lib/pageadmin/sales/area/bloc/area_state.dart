part of 'area_bloc.dart';

@freezed
class AreaState with _$AreaState {
  const factory AreaState.initial() = _Initial;

  const factory AreaState.loading() = _Loading;

  const factory AreaState.success({
    @Default([]) List<dynamic> areas,
  }) = _Success;

  const factory AreaState.failure(String message) = _Failure;
}