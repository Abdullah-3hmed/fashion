import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/products_model.dart';
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
  final ProductsModel products;
  final RequestStatus productsState;
  final String productsErrorMessage;
  final int? selectedCategoryId;
  final int? gender;
  final bool isConnected;

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
    this.products = ProductsModel.empty,
    this.productsState = RequestStatus.initial,
    this.productsErrorMessage = "",
    this.selectedCategoryId,
    this.gender,
    this.isConnected = true,
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
    ProductsModel? products,
    RequestStatus? productsState,
    String? productsErrorMessage,
    int? selectedCategoryId,
    int? gender,
    bool? isConnected,
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
      products: products ?? this.products,
      productsState: productsState ?? this.productsState,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      gender: gender ?? this.gender,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props =>
      [
        collections,
        collectionsStatus,
        collectionsErrorMessage,
        categories,
        categoriesStatus,
        categoriesErrorMessage,
        collectionDetailsModel,
        collectionDetailsStatus,
        collectionDetailsErrorMessage,
        products,
        productsState,
        productsErrorMessage,
        selectedCategoryId,
        gender,
        isConnected,
      ];
}
