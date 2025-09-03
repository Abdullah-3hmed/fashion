import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final int totalPages;
  final Map<String, List<ProductModel>> groupedBrandProducts;

  const ProductsModel({
    required this.groupedBrandProducts,
    required this.totalPages,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final rawGrouped = json["groubedBrandsProduct"] as Map<String, dynamic>?;

    final Map<String, List<ProductModel>> groupedBrandProducts = {};
    if (rawGrouped != null) {
      rawGrouped.forEach((key, value) {
        groupedBrandProducts[key] =
            (value as List<dynamic>? ?? [])
                .map((product) => ProductModel.fromJson(product))
                .toList();
      });
    }

    return ProductsModel(
      groupedBrandProducts: groupedBrandProducts,
      totalPages: json["totalPages"] ?? 0,
    );
  }

  static const ProductsModel empty = ProductsModel(
    groupedBrandProducts: {},
    totalPages: 0,
  );

  ProductsModel copyWith({
    int? totalPages,
    Map<String, List<ProductModel>>? groupedBrandProducts,
  }) {
    return ProductsModel(
      totalPages: totalPages ?? this.totalPages,
      groupedBrandProducts: groupedBrandProducts ?? this.groupedBrandProducts,
    );
  }

  @override
  List<Object> get props => [groupedBrandProducts, totalPages];
}
