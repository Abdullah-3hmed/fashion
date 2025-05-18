import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final double price;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      price: json["price"],
    );
  }

  @override
  List<Object> get props => [id, name, imageUrl, price];
}
