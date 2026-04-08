// lib/core/network/base_response.dart
class BaseResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int statusCode;

  BaseResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory BaseResponse.fromJson(
    dynamic json,
    int statusCode,
    T Function(dynamic json)? fromJsonT,
  ) {
    // Handle string responses
    if (json is String) {
      return BaseResponse<T>(
        success: true,
        message: json,
        statusCode: statusCode,
        data: null,
      );
    }

    // Handle map responses
    final jsonMap = json as Map<String, dynamic>? ?? {};
    return BaseResponse<T>(
      success: jsonMap['success'] ?? true,
      message: jsonMap['message']?.toString() ?? '',
      statusCode: statusCode,
      data:
          fromJsonT != null && jsonMap['data'] != null
              ? fromJsonT(jsonMap['data'])
              : null,
    );
  }

  factory BaseResponse.error({
    required String message,
    required int statusCode,
  }) {
    return BaseResponse<T>(
      success: false,
      message: message,
      statusCode: statusCode,
      data: null,
    );
  }
}
