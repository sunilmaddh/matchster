// To parse this JSON data, do
//
//     final addDateWithResponse = addDateWithResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

AddDateWithResponse addDateWithResponseFromJson(String str) =>
    AddDateWithResponse.fromJson(json.decode(str));

String addDateWithResponseToJson(AddDateWithResponse data) =>
    json.encode(data.toJson());

class AddDateWithResponse {
  String? dateWith;

  AddDateWithResponse({this.dateWith});

  factory AddDateWithResponse.fromJson(Map<String, dynamic> json) =>
      AddDateWithResponse(dateWith: UtilMethods.stringParser(json["dateWith"]));

  Map<String, dynamic> toJson() => {"dateWith": dateWith};
}
