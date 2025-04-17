import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ServerFailure('Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout in connection with API server');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection to API server failed due to internet connection');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout in connection with API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No internet connection');
        }
        return ServerFailure('Unexpected Error , Please try again');
      default:
        return ServerFailure('there was an error , please try again');
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found , please try later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error , please try later');
    }
    return ServerFailure('there was an error , please try again');
  }
}
