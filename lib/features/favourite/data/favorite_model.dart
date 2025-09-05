import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final num price;
  final String colors;
  final String sizes;

  const FavoriteModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.colors,
    required this.sizes,
  });

  List<String> get parsedColors =>
      colors
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

  List<String> get parsedSizes =>
      sizes.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    image: json["pictureUrl"] ?? "",
    price: json["basePrice"] ?? "",
    colors: json["colors"] ?? "",
    sizes: json["sizes"] ?? "",
  );

  @override
  List<Object> get props => [id, title, image, price, colors, sizes];
}
