import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit/product_details_state.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_details_repo/home_details_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.homeDetailsRepo})
    : super(const ProductDetailsState());
  final HomeDetailsRepo homeDetailsRepo;

  Future<void> getProductDetails({required String productId}) async {
    final response = await homeDetailsRepo.getProductDetails(
      productId: productId,
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          productDetailsErrorMessage: failure.errorMessage,
          productDetailsState: RequestStatus.error,
        ),
      ),
      (productDetails) => emit(
        state.copyWith(
          productDetailsModel: productDetails,
          productDetailsState: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> addReview({required ReviewModel reviewModel}) async {
    final List<ReviewModel> oldReviews = [...state.productDetailsModel.reviews];
    emit(
      state.copyWith(
        addReviewState: RequestStatus.loading,
        productDetailsModel: state.productDetailsModel.copyWith(
          reviews: [...oldReviews, reviewModel],
        ),
      ),
    );

    final response = await homeDetailsRepo.addReview(
      productId: reviewModel.productId,
      review: reviewModel.review,
      rate: reviewModel.rate,
    );

    response.fold(
          (failure) {
        emit(
          state.copyWith(
            addReviewErrorMessage: failure.errorMessage,
            addReviewState: RequestStatus.error,
            productDetailsModel: state.productDetailsModel.copyWith(
              reviews: oldReviews,
            ),
          ),
        );
      },
          (newReviewModel) {
        final updatedReviews = [...oldReviews, newReviewModel];
        emit(
          state.copyWith(
            addReviewState: RequestStatus.success,
            productDetailsModel: state.productDetailsModel.copyWith(
              reviews: updatedReviews,
            ),
          ),
        );
      },
    );
  }


  void rateProduct({required double rate}) {
    emit(state.copyWith(rate: rate));
  }
}
