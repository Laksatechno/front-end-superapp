part of 'customer_bloc.dart';

@freezed
class CustomerEvent with _$CustomerEvent {
  const factory CustomerEvent.started() = _Started;
  
  const factory CustomerEvent.getCustomers({
    @Default(1) int page,
    @Default(10) int perPage,
    String? filterType,
    String? status,
  }) = _GetCustomers;

  const factory CustomerEvent.refresh({
    @Default(1) int page,
    @Default(10) int perPage,
    String? filterType,
    String? status,
  }) = _RefreshCustomers;

  const factory CustomerEvent.changeFilter({
    @Default(10) int perPage,
    String? filterType,
    String? status,
  }) = _ChangeFilter;
}