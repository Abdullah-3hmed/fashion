import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final num price;

  const FavoriteModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      FavoriteModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        image: json["pictureUrl"] ?? "",
        price: json["basePrice"] ?? "",
      );

  @override
  List<Object> get props => [id, title, image, price];
}