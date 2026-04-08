import 'dart:convert';
import 'package:matchster/core/utils/utils_methods.dart';

AddGenderResponse addGenderResponseFromJson(String str) =>
    AddGenderResponse.fromJson(json.decode(str));

String addGenderResponseToJson(AddGenderResponse data) =>
    json.encode(data.toJson());

class AddGenderResponse {
  String? gender;
  bool? genderPreview;

  AddGenderResponse({this.gender, this.genderPreview});

  factory AddGenderResponse.fromJson(Map<String, dynamic> json) =>
      AddGenderResponse(
        gender: UtilMethods.stringParser(json["gender"]),
        genderPreview: UtilMethods.boolValueParser(json["genderPreview"]),
      );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "genderPreview": genderPreview,
  };
}
