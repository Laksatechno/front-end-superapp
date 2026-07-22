part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.load() = _Load;

  const factory PaymentEvent.upload({
    required int tagihanId,
    required File file,
  }) = _Upload;
}
