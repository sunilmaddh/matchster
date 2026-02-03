import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/features/moduls/auth/onboard/view/add_photo_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/view/data_with_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/view/dob_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/view/gender_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/view/hieght_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/view/name_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/view/name_widget.dart';

enum OnboardStep { name, gender, dob, height, dateWith, allOfame }

class OnboardHalper {
  static const List<String> radioList = ["Men", "Women", "Others"];

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
    DateWidget(),
    AddPhotoWidget(),
  ];

  static const List<Map<String, dynamic>> addPhotoOption = [
    {"image": AppAssets.instagramAssets, "text": "Instagram"},
    {"image": AppAssets.facebookAssets, "text": "Facebook"},
    {"image": AppAssets.fileAssets, "text": "File"},
    {"image": AppAssets.cameraAssets, "text": "Camera"},
  ];

  static const List<String> dateList = ["men", "women", "others"];

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
  static final List<OnboardStep> steps = [
    OnboardStep.name,
    OnboardStep.gender,
    OnboardStep.dob,
    OnboardStep.height,
    OnboardStep.dateWith,
    OnboardStep.allOfame,
  ];

  List<HeightItem> generateHeightList() {
    final List<HeightItem> list = [];

    for (int feet = 5; feet <= 7; feet++) {
      for (int inch = 0; inch < 12; inch++) {
        // Min = 5'1"
        if (feet == 5 && inch < 0) continue;

        // Max = 7'10"
        if (feet == 7 && inch > 0) break;

        final double cm = ((feet * 12 + inch) * 2.54);

        list.add(
          HeightItem(
            feet: feet,
            inch: inch,
            cm: cm,
            label: "$feet feet  $inch inch  (${cm.toStringAsFixed(2)} cm)",
          ),
        );
      }
    }
    return list;
  }
}

class HeightItem {
  final int feet;
  final int inch;
  final double cm;
  final String label;

  HeightItem({
    required this.feet,
    required this.inch,
    required this.cm,
    required this.label,
  });
}
