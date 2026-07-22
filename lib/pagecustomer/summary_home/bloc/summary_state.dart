part of 'summary_bloc.dart';


@freezed
class SummaryState with _$SummaryState {


  const factory SummaryState.initial() = SummaryInitial;


  const factory SummaryState.loading() = SummaryLoading;


  const factory SummaryState.loaded(
      SummaryModel summary
  ) = SummaryLoaded;


  const factory SummaryState.error(
      String message
  ) = SummaryError;


}