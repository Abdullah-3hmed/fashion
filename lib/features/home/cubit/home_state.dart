import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/data/offer_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_model.dart';
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
  final List<OfferModel> offers;
  final RequestStatus offersStatus;
  final String offersErrorMessage;
  final ProductDetailsModel productDetailsModel;
  final RequestStatus productDetailsStatus;
  final String productDetailsErrorMessage;
  final List<ProductModel> products;
  final RequestStatus productsStatus;
  final String productsErrorMessage;
  final RequestStatus addReviewStatus;
  final String addReviewErrorMessage;
  final List<DiscoverModel> offersDiscoverList;
  final List<DiscoverModel> productsDiscoverList;
  final int? selectedCategoryId;
  final String? gender;
  final double rating;

  const HomeState({
    this.collections = const [],
    this.collectionsStatus = RequestStatus.loading,
    this.collectionsErrorMessage = "",
    this.categories = const [],
    this.categoriesStatus = RequestStatus.loading,
    this.categoriesErrorMessage = "",
    this.collectionDetailsModel = CollectionDetailsModel.empty,
    this.collectionDetailsStatus = RequestStatus.initial,
    this.collectionDetailsErrorMessage = "",
    this.offers = const [],
    this.offersStatus = RequestStatus.loading,
    this.offersErrorMessage = "",
    this.productDetailsModel = ProductDetailsModel.empty,
    this.productDetailsStatus = RequestStatus.initial,
    this.productDetailsErrorMessage = "",
    this.products = const [],
    this.productsStatus = RequestStatus.initial,
    this.productsErrorMessage = "",
    this.addReviewStatus = RequestStatus.initial,
    this.addReviewErrorMessage = "",
    this.offersDiscoverList = const [],
    this.productsDiscoverList = const [],
    this.selectedCategoryId,
    this.gender,
    this.rating = 0.0,
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
    List<OfferModel>? offers,
    RequestStatus? offersStatus,
    String? offersErrorMessage,
    ProductDetailsModel? productDetailsModel,
    RequestStatus? productDetailsStatus,
    String? productDetailsErrorMessage,
    List<ProductModel>? products,
    RequestStatus? productsStatus,
    String? productsErrorMessage,
    RequestStatus? addReviewStatus,
    String? addReviewErrorMessage,
    List<DiscoverModel>? offersDiscoverList,
    List<DiscoverModel>? productsDiscoverList,
    int? selectedCategoryId,
    String? gender,
    double? rating,
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
      offers: offers ?? this.offers,
      offersStatus: offersStatus ?? this.offersStatus,
      offersErrorMessage: offersErrorMessage ?? this.offersErrorMessage,
      productDetailsModel: productDetailsModel ?? this.productDetailsModel,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      productDetailsErrorMessage:
          productDetailsErrorMessage ?? this.productDetailsErrorMessage,
      products: products ?? this.products,
      productsStatus: productsStatus ?? this.productsStatus,
      productsErrorMessage: productsErrorMessage ?? this.productsErrorMessage,
      addReviewStatus: addReviewStatus ?? this.addReviewStatus,
      addReviewErrorMessage:
          addReviewErrorMessage ?? this.addReviewErrorMessage,
      offersDiscoverList: offersDiscoverList ?? this.offersDiscoverList,
      productsDiscoverList: productsDiscoverList ?? this.productsDiscoverList,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      gender: gender ?? this.gender,
      rating: rating ?? this.rating,
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
    offers,
    offersStatus,
    offersErrorMessage,
    productDetailsModel,
    productDetailsStatus,
    productDetailsErrorMessage,
    products,
    productsStatus,
    productsErrorMessage,
    addReviewStatus,
    addReviewErrorMessage,
    offersDiscoverList,
    productsDiscoverList,
    selectedCategoryId,
    gender,
    rating,
  ];
}
