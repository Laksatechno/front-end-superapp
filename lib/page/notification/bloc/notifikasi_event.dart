import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifikasi_event.freezed.dart';

@freezed
class NotifikasiEvent with _$NotifikasiEvent {
  const factory NotifikasiEvent.load() = _NotifikasiEventLoad;
}
