import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class LookingScreen extends StatelessWidget {
  LookingScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      isSelctOnlyOne: true,
      image: AppAssets.looking,
      title: AppStrings.lookingForTitle,
      subtitle: AppStrings.lookingForSubtitle,
      list: CommonLists.releationships,

      onTop: (v) {
        _profileController.selectedLookingFor.value = v;
      },

      isSelected:
          (v) =>
              _profileController.selectedLookingFor.toLowerCase().trim() ==
              v.toLowerCase().trim(),

      onTopButton: () {
        if (_profileController.selectedLookingFor.isEmpty) return;
        _profileController.addLookingFor(
          lookingFor: _profileController.selectedLookingFor.toLowerCase(),
        );
      },

      appBarTitle: AppStrings.lookingForAppBarTitle,
    );
  }
}
