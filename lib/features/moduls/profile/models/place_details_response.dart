// To parse this JSON data, do
//
//     final placeDetailsResponse = placeDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

PlaceDetailsResponse placeDetailsResponseFromJson(String str) =>
    PlaceDetailsResponse.fromJson(json.decode(str));

String placeDetailsResponseToJson(PlaceDetailsResponse data) =>
    json.encode(data.toJson());

class PlaceDetailsResponse {
  double? lat;
  double? lng;
  PlaceDetails? placeDetails;
  String? placeId;

  PlaceDetailsResponse({this.lat, this.lng, this.placeDetails, this.placeId});

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PlaceDetailsResponse(
        lat: UtilMethods.doubleValueParser(json["lat"]?.toDouble()),
        lng: UtilMethods.doubleValueParser(json["lng"]?.toDouble()),
        placeDetails:
            json["placeDetails"] == null
                ? PlaceDetails()
                : PlaceDetails.fromJson(json["placeDetails"]),
        placeId: json["placeId"],
      );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "placeDetails": placeDetails!.toJson(),
    "placeId": placeId,
  };
}

class PlaceDetails {
  String? label;
  String? city;
  String? state;
  String? country;

  PlaceDetails({this.label, this.city, this.state, this.country});

  factory PlaceDetails.fromJson(Map<String, dynamic> json) => PlaceDetails(
    label: UtilMethods.stringParser(json["label"]),
    city: UtilMethods.stringParser(json["city"]),
    state: UtilMethods.stringParser(json["state"]),
    country: UtilMethods.stringParser(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "city": city,
    "state": state,
    "country": country,
  };
}
