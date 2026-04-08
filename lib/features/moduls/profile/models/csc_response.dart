class CscResponse {
  int? statusCode;
  String? status;
  String? message;
  List<String>? data;

  CscResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory CscResponse.fromJson(Map<String, dynamic> json) {
    return CscResponse(
      statusCode: json['statusCode'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
