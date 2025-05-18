import 'package:equatable/equatable.dart';

class CollectionDetailsProduct extends Equatable {
  final int id;
  final String productName;
  final String description;
  final String imageUrl;

  const CollectionDetailsProduct({
    required this.id,
    required this.productName,
    required this.description,
    required this.imageUrl,
  });

  factory CollectionDetailsProduct.fromJson(Map<String, dynamic> json) {
    return CollectionDetailsProduct(
      id: json['id'],
      productName: json['productName'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  List<Object> get props => [id, productName, description, imageUrl];
}
