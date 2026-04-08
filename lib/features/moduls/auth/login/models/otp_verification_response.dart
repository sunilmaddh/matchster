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
  OnboardPages? pages;
  PageValues? values;

  OtpVerificationResponse({
    this.verified,
    this.accessToken,
    this.pages,
    this.values,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerificationResponse(
        verified: UtilMethods.boolValueParser(json["verified"]),
        accessToken: UtilMethods.stringParser(json["accessToken"]),
        pages:
            json["pages"] == null
                ? OnboardPages()
                : OnboardPages.fromJson(json["pages"]),
        values:
            json["values"] == null
                ? PageValues()
                : PageValues.fromJson(json["values"]),
      );
}

class OnboardPages {
  bool? name;
  bool? gender;
  bool? dob;
  bool? height;
  bool? dateWith;
  bool? allOfame;

  OnboardPages({
    this.name,
    this.gender,
    this.dob,
    this.height,
    this.dateWith,
    this.allOfame,
  });

  factory OnboardPages.fromJson(Map<String, dynamic> json) => OnboardPages(
    name: UtilMethods.boolValueParser(json["name"]),
    gender: UtilMethods.boolValueParser(json["gender"]),
    dob: UtilMethods.boolValueParser(json["dob"]),
    height: UtilMethods.boolValueParser(json["height"]),
    dateWith: UtilMethods.boolValueParser(json["dateWith"]),
    allOfame: UtilMethods.boolValueParser(json["hallOfFame"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "dob": dob,
    "height": height,
    "dateWith": dateWith,
    "hallOfFame": allOfame,
  };
}

class PageValues {
  String? name;
  String? gender;
  String? dob;
  Height? height;
  List<String>? dateWith;
  List<HallOfFame>? hallOfFame;

  PageValues({
    this.name,
    this.gender,
    this.dob,
    this.height,
    this.dateWith,
    this.hallOfFame,
  });

  factory PageValues.fromJson(Map<String, dynamic> json) => PageValues(
    name: UtilMethods.stringParser(json["name"]),
    gender: UtilMethods.stringParser(json["gender"]),
    dob: UtilMethods.stringParser(json["dob"]),
    height: json["height"] == null ? Height() : Height.fromJson(json["height"]),
    dateWith: List<String>.from(
      UtilMethods.listParser(json["dateWith"]).map((x) => x),
    ),
    hallOfFame: List<HallOfFame>.from(
      UtilMethods.listParser(
        json["hallOfFame"],
      ).map((x) => HallOfFame.fromJson(x)),
    ),
  );
}

class HallOfFame {
  String? url;
  String? type;
  String? id;

  HallOfFame({this.url, this.type, this.id});

  factory HallOfFame.fromJson(Map<String, dynamic> json) => HallOfFame(
    url: UtilMethods.stringParser(json["url"]),
    type: UtilMethods.stringParser(json["type"]),
    id: UtilMethods.stringParser(json["_id"]),
  );

  Map<String, dynamic> toJson() => {"url": url, "type": type, "_id": id};
}

class Height {
  double? feet;
  double? cm;

  Height({this.feet, this.cm});

  factory Height.fromJson(Map<String, dynamic> json) => Height(
    feet: UtilMethods.doubleValueParser(json["feet"]).toDouble(),
    cm: UtilMethods.doubleValueParser(json["cm"]).toDouble(),
  );

  Map<String, dynamic> toJson() => {"feet": feet, "cm": cm};
}
