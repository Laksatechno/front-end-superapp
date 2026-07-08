part of 'alat_bloc.dart';

@freezed
abstract class AlatState with _$AlatState {
  const factory AlatState.initial() = _Initial;
  const factory AlatState.loading() = _Loading;

  const factory AlatState.loaded({
    required List<Alat> data,
    @Default(1) int page,
    @Default(10) int perPage,
    String? filterType,
    String? status,
    String? search,
  }) = _Loaded;

  const factory AlatState.error(String message) = _Error;
  const factory AlatState.success(String message) = _Success;
}