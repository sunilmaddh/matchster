import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.workout2,
      title: "Do you work out?",
      subtitle: "Build your connection more",
      list: CommonLists.workouts,
      onTop: (v) {
        _profileFormController.selectedWorkout.value = v;
      },
      isSelected:
          (v) =>
              _profileFormController.selectedWorkout.value
                  .toLowerCase()
                  .trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addWorkout(
          _profileFormController.selectedWorkout.value,
        );
      },
      appBarTitle: 'Workout',
    );
  }
}
