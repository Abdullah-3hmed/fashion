import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_state.dart';
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

  Future<void> addReview({
    required String productId,
    required String review,
    required double rate,
  }) async {
    emit(state.copyWith(addReviewState: RequestStatus.loading));
    final response = await homeDetailsRepo.addReview(
      productId: productId,
      review: review,
      rate: rate,
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          addReviewErrorMessage: failure.errorMessage,
          addReviewState: RequestStatus.error,
        ),
      ),
      (reviewModel) => emit(
        state.copyWith(
          reviewModel: reviewModel,
          productDetailsModel: state.productDetailsModel.copyWith(
            reviews: [...state.productDetailsModel.reviews, reviewModel],
          ),
          productDetailsState: RequestStatus.success,
        ),
      ),
    );
  }
  void rateProduct({required double rate}){
    emit(state.copyWith(rate: rate));
  }
}
