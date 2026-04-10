import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/complete_profile_hint.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_avatar.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_name_and_preview.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 10.horizontalPadding,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              width: double.infinity,
              height: 200.h,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Image.asset(
                AppAssets.profileHeader,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ProfileAvatar(controller: controller),
                    20.wBox,
                    ProfileNameAndPreview(controller: controller),
                  ],
                ),
                15.hBox,
                LinearProgressBarWithBadge(
                  value: controller.meta.value.progress?.toDouble() ?? 0.0,
                  onChanged: (_) {},
                ),
                5.hBox,
                if ((controller.meta.value.progress?.toDouble() ?? 0.0) < 100)
                  const CompleteProfileHint(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
