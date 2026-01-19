// To parse this JSON data, do
//
//     final reverseGeocodeResponse = reverseGeocodeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

ReverseGeocodeResponse reverseGeocodeResponseFromJson(String str) =>
    ReverseGeocodeResponse.fromJson(json.decode(str));

String reverseGeocodeResponseToJson(ReverseGeocodeResponse data) =>
    json.encode(data.toJson());

class ReverseGeocodeResponse {
  Address address;

  ReverseGeocodeResponse({required this.address});

  factory ReverseGeocodeResponse.fromJson(Map<String, dynamic> json) =>
      ReverseGeocodeResponse(address: Address.fromJson(json["address"]));

  Map<String, dynamic> toJson() => {"address": address.toJson()};
}

class Address {
  double? lat;
  double? lng;
  PlaceDetails? placeDetails;

  Address({this.lat, this.lng, this.placeDetails});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    lat: UtilMethods.doubleValueParser(json["lat"]?.toDouble()),
    lng: UtilMethods.doubleValueParser(json["lng"]?.toDouble()),
    placeDetails:
        json["placeDetails"] == null
            ? PlaceDetails()
            : PlaceDetails.fromJson(json["placeDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "placeDetails": placeDetails!.toJson(),
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
