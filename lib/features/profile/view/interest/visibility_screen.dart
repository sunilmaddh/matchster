import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class VisibilityScreen extends StatelessWidget {
  VisibilityScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.visibility2,
      title: AppStrings.visibilityTitle,
      subtitle: AppStrings.visibilitySubtitle,
      list: CommonLists.visibilities,
      onTop: (v) {
        _profileController.selectedVisibility.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedVisibility.value
                  .toLowerCase()
                  .trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        if (_profileController.selectedVisibility.value.isNotEmpty) {
          _profileController.addVisibility(
            visibility:
                _profileController.selectedVisibility.value
                    .toSnakeCaseLowerCase(),
          );
        }
      },
      appBarTitle: AppStrings.visibilityAppBarTitle,
    );
  }
}
