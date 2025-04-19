import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/network/custom_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio _dio;
  static bool _initialized = false;
  static void init() {
    if (_initialized) return;
    _initialized = true;
    BaseOptions options = BaseOptions(
      baseUrl: "https://fakestoreapi.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    _dio = Dio(options);
    _dio.interceptors.addAll([
      CustomInterceptors(),
      PrettyDioLogger(requestHeader: true, requestBody: true),
    ]);
  }

  static Future<Response> get(
    String url, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<Response> put(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.put(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete(
    String url, {
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
}
