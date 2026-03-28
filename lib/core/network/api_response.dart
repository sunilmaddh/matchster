// lib/core/network/base_response.dart
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int statusCode;

  ApiResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    int statusCode,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? true,
      message: json['message']?.toString() ?? '',
      statusCode: statusCode,
      data:
          fromJsonT != null && json['data'] != null
              ? fromJsonT(json['data'])
              : null,
    );
  }

  factory ApiResponse.error({
    required String message,
    required int statusCode,
  }) {
    return ApiResponse<T>(
      success: false,
      message: message,
      statusCode: statusCode,
      data: null,
    );
  }
}
