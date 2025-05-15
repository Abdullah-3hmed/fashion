import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<CollectionModel> collections;
  final RequestStatus collectionsStatus;
  final String collectionsErrorMessage;

  const HomeState({
    this.collections = const [],
    this.collectionsStatus = RequestStatus.loading,
    this.collectionsErrorMessage = "",
  });

  HomeState copyWith({
    List<CollectionModel>? collections,
    RequestStatus? collectionsStatus,
    String? collectionsErrorMessage,
  }) {
    return HomeState(
      collections: collections ?? this.collections,
      collectionsStatus: collectionsStatus ?? this.collectionsStatus,
      collectionsErrorMessage:
          collectionsErrorMessage ?? this.collectionsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    collections,
    collectionsStatus,
    collectionsErrorMessage,
  ];
}
