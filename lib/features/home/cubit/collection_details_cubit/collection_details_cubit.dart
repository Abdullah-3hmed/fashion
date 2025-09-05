import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/collection_details_cubit/collection_details_state.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionDetailsCubit extends Cubit<CollectionDetailsState> {
  final HomeRepo homeRepoImpl;
  CollectionDetailsCubit({required this.homeRepoImpl})
    : super(const CollectionDetailsState());
  Future<void> getCollectionDetails({required String collectionId}) async {
    final result = await homeRepoImpl.getCollectionDetails(
      collectionId: collectionId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          collectionDetailsErrorMessage: failure.errorMessage,
          collectionDetailsStatus: RequestStatus.error,
        ),
      ),
      (collectionDetails) => emit(
        state.copyWith(
          collectionDetailsModel: collectionDetails,
          collectionDetailsStatus: RequestStatus.success,
        ),
      ),
    );
  }
}
