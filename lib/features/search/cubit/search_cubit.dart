import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/search/cubit/search_state.dart';
import 'package:e_fashion_flutter/features/search/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(const SearchState());
  final SearchRepo searchRepo;

  Future<void> searchProducts({required String query}) async {
    emit(state.copyWith(searchStatus: RequestStatus.loading));
    final result = await searchRepo.searchProducts(query: query);
    result.fold(
      (failure) => emit(
        state.copyWith(
          searchErrorMessage: failure.errorMessage,
          searchStatus: RequestStatus.error,
        ),
      ),
      (searchProducts) => emit(
        state.copyWith(
          searchProducts: searchProducts,
          searchStatus: RequestStatus.success,
        ),
      ),
    );
  }
}
