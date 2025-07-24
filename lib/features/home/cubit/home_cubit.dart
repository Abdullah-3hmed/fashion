import 'dart:developer';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/data/review_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(const HomeState());
  final HomeRepo homeRepo;

  Future<void> getCollections() async {
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
    required String collectionId,
  }) async {
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

  Future<void> getOffers() async {
    final result = await homeRepo.getOffers();
    result.fold(
      (failure) => emit(
        state.copyWith(
          offersErrorMessage: failure.errorMessage,
          offersStatus: RequestStatus.error,
        ),
      ),
      (offers) {
        List<DiscoverModel> offersDiscoverList =
            offers
                .map(
                  (offer) => DiscoverModel(
                    name: offer.name,
                    image: offer.imageUrl,
                    price: offer.discountedPrice,
                    id: offer.id,
                  ),
                )
                .toList();
        emit(
          state.copyWith(
            offers: offers,
            offersStatus: RequestStatus.success,
            offersDiscoverList: offersDiscoverList,
          ),
        );
      },
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

  Future<void> getProducts() async {
    emit(state.copyWith(productsStatus: RequestStatus.loading));
    final result = await homeRepo.getProducts(
      categoryId: state.selectedCategoryId,
      gender: state.gender,
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
      (products) {
        List<DiscoverModel> productsDiscoverList =
            products
                .map(
                  (product) => DiscoverModel(
                    name: product.name,
                    image: product.imageUrl,
                    price: product.price,
                    id: product.id,
                  ),
                )
                .toList();
        emit(
          state.copyWith(
            products: products,
            productsStatus: RequestStatus.success,
            productsDiscoverList: productsDiscoverList,
          ),
        );
      },
    );
  }

  Future<void> addReview({
    required int productId,
    required String review,
  }) async {
    emit(state.copyWith(addReviewStatus: RequestStatus.loading));
    final result = await homeRepo.addReview(
      productId: productId,
      rating: state.rating.toInt(),
      review: review,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          addReviewErrorMessage: failure.errorMessage,
          addReviewStatus: RequestStatus.error,
        ),
      ),
      (reviewModel) async {
        final List<ReviewModel> updatedReviews = List<ReviewModel>.from(
          state.productDetailsModel.reviews,
        )..add(reviewModel);
        emit(
          state.copyWith(
            addReviewStatus: RequestStatus.success,
            productDetailsModel: state.productDetailsModel.copyWith(
              reviews: updatedReviews,
            ),
          ),
        );
      },
    );
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

  void selectGender({required String gender}) {
    emit(state.copyWith(gender: gender));
  }

  void rateProduct({required double rating}) {
    emit(state.copyWith(rating: rating));
  }
}
