import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'base_response.dart';

class BaseService {
  BaseService({required MatchsterLocalStorage storage}) : _storage = storage {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          debugPrint(
            'REQUEST[${options.method}] => PATH: ${options.path} '
            'HEADERS: ${options.headers} '
            'QUERY: ${options.queryParameters} '
            'BODY: ${options.data}',
          );

          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} '
            'DATA: ${response.data}',
          );
          handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path} '
            'MESSAGE: ${e.message}',
          );

          handler.next(e);
        },
      ),
    );
  }

  final MatchsterLocalStorage _storage;
  late final Dio _dio;

  Future<Response<dynamic>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<dynamic>> _post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> _put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> _delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<BaseResponse<T>> getRequest<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
    Options? options,
  }) {
    return request<T>(
      apiCall:
          () => _get(path, queryParameters: queryParameters, options: options),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> postRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
    Options? options,
  }) {
    return request<T>(
      apiCall:
          () => _post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          ),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> putRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
    Options? options,
  }) {
    return request<T>(
      apiCall:
          () => _put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          ),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> deleteRequest<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJsonT,
    Options? options,
  }) {
    return request<T>(
      apiCall:
          () => _delete(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          ),
      fromJsonT: fromJsonT,
    );
  }

  Future<BaseResponse<T>> request<T>({
    required Future<Response<dynamic>> Function() apiCall,
    T Function(dynamic json)? fromJsonT,
  }) async {
    try {
      final response = await apiCall();
      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        return BaseResponse<T>.error(
          message: 'Invalid response format',
          statusCode: response.statusCode ?? -1,
        );
      }

      return BaseResponse<T>.fromJson(
        responseData,
        response.statusCode ?? 200,
        fromJsonT,
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? -1;
      final responseData = e.response?.data;

      String message = 'Something went wrong';

      if (responseData is Map<String, dynamic>) {
        message =
            responseData['message']?.toString() ??
            responseData['error']?.toString() ??
            e.message ??
            message;
      } else {
        message = e.message ?? message;
      }

      return BaseResponse<T>.error(message: message, statusCode: statusCode);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return BaseResponse<T>.error(
        message: 'Unexpected error: $e',
        statusCode: -1,
      );
    }
  }
}
