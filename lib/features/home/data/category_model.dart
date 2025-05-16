import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String name;
  final String image;

  const CategoryModel({required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json["name"], image: json["imageUrl"]);
  }

  @override
  List<Object> get props => [name, image];
}
