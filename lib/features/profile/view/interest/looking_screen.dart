import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/workout_enum_ext.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class LookingScreen extends StatelessWidget {
  LookingScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.looking,
      title: "Looking for",
      subtitle: "Build your connection more",
      list: CommonLists.releationships,
      onTop: (v) {
        // _profileController.selectedLooking.value = v;
        if (_profileFormController.selectedLookingFor.contains(v)) {
          _profileFormController.selectedLookingFor.remove(v);
        } else {
          _profileFormController.selectedLookingFor.add(v);
        }
      },
      isSelected: (v) => _profileFormController.selectedLookingFor.contains(v),
      onTopButton: () {
        List<String> lowerCaseList =
            _profileFormController.selectedLookingFor.toLowerCaseList();

        _profileController.addLookingFor(lowerCaseList);
      },
      appBarTitle: 'Looking for',
    );
  }
}
