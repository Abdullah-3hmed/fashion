import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(const HomeState());
  final HomeRepo homeRepo;
  Future<void> getCollections() async {
    final result = await homeRepo.getCollections();
    result.fold(
      (failure) => emit(
        state.copyWith(
          collectionsErrorMessage: failure.errorMessage,
          collectionsStatus: RequestStatus.error,
        ),
      ),
      (collections) => emit(
        state.copyWith(
          collections: collections,
          collectionsStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> getCategories() async {
    final result = await homeRepo.getCategories();
    result.fold(
      (failure) => emit(
        state.copyWith(
          categoriesErrorMessage: failure.errorMessage,
          categoriesStatus: RequestStatus.error,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categories: categories,
          categoriesStatus: RequestStatus.success,
        ),
      ),
    );
  }
}
