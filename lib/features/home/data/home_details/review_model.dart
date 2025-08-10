import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String productId;
  final String reviewId;
  final String review;
  final int rate;
  final String createdAt;
  final String name;
  final String imageUrl;

  const ReviewModel({
    required this.productId,
    required this.reviewId,
    required this.review,
    required this.rate,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      productId: json['productId'] ?? "",
      reviewId: json['id'] ?? "",
      review: json['comment'] ?? "",
      rate: json['rate'] ?? 0,
      name: json["user"]?['userName'] ?? "",
      imageUrl: json["user"]?['profilePictureUrl'] ?? "",
      createdAt: json['date'] ?? "",

    );
  }

  @override
  List<Object> get props =>
      [productId, reviewId, review, rate, name, imageUrl, createdAt];
}
