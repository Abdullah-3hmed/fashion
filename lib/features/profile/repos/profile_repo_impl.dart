import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/location_service.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      debugPrint("Bearer ${AppConstants.token}");
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getUserProfileEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut({required String email}) async {
    try {
      await getIt<DioHelper>().get(
        url: ApiConstants.logOutEndpoint,
        data: {"email": email},
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      await getIt<CacheHelper>().delete(key: "token");
      AppConstants.token = "";
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditUserModel>> editProfile({
    required EditUserModel editUserModel,
  }) async {
    try {
      final response = await getIt<DioHelper>().put(
        url: ApiConstants.editProfileEndpoint,
        data: FormData.fromMap(editUserModel.toJson()),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(EditUserModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Marker>> getCurrentLocation({
    required GoogleMapController mapController,
  }) async {
    try {
      final locationData = await getIt<LocationService>().getCurrentLocation();
      final LatLng currentLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      Marker myLocationMarker = Marker(
        markerId: const MarkerId("myLocation"),
        position: currentLocation,
      );
      mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
      return Right(myLocationMarker);
    } on Exception catch (e) {
      return Left(LocationFailure.fromException(e));
    }
  }
}
