import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final int productId;
  final int rating;
  final String review;
  final String date;
  final String userName;
  final String userImage;

  const ReviewModel({
    required this.productId,
    required this.rating,
    required this.review,
    required this.date,
    required this.userName,
    required this.userImage,
  });
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      productId: json["productId"],
      rating: json["rating"],
      review: json["comment"],
      date: json["createdAt"],
      userName: json["userData"]["userName"],
      userImage: json["userData"]["imageUrl"],
    );
  }
  static const empty = ReviewModel(
    productId: 0,
    rating: 0,
    review: '',
    date: '',
    userName: '',
    userImage: '',
  );
  @override
  List<Object> get props => [
    productId,
    rating,
    review,
    date,
    userName,
    userImage,
  ];
}
