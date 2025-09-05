import 'package:equatable/equatable.dart';

class CollectionItemModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  const CollectionItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory CollectionItemModel.fromJson(Map<String, dynamic> json) {
    return CollectionItemModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['pictureUrl'] ?? "",
    );
  }

  @override
  List<Object> get props => [id, title, description, imageUrl];
}
