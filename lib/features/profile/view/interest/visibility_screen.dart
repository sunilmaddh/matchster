import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class VisibilityScreen extends StatelessWidget {
  VisibilityScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.visibility2,
      title: "Set profile visibility",
      subtitle: "My profile should be visible to",
      list: CommonLists.visibilities,
      onTop: (v) {
        _profileFormController.selectedVisibility.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected:
          (v) =>
              _profileFormController.selectedVisibility.value
                  .toLowerCase()
                  .trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addVisibility(
          _profileFormController.selectedVisibility.value
              .toSnakeCaseLowerCase(),
        );
      },
      appBarTitle: 'Profile visibility',
    );
  }
}
