import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String reviewId;
  final String review;
  final num rate;
  final String name;
  final String imageUrl;

  const ReviewModel({
    required this.reviewId,
    required this.review,
    required this.rate,
    required this.name,
    required this.imageUrl,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['id'] ?? "",
      review: json['comment'] ?? "",
      rate: json['rate'] ?? 0.0,
      name: json["user"]['userName'] ?? "",
      imageUrl: json["user"]['profilePictureUrl'] ?? "",
    );
  }

  @override
  List<Object> get props => [reviewId, review, rate, name, imageUrl];
}
