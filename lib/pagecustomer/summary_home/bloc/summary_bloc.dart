import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:yofa/pagecustomer/summary_home/datasource/summary_datasource.dart';
import 'package:yofa/pagecustomer/summary_home/model/summary_model.dart';


part 'summary_event.dart';
part 'summary_state.dart';
part 'summary_bloc.freezed.dart';



class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {

  final SummaryDatasource datasource;


  SummaryBloc(this.datasource)
      : super(const SummaryState.initial()) {


    on<SummaryLoadEvent>(_onLoad);

    on<SummaryRefreshEvent>(_onRefresh);

  }



  Future<void> _onLoad(
      SummaryLoadEvent event,
      Emitter<SummaryState> emit,
  ) async {

    emit(const SummaryState.loading());


    try {

      final data = await datasource.getSummary();

      emit(
        SummaryState.loaded(data),
      );


    } catch (e) {

      emit(
        SummaryState.error(e.toString()),
      );

    }

  }




  Future<void> _onRefresh(
      SummaryRefreshEvent event,
      Emitter<SummaryState> emit,
  ) async {

    try {

      final data = await datasource.getSummary();

      emit(
        SummaryState.loaded(data),
      );


    } catch (e) {

      emit(
        SummaryState.error(e.toString()),
      );

    }

  }

}