import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final num basePrice;
  final num discountPrice;
  final bool isOffer;
  final String colors;
  final String sizes;

  const ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.basePrice,
    required this.discountPrice,
    required this.colors,
    required this.sizes,
    required this.isOffer,
  });

  List<String> get parsedColors =>
      colors
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

  List<String> get parsedSizes =>
      sizes.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        imageUrl: json["pictureUrl"] ?? "",
        basePrice: json["basePrice"] ?? 0,
        discountPrice: json["discountedPrice"] ?? 0,
        colors: json["colors"] ?? "",
        sizes: json["sizes"] ?? "",
        isOffer: json["isOffred"] ?? false,
      );

  FavoriteModel toFavoriteModel() =>
      FavoriteModel(
        id: id,
        title: title,
        image: imageUrl,
        price: isOffer ? discountPrice : basePrice,
        colors: colors,
        sizes: sizes,
      );

  @override
  List<Object> get props =>
      [
        id,
        title,
        imageUrl,
        basePrice,
        discountPrice,
        colors,
        sizes,
        isOffer,
      ];
}
