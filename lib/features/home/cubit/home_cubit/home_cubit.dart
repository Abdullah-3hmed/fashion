import 'dart:developer';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(const HomeState());
  final HomeRepo homeRepo;

  Future<void> getCollections() async {
    emit(
      state.copyWith(
        collectionsStatus: RequestStatus.loading,
        isConnected: true,
      ),
    );
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
        }
        emit(
          state.copyWith(
            collectionsErrorMessage: failure.errorMessage,
            collectionsStatus: RequestStatus.error,
          ),
        );
      },
      (collections) => emit(
        state.copyWith(
          collections: collections,
          collectionsStatus: RequestStatus.success,
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
      (categories) => emit(
        state.copyWith(
          categories: categories,
          categoriesStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> getProducts({int page = 1}) async {
    emit(
      state.copyWith(productsState: RequestStatus.loading, productsPage: page),
    );

    final result = await homeRepo.getProducts(
      category: state.selectedCategoryId,
      gender: state.gender,
      page: page,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          productsErrorMessage: failure.errorMessage,
          productsState: RequestStatus.error,
        ),
      ),
      (products) {
        final Map<String, List<ProductModel>> currentGrouped =
            Map<String, List<ProductModel>>.from(
              state.productsModel.groupedBrandProducts,
            );
        if (page == 1) {
          emit(
            state.copyWith(
              productsModel: products,
              productsState: RequestStatus.success,
              productsPage: 1,
              genderActiveIndex: -1,
              categoryActiveIndex: -1,
            ),
          );
        } else {
          products.groupedBrandProducts.forEach((brand, newList) {
            final List<ProductModel> oldList =
                currentGrouped[brand] ?? <ProductModel>[];
            currentGrouped[brand] = [...oldList, ...newList];
          });

          emit(
            state.copyWith(
              productsModel: state.productsModel.copyWith(
                groupedBrandProducts: currentGrouped,
                totalPages: products.totalPages,
              ),
              productsPage: page,
              productsState: RequestStatus.success,
              genderActiveIndex: -1,
              categoryActiveIndex: -1,
            ),
          );
        }
      },
    );
  }

  Future<void> getOffers({int page = 1}) async {
    emit(state.copyWith(offersState: RequestStatus.loading, offersPage: page));

    final result = await homeRepo.getOffers(
      category: state.selectedCategoryId,
      gender: state.gender,
      page: page,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          offersErrorMessage: failure.errorMessage,
          offersState: RequestStatus.error,
        ),
      ),
      (offers) => emit(
        state.copyWith(
          offersModel:
              page == 1
                  ? offers
                  : state.offersModel.copyWith(
                    offers: [...state.offersModel.offers, ...offers.offers],
                    totalPages: offers.totalPages,
                  ),
          offersState: RequestStatus.success,
          offersPage: page,
        ),
      ),
    );
  }

  Future<void> loadMoreProducts() async {
    if (state.productsPage >= state.productsModel.totalPages ||
        state.productsState.isLoading) {
      return;
    }

    await getProducts(page: state.productsPage + 1);
  }

  Future<void> loadMoreOffers() async {
    if (state.offersPage >= state.offersModel.totalPages ||
        state.offersState.isLoading) {
      return;
    }

    await getOffers(page: state.offersPage + 1);
  }

  Future<void> getAllHomeData() async {
    await Future.wait([
      getCollections(),
      getCategories(),
      getOffers(),
      getProducts(),
    ]);
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
