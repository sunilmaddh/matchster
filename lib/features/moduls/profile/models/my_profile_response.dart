// To parse this JSON data, do
//
//     final myProfilResponse = myProfilResponseFromJson(jsonString);

import 'dart:convert';

import 'package:matchster/core/utils/utils_methods.dart';

MyProfilResponse myProfilResponseFromJson(String str) =>
    MyProfilResponse.fromJson(json.decode(str));

class MyProfilResponse {
  BasicInfo? basicInfo;
  List<HallOfFame>? hallOfFame;
  Lifestyle? lifestyle;
  Preferences? preferences;
  Personal? personal;
  Professional? professional;
  Bio? bio;
  Locations? locations;
  Meta? meta;

  MyProfilResponse({
    this.basicInfo,
    this.hallOfFame,
    this.lifestyle,
    this.preferences,
    this.personal,
    this.professional,
    this.bio,
    this.locations,
    this.meta,
  });

  factory MyProfilResponse.fromJson(Map<String, dynamic> json) =>
      MyProfilResponse(
        basicInfo:
            json["basicInfo"] == null
                ? null
                : BasicInfo.fromJson(json["basicInfo"]),
        hallOfFame: List<HallOfFame>.from(
          UtilMethods.listParser(
            json["hallOfFame"],
          ).map((x) => HallOfFame.fromJson(x)),
        ),
        lifestyle:
            json["lifestyle"] == null
                ? null
                : Lifestyle.fromJson(json["lifestyle"]),
        preferences:
            json["preferences"] == null
                ? null
                : Preferences.fromJson(json["preferences"]),
        personal:
            json["personal"] == null
                ? null
                : Personal.fromJson(json["personal"]),
        professional:
            json["professional"] == null
                ? null
                : Professional.fromJson(json["professional"]),
        bio: json["bio"] == null ? null : Bio.fromJson(json["bio"]),
        locations:
            json["locations"] == null
                ? null
                : Locations.fromJson(json["locations"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );
}

class BasicInfo {
  String? name;
  int? age;
  String? gender;
  String? height;
  ProfilePic? profilePic;

  BasicInfo({this.name, this.age, this.gender, this.height, this.profilePic});

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
    name: UtilMethods.stringParser(json["name"]),
    age: UtilMethods.intParser(json["age"]),
    gender: UtilMethods.stringParser(json["gender"]),
    height: UtilMethods.stringParser(json["height"]),
    profilePic:
        json["profilePic"] == null
            ? ProfilePic()
            : ProfilePic.fromJson(json["profilePic"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "gender": gender,
    "height": height,
  };
}

class ProfilePic {
  String? url;
  String? type;
  String? id;

  ProfilePic({this.url, this.type, this.id});

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
    url: UtilMethods.stringParser(json["url"]),
    type: UtilMethods.stringParser(json["type"]),
    id: UtilMethods.stringParser(json["_id"]),
  );

  Map<String, dynamic> toJson() => {"url": url, "type": type, "_id": id};
}

class Bio {
  String? about;

  Bio({this.about});

  factory Bio.fromJson(Map<String, dynamic> json) =>
      Bio(about: UtilMethods.stringParser(json["about"]));

  Map<String, dynamic> toJson() => {"about": about};
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

class Lifestyle {
  String? workout;
  String? smoking;
  String? drinking;

  Lifestyle({this.workout, this.smoking, this.drinking});

  factory Lifestyle.fromJson(Map<String, dynamic> json) => Lifestyle(
    workout: UtilMethods.stringParser(json["workout"]),
    smoking: UtilMethods.stringParser(json["smoking"]),
    drinking: UtilMethods.stringParser(json["drinking"]),
  );

  Map<String, dynamic> toJson() => {
    "workout": workout,
    "smoking": smoking,
    "drinking": drinking,
  };
  Lifestyle copyWith({String? workout, String? smoking, String? drinking}) {
    return Lifestyle(
      workout: workout ?? this.workout,
      smoking: smoking ?? this.smoking,
      drinking: drinking ?? this.drinking,
    );
  }
}

class Locations {
  CurrentLocation? currentLocation;
  CurrentLocation? homeTown;

  Locations({this.currentLocation, this.homeTown});

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    currentLocation:
        json["currentLocation"] == null
            ? CurrentLocation()
            : CurrentLocation.fromJson(json["currentLocation"]),
    homeTown:
        json["homeTown"] == null
            ? CurrentLocation()
            : CurrentLocation.fromJson(json["homeTown"]),
  );
}

class CurrentLocation {
  Address? address;
  String? type;
  List<double>? coordinates;
  String? updatedAt;

  CurrentLocation({this.address, this.type, this.coordinates, this.updatedAt});

  factory CurrentLocation.fromJson(
    Map<String, dynamic> json,
  ) => CurrentLocation(
    address:
        json["address"] == null ? Address() : Address.fromJson(json["address"]),
    type: UtilMethods.stringParser(json["type"]),
    coordinates:
        json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    updatedAt: UtilMethods.stringParser(json["updatedAt"]),
  );
}

class Address {
  String? label;
  String? city;
  String? state;
  String? country;

  Address({this.label, this.city, this.state, this.country});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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

class Meta {
  int? progress;
  int? completedFields;
  int? totalFields;

  Meta({this.progress, this.completedFields, this.totalFields});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    progress: UtilMethods.intParser(json["progress"]),
    completedFields: UtilMethods.intParser(json["completedFields"]),
    totalFields: UtilMethods.intParser(json["totalFields"]),
  );

  Map<String, dynamic> toJson() => {
    "progress": progress,
    "completedFields": completedFields,
    "totalFields": totalFields,
  };
}

class Personal {
  List<String>? interests;
  List<String>? languages;
  String? zodiacSign;
  String? religion;
  String? qualification;

  Personal({
    this.interests,
    this.languages,
    this.zodiacSign,
    this.religion,
    this.qualification,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    interests:
        json["interests"] == null
            ? []
            : List<String>.from(json["interests"].map((x) => x)),
    languages:
        json["languages"] == null
            ? []
            : List<String>.from(json["languages"].map((x) => x)),
    zodiacSign: UtilMethods.stringParser(json["zodiacSign"]),
    religion: UtilMethods.stringParser(json["religion"]),
    qualification: UtilMethods.stringParser(json["qualification"]),
  );

  Personal copyWith({
    List<String>? interests,
    List<String>? languages,
    String? zodiacSign,
    String? religion,
    String? qualification,
  }) {
    return Personal(
      interests: interests ?? this.interests,

      languages: languages ?? this.languages,

      zodiacSign: zodiacSign ?? this.zodiacSign,
      religion: religion ?? this.religion,
      qualification: qualification ?? this.qualification,
    );
  }
}

class Preferences {
  String? lookingFor;
  String? visibility;

  Preferences({this.lookingFor, this.visibility});

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    lookingFor: UtilMethods.stringParser(json["lookingFor"]),
    visibility: UtilMethods.stringParser(json["visibility"]),
  );

  Map<String, dynamic> toJson() => {
    "lookingFor": lookingFor,
    "visibility": visibility,
  };

  Preferences copyWith({String? lookingFor, String? visibility}) {
    return Preferences(
      lookingFor: lookingFor ?? this.lookingFor,
      visibility: visibility ?? this.visibility,
    );
  }
}

class Professional {
  Work? work;

  Professional({this.work});

  factory Professional.fromJson(Map<String, dynamic> json) => Professional(
    work: json["work"] == null ? Work() : Work.fromJson(json["work"]),
  );

  Map<String, dynamic> toJson() => {"work": work!.toJson()};
}

class Work {
  String? jobTitle;
  String? company;

  Work({this.jobTitle, this.company});

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    jobTitle: UtilMethods.stringParser(json["jobTitle"]),
    company: UtilMethods.stringParser(json["company"]),
  );

  Map<String, dynamic> toJson() => {"jobTitle": jobTitle, "company": company};

  Work copyWith({String? jobTitle, String? company}) {
    return Work(
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? company,
    );
  }
}
