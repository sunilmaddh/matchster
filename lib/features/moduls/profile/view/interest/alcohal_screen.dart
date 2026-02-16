import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class AlcohalScreen extends StatelessWidget {
  AlcohalScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.alcohal2,
      title: "Do you drink alcohol?",
      subtitle: "Build your connection more",
      list: CommonLists.workouts,
      onTop: (v) {
        _profileController.selectedDrinking.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedDrinking.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addDrinkking(
          drinking: _profileController.selectedDrinking.value,
        );
      },
      appBarTitle: 'Drinking',
    );
  }
}
