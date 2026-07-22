part of 'tagihan_bloc.dart';

@freezed
class TagihanEvent with _$TagihanEvent {
  const factory TagihanEvent.started() = _Started;
  const factory TagihanEvent.refresh({String? search}) = _Refresh;
  const factory TagihanEvent.searchChanged({String? search}) = _SearchChanged;
  const factory TagihanEvent.loadMore() = _LoadMore;
}
