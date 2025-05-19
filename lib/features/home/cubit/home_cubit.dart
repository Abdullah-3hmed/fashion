import 'dart:developer';

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

  Future<void> getCollectionDetails({
    required int collectionId,
    required double price,
  }) async {
    emit(state.copyWith(collectionDetailsStatus: RequestStatus.loading));
    final result = await homeRepo.getCollectionDetails(
      collectionId: collectionId,
      price: price.toInt(),
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

  Future<void> getOffers() async {
    final result = await homeRepo.getOffers();
    result.fold(
      (failure) => emit(
        state.copyWith(
          offersErrorMessage: failure.errorMessage,
          offersStatus: RequestStatus.error,
        ),
      ),
      (offers) => emit(
        state.copyWith(offers: offers, offersStatus: RequestStatus.success),
      ),
    );
  }

  Future<void> getProductDetails({required int productId}) async {
    emit(state.copyWith(productDetailsStatus: RequestStatus.loading));
    final result = await homeRepo.getProductDetails(productId: productId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            productDetailsErrorMessage: failure.errorMessage,
            productDetailsStatus: RequestStatus.error,
          ),
        );
        log(failure.errorMessage);
      },
      (productDetails) => emit(
        state.copyWith(
          productDetailsModel: productDetails,
          productDetailsStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> getProducts({int? categoryId, String? gender}) async {
    emit(state.copyWith(productsStatus: RequestStatus.loading));
    final result = await homeRepo.getProducts(
      categoryId: categoryId,
      gender: gender,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            productsErrorMessage: failure.errorMessage,
            productsStatus: RequestStatus.error,
          ),
        );
        log(failure.errorMessage);
      },
      (products) => emit(
        state.copyWith(
          products: products,
          productsStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> addReview({
    required int productId,
    required int rating,
    required String review,
  }) async {
    emit(state.copyWith(addReviewStatus: RequestStatus.loading));
    final result = await homeRepo.addReview(
      productId: productId,
      rating: rating,
      review: review,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          addReviewErrorMessage: failure.errorMessage,
          addReviewStatus: RequestStatus.error,
        ),
      ),
      (_) async {
        await getProductDetails(productId: productId);
        emit(state.copyWith(addReviewStatus: RequestStatus.success));
      },
    );
  }

  void selectCategory({required int categoryId}) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  void selectGender({required String gender}) {
    emit(state.copyWith(gender: gender));
  }
}
