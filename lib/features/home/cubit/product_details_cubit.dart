import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_state.dart';
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
}
