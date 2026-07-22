part of 'brosur_bloc.dart';

@freezed
class BrosurState with _$BrosurState {
  const factory BrosurState.initial() = _Initial;
  const factory BrosurState.loading() = _Loading;
  const factory BrosurState.loaded({
    required List<Brosur> brosur,
    @Default(null) int? downloadingId,
  }) = _Loaded;
  const factory BrosurState.error({
    required String message,
    @Default([]) List<Brosur> brosur,
  }) = _Error;
  const factory BrosurState.downloadSuccess({
    required String filePath,
    required List<Brosur> brosur,
  }) = _DownloadSuccess;
}