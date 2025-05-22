import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final double price;

  const SearchModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json["id"],
      name: json["productName"],
      imageUrl: json["imageUrl"],
      price: json["price"],
    );
  }

  @override
  List<Object> get props => [id, name, imageUrl, price];
}
