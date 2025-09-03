import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/offers_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/products_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<CollectionModel> collections;
  final RequestStatus collectionsStatus;
  final String collectionsErrorMessage;
  final List<CategoryModel> categories;
  final RequestStatus categoriesStatus;
  final String categoriesErrorMessage;
  final ProductsModel productsModel;
  final RequestStatus productsState;
  final String productsErrorMessage;
  final OffersModel offersModel;
  final RequestStatus offersState;
  final String offersErrorMessage;
  final int? selectedCategoryId;
  final int? gender;
  final int genderActiveIndex;
  final int categoryActiveIndex;
  final int productsPage;
  final int offersPage;

  final bool isConnected;

  const HomeState({
    this.collections = const [],
    this.collectionsStatus = RequestStatus.loading,
    this.collectionsErrorMessage = "",
    this.categories = const [],
    this.categoriesStatus = RequestStatus.loading,
    this.categoriesErrorMessage = "",
    this.productsModel = ProductsModel.empty,
    this.productsState = RequestStatus.initial,
    this.productsErrorMessage = "",
    this.offersModel = OffersModel.empty,
    this.offersState = RequestStatus.initial,
    this.offersErrorMessage = "",
    this.selectedCategoryId,
    this.gender,
    this.genderActiveIndex = -1,
    this.categoryActiveIndex = -1,
    this.productsPage = 1,
    this.offersPage = 1,
    this.isConnected = true,
  });

  HomeState copyWith({
    List<CollectionModel>? collections,
    RequestStatus? collectionsStatus,
    String? collectionsErrorMessage,
    List<CategoryModel>? categories,
    RequestStatus? categoriesStatus,
    String? categoriesErrorMessage,
    ProductsModel? productsModel,
    RequestStatus? productsState,
    String? productsErrorMessage,
    OffersModel? offersModel,
    RequestStatus? offersState,
    String? offersErrorMessage,
    int? selectedCategoryId,
    int? gender,
    int? genderActiveIndex,
    int? categoryActiveIndex,
    int? productsPage,
    int? offersPage,
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
      productsModel: productsModel ?? this.productsModel,
      productsState: productsState ?? this.productsState,
      offersModel: offersModel ?? this.offersModel,
      offersState: offersState ?? this.offersState,
      offersErrorMessage: offersErrorMessage ?? this.offersErrorMessage,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      gender: gender ?? this.gender,
      genderActiveIndex: genderActiveIndex ?? this.genderActiveIndex,
      categoryActiveIndex: categoryActiveIndex ?? this.categoryActiveIndex,
      productsErrorMessage: productsErrorMessage ?? this.productsErrorMessage,
      productsPage: productsPage ?? this.productsPage,
      offersPage: offersPage ?? this.offersPage,
      isConnected: isConnected ?? this.isConnected,
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
    productsModel,
    productsState,
    productsErrorMessage,
    offersModel,
    offersState,
    offersErrorMessage,
    selectedCategoryId,
    gender,
    isConnected,
    genderActiveIndex,
    categoryActiveIndex,
    productsPage,
    offersPage,
  ];
}
