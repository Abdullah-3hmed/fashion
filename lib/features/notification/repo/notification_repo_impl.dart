import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/safe_api_call.dart';
import 'package:e_fashion_flutter/features/notification/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final DioHelper dioHelper;

  NotificationRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, void>> toggleNotification({
    required String fcmToken,
  }) async {
    return safeApiCall<void>(() async {
      final response = await dioHelper.patch(
        url: ApiConstants.updateFcmTokenEndpoint(fcmToken: fcmToken),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }
}
