import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class ReligionScreen extends StatelessWidget {
  ReligionScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.religion2,
      title: AppStrings.religionTitle,
      subtitle: AppStrings.religionSubtitle,
      list: CommonLists.religions,
      onTop: (v) {
        _profileController.selectedReligion.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedReligion.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        if (_profileController.selectedReligion.value.isNotEmpty) {
          _profileController.addReligion(
            religion: AppMethods.normalizeValue(
              _profileController.selectedReligion.value,
            ),
          );
        }
      },
      appBarTitle: AppStrings.religionAppBarTitle,
    );
  }
}
