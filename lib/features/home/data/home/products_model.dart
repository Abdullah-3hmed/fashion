import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final List<ProductModel> offredProducts;
  final Map<String, List<ProductModel>> groupedBrandProducts;

  const ProductsModel({
    required this.offredProducts,
    required this.groupedBrandProducts,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final offredProducts = (json["offredProdcut"] as List<dynamic>? ?? [])
        .map((product) => ProductModel.fromJson(product))
        .toList();

    final rawGrouped = json["groubedBrandsProduct"] as Map<String, dynamic>?;

    final  Map<String, List<ProductModel>> groupedBrandProducts ={};
    if (rawGrouped != null) {
      rawGrouped.forEach((key, value) {
        groupedBrandProducts[key] = (value as List<dynamic>? ??[])
            .map((product) => ProductModel.fromJson(product))
            .toList();
      });
    }

    return ProductsModel(
      offredProducts: offredProducts,
      groupedBrandProducts: groupedBrandProducts,
    );
  }
  static const ProductsModel empty =  ProductsModel(
        offredProducts: [],
        groupedBrandProducts: {},
      );

  @override
  List<Object> get props => [offredProducts, groupedBrandProducts];
}
