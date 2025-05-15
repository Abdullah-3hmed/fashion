import 'package:equatable/equatable.dart';

class CollectionModel extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final String discount;
  final String subTitle;
  final double discountPercent;

  const CollectionModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.discount,
    required this.subTitle,
    required this.discountPercent,
  });
  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json["id"],
      title: json["title"],
      imageUrl: json["imageUrl"],
      discount: json["discount"],
      subTitle: json["subTitle"],
      discountPercent: json["discountPercent"],
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    imageUrl,
    discount,
    subTitle,
    discountPercent,
  ];
}
