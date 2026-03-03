import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});

  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.workout2,
      title: "Do you work out?",
      subtitle: "Build your connection more",
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
      appBarTitle: 'Workout',
    );
  }
}
