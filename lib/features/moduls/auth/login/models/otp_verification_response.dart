// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

OtpVerificationResponse otpVerificationResponseFromJson(String str) =>
    OtpVerificationResponse.fromJson(json.decode(str));

class OtpVerificationResponse {
  bool? verified;
  String? accessToken;
  Pages? pages;

  OtpVerificationResponse({this.verified, this.accessToken, this.pages});

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerificationResponse(
        verified: UtilMethods.boolValueParser(json["verified"]),
        accessToken: UtilMethods.stringParser(json["accessToken"]),
        pages: json["pages"] == null ? Pages() : Pages.fromJson(json["pages"]),
      );
}

class Pages {
  bool? name;
  bool? gender;
  bool? dob;
  bool? height;
  bool? dateWith;
  bool? allOfame;

  Pages({
    this.name,
    this.gender,
    this.dob,
    this.height,
    this.dateWith,
    this.allOfame,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    name: UtilMethods.boolValueParser(json["name"]),
    gender: UtilMethods.boolValueParser(json["gender"]),
    dob: UtilMethods.boolValueParser(json["dob"]),
    height: UtilMethods.boolValueParser(json["height"]),
    dateWith: UtilMethods.boolValueParser(json["dateWith"]),
    allOfame: UtilMethods.boolValueParser(json["allOfame"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "dob": dob,
    "height": height,
    "dateWith": dateWith,
    "allOfame": allOfame,
  };
}
