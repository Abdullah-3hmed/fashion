import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final String productId;
  final String imageUrl;
  final String name;
  final num price;
  final int quantity;
  final String color;
  final String size;

  const CartModel({
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId']??"",
      imageUrl: json['image']??"",
      name: json['productTitle']??"",
      price: json['price']??"",
      quantity: json['quantity']??"",
      color: json['color']??"",
      size: json['size']??"",
    );
  }
  num get totalPrice => price * quantity;

  @override
  List<Object> get props =>
      [
        productId,
        imageUrl,
        name,
        price,
        quantity,
        color,
        size,
      ];
}