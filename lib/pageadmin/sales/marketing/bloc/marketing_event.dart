part of 'marketing_bloc.dart';

@freezed
class MarketingEvent with _$MarketingEvent {
  const factory MarketingEvent.get() = _GetMarketing;
  const factory MarketingEvent.refresh() = _Refresh;
  const factory MarketingEvent.clear() = _Clear;
}