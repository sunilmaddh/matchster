// To parse this JSON data, do
//
//     final addNameResponse = addNameResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

AddNameResponse addNameResponseFromJson(String str) =>
    AddNameResponse.fromJson(json.decode(str));

String addNameResponseToJson(AddNameResponse data) =>
    json.encode(data.toJson());

class AddNameResponse {
  String? name;

  AddNameResponse({this.name});

  factory AddNameResponse.fromJson(Map<String, dynamic> json) =>
      AddNameResponse(name: UtilMethods.stringParser(json["name"]));

  Map<String, dynamic> toJson() => {"name": name};
}
