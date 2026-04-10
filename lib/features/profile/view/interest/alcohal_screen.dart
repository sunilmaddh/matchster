import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class AlcohalScreen extends StatelessWidget {
  AlcohalScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.alcohal2,
      title: AppStrings.drinkingTitle,
      subtitle: AppStrings.drinkingSubtitle,
      list: CommonLists.workouts,
      onTop: (v) {
        _profileController.selectedDrinking.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedDrinking.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        if (_profileController.selectedDrinking.value.isNotEmpty) {
          _profileController.addDrinkking(
            drinking: _profileController.selectedDrinking.value,
          );
        }
      },
      appBarTitle: AppStrings.drinkingAppBarTitle,
    );
  }
}
