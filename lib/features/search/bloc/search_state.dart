import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final RequestStatus searchStatus;
  final List<ProductModel> searchProducts;
  final String searchErrorMessage;

  const SearchState({
    this.searchStatus = RequestStatus.initial,
    this.searchProducts = const [],
    this.searchErrorMessage = "",
  });

  SearchState copyWith({
    RequestStatus? searchStatus,
    List<ProductModel>? searchProducts,
    String? searchErrorMessage,
  }) {
    return SearchState(
      searchStatus: searchStatus ?? this.searchStatus,
      searchProducts: searchProducts ?? this.searchProducts,
      searchErrorMessage: searchErrorMessage ?? this.searchErrorMessage,
    );
  }

  @override
  List<Object> get props => [searchStatus, searchProducts, searchErrorMessage];
}
