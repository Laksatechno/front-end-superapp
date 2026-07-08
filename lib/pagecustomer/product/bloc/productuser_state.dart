part of 'productuser_bloc.dart';

@freezed
class ProductUserState with _$ProductUserState {
  const factory ProductUserState.initial() = _Initial;
  const factory ProductUserState.loading() = _Loading;

  const factory ProductUserState.loaded({
    required List<CustomerProductPrice> data,
  }) = _Loaded;

  const factory ProductUserState.error(String message) = _Error;
}