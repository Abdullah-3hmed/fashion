import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:equatable/equatable.dart';

class OffersModel extends Equatable {
  final int totalPages;
  final List<ProductModel> offers;

  const OffersModel({required this.totalPages, required this.offers});

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
    totalPages: json["totalPages"] ?? 0,
    offers:
        (json["data"] as List<dynamic>? ?? [])
            .map((product) => ProductModel.fromJson(product))
            .toList(),
  );
  static const OffersModel empty = OffersModel(totalPages: 0, offers: []);

  OffersModel copyWith({int? totalPages, List<ProductModel>? offers}) {
    return OffersModel(
      totalPages: totalPages ?? this.totalPages,
      offers: offers ?? this.offers,
    );
  }

  @override
  List<Object> get props => [totalPages, offers];
}
