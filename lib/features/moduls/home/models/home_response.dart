// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

class HomeResponse {
  int? page;
  int? limit;
  int? total;
  List<Profile>? profiles;

  HomeResponse({this.page, this.limit, this.total, this.profiles});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    page: UtilMethods.intParser(json["page"]),
    limit: UtilMethods.intParser(json["limit"]),
    total: UtilMethods.intParser(json["total"]),
    profiles: List<Profile>.from(
      UtilMethods.listParser(json["profiles"]).map((x) => Profile.fromJson(x)),
    ),
  );
}

class Profile {
  String? userId;
  String? name;
  int? age;
  String? distance;
  String? gender;
  String? smoking;
  String? drinking;
  List<String>? interests;
  List<String>? languages;
  String? lookingFor;

  String? zodiacSign;
  String? religion;
  String? work;
  String? mainPhoto;
  List<dynamic>? morePictures;
  String? height;
  String? currentAddress;
  String? about;

  Profile({
    this.userId,
    this.name,
    this.age,
    this.distance,
    this.gender,
    this.smoking,
    this.drinking,
    this.interests,
    this.languages,
    this.lookingFor,
    this.zodiacSign,
    this.religion,
    this.work,
    this.mainPhoto,
    this.morePictures,
    this.height,
    this.currentAddress,
    this.about,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userId: UtilMethods.stringParser(json["userId"]),
    name: UtilMethods.stringParser(json["name"]),
    age: UtilMethods.intParser(json["age"]),
    distance: UtilMethods.stringParser(json["distance"]),
    gender: UtilMethods.stringParser(json["gender"]),
    smoking: UtilMethods.stringParser(json["smoking"]),
    drinking: UtilMethods.stringParser(json["drinking"]),
    interests: List<String>.from(
      UtilMethods.listParser(json["interests"]).map((x) => x),
    ),
    languages: List<String>.from(
      UtilMethods.listParser(json["languages"]).map((x) => x),
    ),
    lookingFor: UtilMethods.stringParser(json["lookingFor"]),

    zodiacSign: UtilMethods.stringParser(json["zodiacSign"]),
    religion: UtilMethods.stringParser(json["religion"]),
    work: UtilMethods.stringParser(json["work"]),
    mainPhoto: UtilMethods.stringParser(json["mainPhoto"]),
    morePictures: List<dynamic>.from(
      UtilMethods.listParser(json["morePictures"]).map((x) => x),
    ),
    height: UtilMethods.stringParser(json["height"]),
    currentAddress: UtilMethods.stringParser(json["currentAddress"]),
    about: UtilMethods.stringParser(json["about"]),
  );
}
