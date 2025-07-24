import 'package:equatable/equatable.dart';

class CollectionModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String subTitle;

  const CollectionModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.subTitle,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      imageUrl: json["pictureUrl"] ?? "",
      description: json["description"] ?? "",
      subTitle: json["subTitle"] ?? "",
    );
  }

  @override
  List<Object> get props => [id, title, imageUrl, description, subTitle];
}
