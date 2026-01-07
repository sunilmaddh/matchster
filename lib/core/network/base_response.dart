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
    Map<String, dynamic> json,
    int statusCode,
    T Function(dynamic json)? fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'] ?? true,
      message: json['message']?.toString() ?? '',
      statusCode: statusCode,
      data:
          fromJsonT != null && json['data'] != null
              ? fromJsonT(json['data'])
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
