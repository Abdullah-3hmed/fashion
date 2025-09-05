import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:equatable/equatable.dart';

class BottomSheetModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final num basePrice;
  final List<String> colors;
  final List<String> sizes;

  const BottomSheetModel({
    required this.title,
    required this.basePrice,
    required this.colors,
    required this.sizes,
    required this.imageUrl,
    required this.id,
  });

  factory BottomSheetModel.fromProduct(
    ProductModel product, {
    bool isOffered = false,
  }) {
    return BottomSheetModel(
      title: product.title,
      basePrice: isOffered ? product.discountPrice : product.basePrice,
      colors: product.parsedColors,
      sizes: product.parsedSizes,
      imageUrl: product.imageUrl,
      id: product.id,
    );
  }

  factory BottomSheetModel.fromFav(
    FavoriteModel fav, {
    bool isOffered = false,
  }) {
    return BottomSheetModel(
      title: fav.title,
      basePrice: fav.price,
      colors: fav.parsedColors,
      sizes: fav.parsedSizes,
      imageUrl: fav.image,
      id: fav.id,
    );
  }

  @override
  List<Object> get props => [title, basePrice, colors, sizes, imageUrl, id];
}
