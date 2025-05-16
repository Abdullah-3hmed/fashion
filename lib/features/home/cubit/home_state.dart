import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<CollectionModel> collections;
  final RequestStatus collectionsStatus;
  final String collectionsErrorMessage;
  final List<CategoryModel> categories;
  final RequestStatus categoriesStatus;
  final String categoriesErrorMessage;

  const HomeState({
    this.collections = const [],
    this.collectionsStatus = RequestStatus.loading,
    this.collectionsErrorMessage = "",
    this.categories = const [],
    this.categoriesStatus = RequestStatus.loading,
    this.categoriesErrorMessage = "",
  });

  HomeState copyWith({
    List<CollectionModel>? collections,
    RequestStatus? collectionsStatus,
    String? collectionsErrorMessage,
    List<CategoryModel>? categories,
    RequestStatus? categoriesStatus,
    String? categoriesErrorMessage,
  }) {
    return HomeState(
      collections: collections ?? this.collections,
      collectionsStatus: collectionsStatus ?? this.collectionsStatus,
      collectionsErrorMessage:
          collectionsErrorMessage ?? this.collectionsErrorMessage,
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesErrorMessage:
          categoriesErrorMessage ?? this.categoriesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    collections,
    collectionsStatus,
    collectionsErrorMessage,
    categories,
    categoriesStatus,
    categoriesErrorMessage,
  ];
}
