import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class SmokeScreen extends StatelessWidget {
  SmokeScreen({super.key});
  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.smoke2,
      title: "Do you smoke?",
      subtitle: "Build your connection more",
      list: CommonLists.workouts,
      onTop: (v) {
        _profileController.selectedSmoke.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedSmoke.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addSmoking(
          smoking: _profileController.selectedSmoke.value,
        );
      },
      appBarTitle: 'Smoking',
    );
  }
}
