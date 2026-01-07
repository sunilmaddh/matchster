// To parse this JSON data, do
//
//     final addDobResponse = addDobResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

AddDobResponse addDobResponseFromJson(String str) =>
    AddDobResponse.fromJson(json.decode(str));

class AddDobResponse {
  String? dob;
  int? age;

  AddDobResponse({this.dob, this.age});

  factory AddDobResponse.fromJson(Map<String, dynamic> json) => AddDobResponse(
    dob: UtilMethods.stringParser(json["dob"]),
    age: UtilMethods.intParser(json["age"]),
  );
}
