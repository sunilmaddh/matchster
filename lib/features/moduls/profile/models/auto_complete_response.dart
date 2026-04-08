// To parse this JSON data, do
//
//     final autoCompleteResponse = autoCompleteResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

List<AutoCompleteResponse> autoCompleteResponseFromJson(String str) =>
    List<AutoCompleteResponse>.from(
      json.decode(str).map((x) => AutoCompleteResponse.fromJson(x)),
    );

String autoCompleteResponseToJson(List<AutoCompleteResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutoCompleteResponse {
  String? description;
  String? placeId;
  String? mainText;
  String? secondaryText;

  AutoCompleteResponse({
    this.description,
    this.placeId,
    this.mainText,
    this.secondaryText,
  });

  factory AutoCompleteResponse.fromJson(Map<String, dynamic> json) =>
      AutoCompleteResponse(
        description: UtilMethods.stringParser(json["description"]),
        placeId: UtilMethods.stringParser(json["place_id"]),
        mainText: UtilMethods.stringParser(json["main_text"]),
        secondaryText: UtilMethods.stringParser(json["secondaryText"]),
      );

  Map<String, dynamic> toJson() => {
    "description": description,
    "place_id": placeId,
    "main_text": mainText,
    "secondaryText": secondaryText,
  };
}
