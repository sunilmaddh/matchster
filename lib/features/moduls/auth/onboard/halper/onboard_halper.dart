import 'package:flutter/cupertino.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/features/moduls/auth/onboard/view/face_recognisation.dart';
import 'package:matchster/features/moduls/auth/widgets/name_widget.dart';

class OnboardHalper {
  static const List<String> radioList = ["Man", "Woman", "Non-Binary"];

  static const List<Map<String, dynamic>> likeList = [
    {"value": "Baking", "image": AppAssets.bakimgAssets},
    {"value": "Gym", "image": AppAssets.gymAssets},
    {"value": "Music", "image": AppAssets.musicAssets},
    {"value": "Travel", "image": AppAssets.travelAssets},
    {"value": "Cooking", "image": AppAssets.cookAssets},
    {"value": "Games", "image": AppAssets.gamesAssets},
    {"value": "Pets", "image": AppAssets.petAssets},
    {"value": "Movies", "image": AppAssets.moviesAssets},
    {"value": "Dancing", "image": AppAssets.danceAssets},
  ];

  static const List<String> languegeList = [
    "Hindi",
    "Englsih",
    "Gujarati",
    "Assamese",
    "Bengali",
    "Marathi",
    "Nepali",
    "Spanish",
    "French",
    "Urdu",
    "Arabic",
    "Russian",
  ];

  static List<Widget> listWidget = [
    NameWidget(),
    GenderWidget(),
    DobWidget(),
    YourHeightWidget(),
    LikeWidget(),
    LanguageListWidget(),
    ReligionWidget(),
    DateWidget(),
    AddPhotoWidget(),
    FaceRecogonizationWidget(),
  ];

  static const List<Map<String, dynamic>> addPhotoOption = [
    {"image": AppAssets.instagramAssets, "text": "Instagram"},
    {"image": AppAssets.facebookAssets, "text": "Facebook"},
    {"image": AppAssets.fileAssets, "text": "File"},
    {"image": AppAssets.cameraAssets, "text": "Camera"},
  ];

  static const List<String> dateList = ["Man", "Woman", "Others"];

  static List<String> heightListFeet = List.generate(
    7,
    (index) => (index + 3).toString(),
  );
  static List<String> heightListInch = List.generate(
    12,
    (index) => (index + 0).toString(),
  );
  static List<String> heightListCm = List.generate(
    123,
    (index) => (index + 91).toString(),
  );
  static List<String> heightListCmDecimal = List.generate(
    100,
    (index) => (index + 0).toString(),
  );

  static const List<String> religionList = [
    "Doesn't Matter",
    "Hindu",
    "Agnostic",
    "Atheist",
    "Christian",
    "Muslim",
    "Buddhist",
    "Jain",
    "Sikh",
    "Hindu",
    "Agnostic",
    "Atheist",
    "Christian",
    "Muslim",
    "Buddhist",
    "Jain",
    "Sikh",
  ];
}
