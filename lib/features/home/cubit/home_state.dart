import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<CollectionModel> collections;
  final RequestStatus collectionsStatus;
  final String collectionsErrorMessage;
  final List<CategoryModel> categories;
  final RequestStatus categoriesStatus;
  final String categoriesErrorMessage;
  final CollectionDetailsModel collectionDetailsModel;
  final RequestStatus collectionDetailsStatus;
  final String collectionDetailsErrorMessage;

  const HomeState({
    this.collections = const [],
    this.collectionsStatus = RequestStatus.loading,
    this.collectionsErrorMessage = "",
    this.categories = const [],
    this.categoriesStatus = RequestStatus.loading,
    this.categoriesErrorMessage = "",
    this.collectionDetailsModel = CollectionDetailsModel.empty,
    this.collectionDetailsStatus = RequestStatus.loading,
    this.collectionDetailsErrorMessage = "",
  });

  HomeState copyWith({
    List<CollectionModel>? collections,
    RequestStatus? collectionsStatus,
    String? collectionsErrorMessage,
    List<CategoryModel>? categories,
    RequestStatus? categoriesStatus,
    String? categoriesErrorMessage,
    CollectionDetailsModel? collectionDetailsModel,
    RequestStatus? collectionDetailsStatus,
    String? collectionDetailsErrorMessage,
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
      collectionDetailsModel:
          collectionDetailsModel ?? this.collectionDetailsModel,
      collectionDetailsStatus:
          collectionDetailsStatus ?? this.collectionDetailsStatus,
      collectionDetailsErrorMessage:
          collectionDetailsErrorMessage ?? this.collectionDetailsErrorMessage,
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
    collectionDetailsModel,
    collectionDetailsStatus,
    collectionDetailsErrorMessage,
  ];
}
