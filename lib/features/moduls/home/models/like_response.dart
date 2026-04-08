// To parse this JSON data, do
//
//     final likeResponse = likeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

LikeResponse likeResponseFromJson(String str) =>
    LikeResponse.fromJson(json.decode(str));

// String likeResponseToJson(LikeResponse data) => json.encode(data.toJson());

class LikeResponse {
  List<Datum> data;
  Pagination pagination;

  LikeResponse({required this.data, required this.pagination});

  factory LikeResponse.fromJson(Map<String, dynamic> json) => LikeResponse(
    data: List<Datum>.from(
      UtilMethods.listParser(json["data"]).map((x) => Datum.fromJson(x)),
    ),
    pagination:
        json["pagination"] == null
            ? Pagination.fromJson(json["pagination"])
            : Pagination(),
  );
}

class Datum {
  String? userId;
  String? name;
  int? age;
  String? distance;
  String? gender;
  String? smoking;
  String? drinking;
  List<String>? interests;
  List<String>? languages;
  List<String>? lookingFor;
  String? zodiacSign;
  String? religion;
  String? work;
  String? mainPhoto;
  List<dynamic>? morePictures;
  String? height;
  String? currentAddress;
  String? about;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    lookingFor: List<String>.from(
      UtilMethods.listParser(json["lookingFor"]).map((x) => x),
    ),
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

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Pagination({this.page, this.limit, this.total, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: UtilMethods.intParser(json["page"]),
    limit: UtilMethods.intParser(json["limit"]),
    total: UtilMethods.intParser(json["total"]),
    totalPages: UtilMethods.intParser(json["totalPages"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
  };
}
