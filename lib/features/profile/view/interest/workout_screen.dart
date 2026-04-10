import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.workout2,
      title: AppStrings.workoutTitle,
      subtitle: AppStrings.workoutSubtitle,
      list: CommonLists.workouts,
      onTop: (v) {
        _profileController.selectedWorkout.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedWorkout.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        if (_profileController.selectedWorkout.value.isNotEmpty) {
          _profileController.addWorkout(
            workout: _profileController.selectedWorkout.value,
          );
        }
      },
      appBarTitle: AppStrings.workoutAppBarTitle,
    );
  }
}
