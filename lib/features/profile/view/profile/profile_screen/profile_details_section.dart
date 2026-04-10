import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/preference_list_widget.dart';
import 'package:matchster/features/profile/widgets/profile_details_list_screen.dart';

class ProfileDetailsSection extends StatelessWidget {
  const ProfileDetailsSection({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => PreferenceListWidget(
              lifestyle: controller.lifestyle.value,
              personal: controller.personal.value,
            ),
          ),
          10.hBox,
          Obx(
            () => ProfileDetailsListScreen(
              personal: controller.personal.value,
              preference: controller.prefeence.value,
              professional: controller.professional.value,
              basicInfo: controller.basicInfo.value,
            ),
          ),
        ],
      ),
    );
  }
}
