import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/widgets/preference_list_widget.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_details_list_screen.dart';

class ProfileDetailsSection extends GetView<ProfileController> {
  const ProfileDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreferenceListWidget(
            lifestyle: controller.lifestyle ?? Lifestyle(),
            personal: controller.personal ?? Personal(),
          ),
          10.hBox,
          ProfileDetailsListScreen(
            personal: controller.personal ?? Personal(),
            preference: controller.preferences ?? Preferences(),
            professional: controller.professional ?? Professional(),
            basicInfo: controller.basicInfo ?? BasicInfo(),
          ),
        ],
      ),
    );
  }
}
