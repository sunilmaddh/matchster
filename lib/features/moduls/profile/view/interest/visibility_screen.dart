import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class VisibilityScreen extends StatelessWidget {
  VisibilityScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.visibility2,
      title: "Set profile visibility",
      subtitle: "My profile should be visible to",
      list: CommonLists.visibilities,
      onTop: (v) {
        _profileController.selectedVisibility.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected: (v) => _profileController.selectedVisibility.contains(v),
      onTopButton: () {
        _profileController.addVisibility(
          visibility: _profileController.selectedVisibility.value.toLowerCase(),
        );
      },
    );
  }
}
