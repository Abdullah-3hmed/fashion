import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:equatable/equatable.dart';

class ProductDetailsState extends Equatable {
  final RequestStatus productDetailsState;
  final ProductDetailsModel productDetailsModel;
  final String productDetailsErrorMessage;
  final double rate;

  const ProductDetailsState({
    this.productDetailsState = RequestStatus.loading,
    this.productDetailsModel = ProductDetailsModel.empty,
    this.productDetailsErrorMessage = "",
    this.rate = 0.0,
  });

  ProductDetailsState copyWith({
    RequestStatus? productDetailsState,
    ProductDetailsModel? productDetailsModel,
    String? productDetailsErrorMessage,
    double? rate,
  }) {
    return ProductDetailsState(
      productDetailsState: productDetailsState ?? this.productDetailsState,
      productDetailsModel: productDetailsModel ?? this.productDetailsModel,
      productDetailsErrorMessage:
          productDetailsErrorMessage ?? this.productDetailsErrorMessage,
      rate: rate ?? this.rate,
    );
  }

  @override
  List<Object?> get props => [
    productDetailsState,
    productDetailsModel,
    productDetailsErrorMessage,
    rate,
  ];
}
