import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/workout_enum_ext.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class LookingScreen extends StatelessWidget {
  LookingScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.looking,
      title: "Looking for",
      subtitle: "Build your connection more",
      list: CommonLists.releationships,
      onTop: (v) {
        // _profileController.selectedLooking.value = v;
        if (_profileController.selectedLookingFor.contains(v)) {
          _profileController.selectedLookingFor.remove(v);
        } else {
          _profileController.selectedLookingFor.add(v);
        }
      },
      isSelected: (v) => _profileController.selectedLookingFor.contains(v),
      onTopButton: () {
        List<String> lowerCaseList =
            _profileController.selectedLookingFor.toLowerCaseList();

        _profileController.addLookingFor(lookingFor: lowerCaseList);
      },
      appBarTitle: 'Looking for',
    );
  }
}
