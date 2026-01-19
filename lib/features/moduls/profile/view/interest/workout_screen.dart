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
      title: "Workout Frequency",
      subtitle: "How often do you work out?",
      list: CommonLists.workouts,
      onTop: (v) {
        _profileController.selectedWorkout.value = v;
      },
      isSelected: (v) => _profileController.selectedWorkout.contains(v),
      onTopButton: () {
        _profileController.addWorkout(
          workout: _profileController.selectedWorkout.value,
        );
      },
    );
  }
}
