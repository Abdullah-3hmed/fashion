import 'package:e_fashion_flutter/features/home/data/review_model.dart';
import 'package:equatable/equatable.dart';

class ProductDetailsModel extends Equatable {
  final int id;
  final String productName;
  final String productImage;
  final double price;
  final String description;
  final List<ReviewModel> reviews;

  const ProductDetailsModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.description,
    required this.reviews,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json["id"],
      productName: json["productName"],
      productImage: json["imageUrl"],
      price: json["price"],
      description: json["description"],
      reviews: List<ReviewModel>.from(
        (json["reviews"]?[r"$values"] as List? ?? []).map(
          (review) => ReviewModel.fromJson(review),
        ),
      ),
    );
  }

  static const ProductDetailsModel empty = ProductDetailsModel(
    id: 0,
    productName: "",
    productImage: "",
    price: 0.0,
    description: "",
    reviews: [],
  );

  ProductDetailsModel copyWith({
    int? id,
    String? productName,
    String? productImage,
    double? price,
    String? description,
    List<ReviewModel>? reviews,
  }) => ProductDetailsModel(
    id: id ?? this.id,
    productName: productName ?? this.productName,
    productImage: productImage ?? this.productImage,
    price: price ?? this.price,
    description: description ?? this.description,
    reviews: reviews ?? this.reviews,
  );

  @override
  List<Object> get props => [
    id,
    productName,
    productImage,
    price,
    description,
    reviews,
  ];
}
