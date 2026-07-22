import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yofa/pagecustomer/tagihan/datasource/tagihan_datasource.dart';
import 'package:yofa/pagecustomer/tagihan/model/tagihan_model.dart';

part 'tagihan_event.dart';
part 'tagihan_state.dart';
part 'tagihan_bloc.freezed.dart';

class TagihanBloc extends Bloc<TagihanEvent, TagihanState> {
  final TagihanDatasource datasource;

  TagihanBloc(this.datasource) : super(const TagihanState.initial()) {
    on<_Started>(_onStarted);
    on<_Refresh>(_onRefresh);
    on<_SearchChanged>(_onSearchChanged);
    on<_LoadMore>(_onLoadMore);
  }

  Future<void> _onStarted(_Started event, Emitter<TagihanState> emit) async {
    await _fetch(emit: emit, page: 1, search: null);
  }

  Future<void> _onRefresh(_Refresh event, Emitter<TagihanState> emit) async {
    final currentSearch = state.maybeWhen(
      loaded: (items, page, hasMore, isLoadingMore, search, totalTagihan) => search,
      orElse: () => null,
    );

    await _fetch(
      emit: emit,
      page: 1,
      search: event.search ?? currentSearch,
    );
  }

  Future<void> _onSearchChanged(_SearchChanged event, Emitter<TagihanState> emit) async {
    await _fetch(emit: emit, page: 1, search: event.search);
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<TagihanState> emit) async {
    final currentState = state;
    if (currentState is! _Loaded) return;
    if (currentState.isLoadingMore || !currentState.hasMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.page + 1;
      final nextItems = await datasource.getTagihan(
        search: currentState.search,
        page: nextPage,
        perPage: 10,
      );

      final merged = [...currentState.items, ...nextItems];
      emit(
        currentState.copyWith(
          items: merged,
          page: nextPage,
          hasMore: nextItems.length >= 10,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(
        TagihanState.error(
          message: e.toString(),
          items: currentState.items,
        ),
      );
    }
  }

  Future<void> _fetch({
    required Emitter<TagihanState> emit,
    required int page,
    String? search,
  }) async {
    final currentItems = state.maybeWhen(
      loading: (items, _) => items,
      loaded: (items, _, __, ___, ____, _____) => items,
      error: (message, items) => items,
      orElse: () => <Tagihan>[],
    );

    if (page == 1) {
      emit(TagihanState.loading(items: currentItems));
    } else if (state is _Loaded) {
      emit((state as _Loaded).copyWith(isLoadingMore: true));
    }

    try {
      final items = await datasource.getTagihan(
        search: search,
        page: page,
        perPage: 10,
      );

      final totalTagihan = items
          .where((item) => !item.isPaid)
          .fold<int>(0, (sum, item) => sum + item.total);

      emit(
        TagihanState.loaded(
          items: items,
          page: page,
          hasMore: items.length >= 10,
          search: search,
          totalTagihan: totalTagihan,
        ),
      );
    } catch (e) {
      emit(TagihanState.error(message: e.toString(), items: currentItems));
    }
  }
}
