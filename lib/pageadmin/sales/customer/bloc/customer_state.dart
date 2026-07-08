part of 'customer_bloc.dart';

@freezed
class CustomerState with _$CustomerState {
  const factory CustomerState.initial() = _Initial;
  const factory CustomerState.loading() = _Loading;

  const factory CustomerState.loaded({
    required List<Customer> data,
    @Default(1) int page,
    @Default(10) int perPage,
    String? filterType,
    String? status,
  }) = _Loaded;

  const factory CustomerState.error(String message) = _Error;

  // opsional kalau kamu butuh toast sukses dari event lain
  const factory CustomerState.success(String message) = _Success;
}