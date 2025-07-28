import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_events.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_state.dart';
import 'package:e_fashion_flutter/features/search/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;

  SearchBloc({required this.searchRepo}) : super(const SearchState()) {
    on<SearchProductEvent>(
      _searchEvent,
      transformer: debounceRestartable<SearchProductEvent>(
        const Duration(milliseconds: 500),
      ),
    );
  }

  FutureOr<void> _searchEvent(
    SearchProductEvent event,
    Emitter<SearchState> emit,
  ) async {
    final trimmedQuery = event.query.trim();
    if (trimmedQuery.isEmpty) {
      emit(
        state.copyWith(searchProducts: [], searchStatus: RequestStatus.initial),
      );
      return;
    }
    emit(state.copyWith(searchStatus: RequestStatus.loading));
    final result = await searchRepo.searchProducts(
      query: trimmedQuery,
      brand: event.brand,
      categoryId: event.categoryId,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            searchErrorMessage: failure.errorMessage,
            searchStatus: RequestStatus.error,
          ),
        );
      },
      (searchProducts) {
        emit(
          state.copyWith(
            searchProducts: searchProducts,
            searchStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  EventTransformer<T> debounceRestartable<T>(Duration duration) {
    return (events, mapper) =>
        restartable<T>().call(events.debounceTime(duration), mapper);
  }
}
