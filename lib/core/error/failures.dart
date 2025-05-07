import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/services/location_service.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return const ServerFailure('Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          'Send timeout in connection with API server',
        );
      case DioExceptionType.connectionError:
        return const ServerFailure(
          // 'Connection to API server failed due to internet connection',
          "No Internet Connection",
        );
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'Receive timeout in connection with API server',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return const ServerFailure('No internet connection');
        }
        return const ServerFailure('Unexpected Error , Please try again');
      default:
        return const ServerFailure('there was an error , please try again');
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      return const ServerFailure('Your request not found , please try later');
    } else if (statusCode == 500) {
      return const ServerFailure('Internal server error , please try later');
    }
    return const ServerFailure('there was an error , please try again');
  }
}

class LocationFailure extends Failure {
  const LocationFailure(super.errorMessage);

  factory LocationFailure.fromException(Exception exception) {
    if (exception is LocationServiceException) {
      return LocationFailure(exception.errorMessage);
    } else if (exception is LocationPermissionException) {
      return LocationFailure(exception.errorMessage);
    } else {
      return const LocationFailure("Unknown location error");
    }
  }
}
