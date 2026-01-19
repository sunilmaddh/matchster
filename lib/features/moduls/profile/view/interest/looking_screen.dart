import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

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
        _profileController.selectedLooking.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected: (v) => _profileController.selectedLooking.contains(v),
      onTopButton: () {
        _profileController.addLookingFor(
          lookingFor: _profileController.selectedLooking.value.toLowerCase(),
        );
      },
    );
  }
}
