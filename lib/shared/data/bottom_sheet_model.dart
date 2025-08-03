import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:equatable/equatable.dart';

class BottomSheetModel extends Equatable {
  final String title;
  final num basePrice;
  final List<String> colors;
  final List<String> sizes;

  const BottomSheetModel({
    required this.title,
    required this.basePrice,
    required this.colors,
    required this.sizes,
  });

  factory BottomSheetModel.fromProduct(ProductModel product) {
    return BottomSheetModel(
      title: product.title,
      basePrice: product.basePrice,
      colors: product.parsedColors,
      sizes: product.parsedSizes,
    );
  }

  factory BottomSheetModel.fromFav(FavoriteModel fav) {
    return BottomSheetModel(
      title: fav.title,
      basePrice: fav.price,
      colors: fav.parsedColors,
      sizes: fav.parsedSizes,
    );
  }

  @override
  List<Object> get props => [title, basePrice, colors, sizes];
}
