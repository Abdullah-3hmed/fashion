import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchProductEvent extends SearchEvent {
  final String query;
  final String? brand;
  final int? categoryId;
  final int? minPrice;
  final int? maxPrice;

  SearchProductEvent({
    required this.query,
    this.brand,
    this.categoryId,
    this.minPrice,
    this.maxPrice,
  });

  @override
  List<Object?> get props => [query, brand, categoryId, minPrice, maxPrice];
}
