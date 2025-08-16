import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/network/custom_interceptors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio _dio;

  static void init() {
    BaseOptions options = BaseOptions(
      baseUrl: dotenv.env["API_URL"]!,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(options);
    _dio.interceptors.addAll([
      CustomInterceptors(),
      PrettyDioLogger(requestHeader: true, requestBody: true),
    ]);
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.get(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> post({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    //_dio.options.headers = headers;
    return await _dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  Future<Response> put({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    _dio.options.headers = headers;
    return await _dio.put(
      url,
      data: data,
      queryParameters: query,
      // options: Options(headers: headers),
    );
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.delete(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  Future<Response> patch({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.patch(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
}
