import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.name,
    required this.image,
    required this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["catName"],
      image: json["imageUrl"],
      id: json["catId"],
    );
  }

  @override
  List<Object> get props => [name, image, id];
}
