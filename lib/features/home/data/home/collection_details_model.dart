import 'package:e_fashion_flutter/features/home/data/home/collection_item_model.dart';
import 'package:equatable/equatable.dart';

class CollectionDetailsModel extends Equatable {
  final num totalPrice;
  final List<CollectionItemModel> collectionProducts;

  const CollectionDetailsModel({
    required this.totalPrice,
    required this.collectionProducts,
  });

  factory CollectionDetailsModel.fromJson(Map<String, dynamic> json) {
    return CollectionDetailsModel(
      totalPrice: json['price'],
      collectionProducts: List<CollectionItemModel>.from(
       ( json["items"]as List? ??[]).map(
          (item) => CollectionItemModel.fromJson(item),
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
