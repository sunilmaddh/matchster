// To parse this JSON data, do
//
//     final addHieghtResponse = addHieghtResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

AddHieghtResponse addHieghtResponseFromJson(String str) =>
    AddHieghtResponse.fromJson(json.decode(str));

class AddHieghtResponse {
  Height? height;

  AddHieghtResponse({this.height});

  factory AddHieghtResponse.fromJson(Map<String, dynamic> json) =>
      AddHieghtResponse(
        height:
            json["height"] == null ? Height() : Height.fromJson(json["height"]),
      );
}

class Height {
  double? feet;
  double? cm;

  Height({this.feet, this.cm});

  factory Height.fromJson(Map<String, dynamic> json) => Height(
    feet: UtilMethods.doubleValueParser(json["feet"]?.toDouble()),
    cm: UtilMethods.doubleValueParser(json["cm"]?.toDouble()),
  );

  Map<String, dynamic> toJson() => {"feet": feet, "cm": cm};
}
