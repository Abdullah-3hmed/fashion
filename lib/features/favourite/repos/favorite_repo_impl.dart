import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/safe_api_call.dart';
import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:e_fashion_flutter/features/favourite/repos/favorite_repo.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final DioHelper dioHelper;
  FavoriteRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, void>> addAndRemoveToFavorite({required String productId}) async {
    return safeApiCall<void>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.addToFavoriteEndpoint(productId: productId),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return ;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, List<FavoriteModel>>> getFavorites() async {
    return safeApiCall<List<FavoriteModel>>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.getFavoritesEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return List<FavoriteModel>.from(
          (response.data as List? ?? []).map((favorite) => FavoriteModel.fromJson(favorite)),
        );
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }
}
