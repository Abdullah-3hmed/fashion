import 'package:e_fashion_flutter/features/home/data/collection_details_product.dart';
import 'package:equatable/equatable.dart';

class CollectionDetailsModel extends Equatable {
  final int totalPrice;
  final List<CollectionDetailsProduct> collectionProducts;

  const CollectionDetailsModel({
    required this.totalPrice,
    required this.collectionProducts,
  });

  factory CollectionDetailsModel.fromJson(Map<String, dynamic> json) {
    return CollectionDetailsModel(
      totalPrice: json['price'],
      collectionProducts: List<CollectionDetailsProduct>.from(
        json["products"][r'$values'].map(
          (product) => CollectionDetailsProduct.fromJson(product),
        ),
      ),
    );
  }

  static const CollectionDetailsModel empty = CollectionDetailsModel(
    totalPrice: 0,
    collectionProducts: [],
  );

  @override
  List<Object> get props => [totalPrice, collectionProducts];
}
