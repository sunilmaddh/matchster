// To parse this JSON data, do
//
//     final uploadPhotoResponse = uploadPhotoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

UploadPhotoResponse uploadPhotoResponseFromJson(String str) =>
    UploadPhotoResponse.fromJson(json.decode(str));

String uploadPhotoResponseToJson(UploadPhotoResponse data) =>
    json.encode(data.toJson());

class UploadPhotoResponse {
  String? url;
  String? key;
  String? type;

  UploadPhotoResponse({this.url, this.key, this.type});

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) =>
      UploadPhotoResponse(
        url: UtilMethods.stringParser(json["url"]),
        key: UtilMethods.stringParser(json["key"]),
        type: UtilMethods.stringParser(json["type"]),
      );

  Map<String, dynamic> toJson() => {"url": url, "key": key, "type": type};
}
