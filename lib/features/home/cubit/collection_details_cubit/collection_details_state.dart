import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_details_model.dart';
import 'package:equatable/equatable.dart';

class CollectionDetailsState extends Equatable {
  final CollectionDetailsModel collectionDetailsModel;
  final RequestStatus collectionDetailsStatus;
  final String collectionDetailsErrorMessage;

  const CollectionDetailsState({
    this.collectionDetailsModel = CollectionDetailsModel.empty,
    this.collectionDetailsStatus = RequestStatus.loading,
    this.collectionDetailsErrorMessage = "",
  });

  CollectionDetailsState copyWith({
    CollectionDetailsModel? collectionDetailsModel,
    RequestStatus? collectionDetailsStatus,
    String? collectionDetailsErrorMessage,
  }) {
    return CollectionDetailsState(
      collectionDetailsModel:
          collectionDetailsModel ?? this.collectionDetailsModel,
      collectionDetailsStatus:
          collectionDetailsStatus ?? this.collectionDetailsStatus,
      collectionDetailsErrorMessage:
          collectionDetailsErrorMessage ?? this.collectionDetailsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
    collectionDetailsModel,
    collectionDetailsStatus,
    collectionDetailsErrorMessage,
  ];
}
