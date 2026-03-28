import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class AlcohalScreen extends StatelessWidget {
  AlcohalScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.alcohal2,
      title: "Do you drink alcohol?",
      subtitle: "Build your connection more",
      list: CommonLists.workouts,
      onTop: (v) {
        _profileFormController.selectedDrinking.value = v;
      },
      isSelected:
          (v) =>
              _profileFormController.selectedDrinking.value
                  .toLowerCase()
                  .trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addDrinking(
          _profileFormController.selectedDrinking.value,
        );
      },
      appBarTitle: 'Drinking',
    );
  }
}
