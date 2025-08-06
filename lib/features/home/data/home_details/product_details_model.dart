import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:equatable/equatable.dart';

class ProductDetailsModel extends Equatable {
  final String id;
  final String title;
  final String colors;
  final String sizes;
  final double price;
  final String imageUrl;
  final List<ReviewModel> reviews;

  const ProductDetailsModel({
    required this.id,
    required this.title,
    required this.colors,
    required this.imageUrl,
    required this.sizes,
    required this.price,
    required this.reviews,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        colors: json["colors"] ?? "",
        sizes: json["sizes"] ?? "",
        imageUrl: json["pictureUrl"] ?? "",
        price: json["basePrice"] ?? 0.0,
        reviews: List<ReviewModel>.from(
          (json["reviews"] as List? ?? []).map((x) => ReviewModel.fromJson(x)),
        ),
      );
  static const ProductDetailsModel empty = ProductDetailsModel(
    id: "",
    title: "",
    sizes: "",
    reviews: [],
    imageUrl: "",
    colors: "",
    price: 0.0,
  );

  ProductDetailsModel copyWith({List<ReviewModel>? reviews}) {
    return ProductDetailsModel(
      id: id,
      imageUrl: imageUrl,
      title: title,
      colors: colors,
      sizes: sizes,
      price: price,
      reviews: reviews ?? this.reviews,
    );
  }

  List<String> get parsedColors =>
      colors
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

  List<String> get parsedSizes =>
      sizes.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  @override
  List<Object> get props => [
    id,
    title,
    imageUrl,
    colors,
    sizes,
    price,
    reviews,
  ];
}
