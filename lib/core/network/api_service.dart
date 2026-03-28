import 'package:dio/dio.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_logs_strings.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/core/utils/app_logger.dart';
import 'api_response.dart';

class ApiService {
  ApiService({required MatchsterLocalStorage storage}) : _storage = storage {
    _dio = Dio(_buildBaseOptions());
    _dio.interceptors.add(_buildInterceptors());
  }

  final MatchsterLocalStorage _storage;
  late final Dio _dio;

  BaseOptions _buildBaseOptions() {
    return BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      headers: _defaultHeaders,
      validateStatus:
          (status) =>
              status != null && status < AppConstants.maxValidStatusCode,
      connectTimeout: const Duration(
        seconds: AppConstants.defaultTimeoutSeconds,
      ),
      receiveTimeout: const Duration(
        seconds: AppConstants.defaultTimeoutSeconds,
      ),
      sendTimeout: const Duration(seconds: AppConstants.defaultTimeoutSeconds),
    );
  }

  Map<String, String> get _defaultHeaders => const {
    AppConstants.contentTypeKey: AppConstants.applicationJson,
    AppConstants.acceptKey: AppConstants.applicationJson,
  };

  InterceptorsWrapper _buildInterceptors() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        await _attachAccessToken(options);
        _logRequest(options);
        handler.next(options);
      },
      onResponse: (response, handler) {
        _logResponse(response);
        handler.next(response);
      },
      onError: (error, handler) {
        _logDioError(error);
        handler.next(error);
      },
    );
  }

  Future<void> _attachAccessToken(RequestOptions options) async {
    final token = await _storage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers[AppConstants.authorizationKey] =
          '${AppConstants.bearer} $token';
    }
  }

  void _logRequest(RequestOptions options) {
    AppLogger.debug(
      '${AppLogStrings.request}[${options.method}] => '
      '${AppLogStrings.path}: ${options.path} | '
      '${AppLogStrings.headers}: ${options.headers} | '
      '${AppLogStrings.query}: ${options.queryParameters} | '
      '${AppLogStrings.body}: ${options.data}',
    );
  }

  void _logResponse(Response<dynamic> response) {
    AppLogger.info(
      '${AppLogStrings.response}[${response.statusCode}] => '
      '${AppLogStrings.path}: ${response.requestOptions.path} | '
      '${AppLogStrings.data}: ${response.data}',
    );
  }

  void _logDioError(DioException error) {
    AppLogger.error(
      '${AppLogStrings.error}[${error.response?.statusCode}] => '
      '${AppLogStrings.path}: ${error.requestOptions.path} | '
      '${AppLogStrings.message}: ${error.message}',
      error,
      error.stackTrace,
    );
  }

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

  Future<ApiResponse<T>> getRequest<T>({
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

  Future<ApiResponse<T>> postRequest<T>({
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

  Future<ApiResponse<T>> putRequest<T>({
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

  Future<ApiResponse<T>> deleteRequest<T>({
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

  Future<ApiResponse<T>> request<T>({
    required Future<Response<dynamic>> Function() apiCall,
    T Function(dynamic json)? fromJsonT,
  }) async {
    try {
      final response = await apiCall();
      return _handleSuccessResponse(response: response, fromJsonT: fromJsonT);
    } on DioException catch (error) {
      return _handleDioException<T>(error);
    } catch (error, stackTrace) {
      return _handleUnexpectedError<T>(error, stackTrace);
    }
  }

  ApiResponse<T> _handleSuccessResponse<T>({
    required Response<dynamic> response,
    T Function(dynamic json)? fromJsonT,
  }) {
    final responseData = response.data;

    if (responseData is! Map<String, dynamic>) {
      return ApiResponse<T>.error(
        message: AppLogStrings.invalidResponseFormat,
        statusCode: response.statusCode ?? AppConstants.defaultErrorStatusCode,
      );
    }

    return ApiResponse<T>.fromJson(
      responseData,
      response.statusCode ?? AppConstants.successStatusCode,
      fromJsonT,
    );
  }

  ApiResponse<T> _handleDioException<T>(DioException error) {
    final statusCode =
        error.response?.statusCode ?? AppConstants.defaultErrorStatusCode;
    final responseData = error.response?.data;

    String message = AppLogStrings.somethingWentWrong;

    if (responseData is Map<String, dynamic>) {
      message =
          responseData['message']?.toString() ??
          responseData['error']?.toString() ??
          error.message ??
          AppLogStrings.somethingWentWrong;
    } else {
      message = error.message ?? AppLogStrings.somethingWentWrong;
    }

    return ApiResponse<T>.error(message: message, statusCode: statusCode);
  }

  ApiResponse<T> _handleUnexpectedError<T>(
    Object error,
    StackTrace stackTrace,
  ) {
    AppLogger.error(
      '${AppLogStrings.unexpectedError}: $error',
      error,
      stackTrace,
    );

    return ApiResponse<T>.error(
      message: '${AppLogStrings.unexpectedError}: $error',
      statusCode: AppConstants.defaultErrorStatusCode,
    );
  }
}
