import 'dart:developer';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(const HomeState());
  final HomeRepo homeRepo;

  Future<void> getCollections() async {
    emit(state.copyWith(isConnected: true,collectionsStatus: RequestStatus.loading));
    final result = await homeRepo.getCollections();
    result.fold(
      (failure) {
        if (!failure.isConnected) {
          emit(
            state.copyWith(
              collectionsErrorMessage: failure.errorMessage,
              collectionsStatus: RequestStatus.error,
              isConnected: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              collectionsErrorMessage: failure.errorMessage,
              collectionsStatus: RequestStatus.error,
            ),
          );
        }
      },
      (collections) => emit(
        state.copyWith(
          collections: collections,
          collectionsStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> getCollectionDetails({required String collectionId}) async {
    final result = await homeRepo.getCollectionDetails(
      collectionId: collectionId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          collectionDetailsErrorMessage: failure.errorMessage,
          collectionDetailsStatus: RequestStatus.error,
        ),
      ),
      (collectionDetails) => emit(
        state.copyWith(
          collectionDetailsModel: collectionDetails,
          collectionDetailsStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: RequestStatus.loading));
    final result = await homeRepo.getCategories();
    result.fold(
      (failure) => emit(
        state.copyWith(
          categoriesErrorMessage: failure.errorMessage,
          categoriesStatus: RequestStatus.error,
        ),
      ),
      (categories) {
        AppConstants.categories = categories;
        emit(
          state.copyWith(
            categories: categories,
            categoriesStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  Future<void> getProducts() async {
    emit(state.copyWith(productsState: RequestStatus.loading));
    final result = await homeRepo.getProducts(
      category: state.selectedCategoryId,
      gender: state.gender,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          productsErrorMessage: failure.errorMessage,
          productsState: RequestStatus.error,
        ),
      ),
      (products) => emit(
        state.copyWith(
          products: products,
          productsState: RequestStatus.success,
          genderActiveIndex: -1,
          categoryActiveIndex: -1,
        ),
      ),
    );
  }

  Future<void> getAllHomeData() async {
    await Future.wait([getCollections(), getCategories(), getProducts()]);
  }

  void selectCategory({required int categoryId}) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  void selectGender({required int gender}) {
    emit(state.copyWith(gender: gender));
  }

  void changeGender({required int index}) {
    emit(state.copyWith(genderActiveIndex: index));
  }
  void changeCategory({required int index}) {
    emit(state.copyWith(categoryActiveIndex: index));
  }
}
