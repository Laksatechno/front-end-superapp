part of 'tagihan_bloc.dart';

@freezed
class TagihanState with _$TagihanState {
  const factory TagihanState.initial() = _Initial;
  const factory TagihanState.loading({
    @Default([]) List<Tagihan> items,
    @Default(false) bool isRefreshing,
  }) = _Loading;
  const factory TagihanState.loaded({
    required List<Tagihan> items,
    required int page,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    String? search,
    @Default(0) int totalTagihan,
  }) = _Loaded;
  const factory TagihanState.error({
    required String message,
    @Default([]) List<Tagihan> items,
  }) = _Error;
}
