import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final double oldPrice;
  final double discountedPrice;

  const OfferModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.oldPrice,
    required this.discountedPrice,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      oldPrice: json["price"],
      discountedPrice: json["discountedPrice"],
    );
  }

  @override
  List<Object> get props => [id, name, imageUrl, oldPrice, discountedPrice];
}
