import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/page/notification/model/notifikasi_model.dart';

part 'notifikasi_state.freezed.dart';

@freezed
class NotifikasiState with _$NotifikasiState {
  const factory NotifikasiState.initial() = _NotifikasiStateInitial;
  const factory NotifikasiState.loading() = _NotifikasiStateLoading;
  const factory NotifikasiState.loaded({
    required List<NotifikasiModel> data,
  }) = _NotifikasiStateLoaded;
  const factory NotifikasiState.error({
    required String message,
  }) = _NotifikasiStateError;
}
