part of 'marketing_bloc.dart';

@freezed
class MarketingState with _$MarketingState {
  const factory MarketingState.initial() = _Initial;
  const factory MarketingState.loading() = _Loading;
  const factory MarketingState.loaded(List<MarketingUser> items) = _Loaded;
  const factory MarketingState.error(String message) = _Error;
}