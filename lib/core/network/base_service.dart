// lib/core/network/base_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'base_response.dart';

class BaseService {
  BaseService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await MatchsterLocalStorage.instance.getAccessToken();

          if (token.toString().isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Optional: handle 401 / refresh token
          return handler.next(e);
        },
      ),
    );
  }

  static final BaseService _instance = BaseService._internal();
  factory BaseService() => _instance;

  late final Dio _dio;

  // ---------------- LOW LEVEL ----------------

  Future<Response> _get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> _post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> _put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> _delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.delete(path, data: data, queryParameters: queryParameters);
  }

  // ---------------- HIGH LEVEL (COMMON) ----------------

  Future<BaseResponse<T>> getRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
  }) {
    return request<T>(
      apiCall: () => _get(path, queryParameters: queryParameters),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> postRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
  }) {
    return request<T>(
      apiCall: () => _post(path, data: data, queryParameters: queryParameters),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> putRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
  }) {
    return request<T>(
      apiCall: () => _put(path, data: data, queryParameters: queryParameters),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> patchRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
  }) {
    return request<T>(
      apiCall:
          () => _dio.patch(path, data: data, queryParameters: queryParameters),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> deleteRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
  }) {
    return request<T>(
      apiCall:
          () => _delete(path, data: data, queryParameters: queryParameters),
      fromJsonT: fromJsonT,
    );
  }

  // ---------------- CORE SAFE REQUEST ----------------

  Future<BaseResponse<T>> request<T>({
    required Future<Response> Function() apiCall,
    T Function(dynamic json)? fromJsonT,
  }) async {
    try {
      final response = await apiCall();

      return BaseResponse<T>.fromJson(
        response.data,
        response.statusCode ?? 200,
        fromJsonT,
      );
    } catch (e) {
      debugPrint(e.toString());
      return BaseResponse<T>.error(
        message: 'Networkdd error  ${e.toString()}',
        statusCode: -1,
      );
    }
  }
}
