import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getUserProfile();
  Future<Either<Failure, void>> logOut({required String email});
  Future<Either<Failure, EditUserModel>> editProfile({
    required EditUserModel editUserModel,
  });
  Future<Either<Failure, Marker>> getCurrentLocation({
    required GoogleMapController mapController,
  });
}
