import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/features/common/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final progress = controller.meta?.progress?.toDouble() ?? 0;
    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = screenWidth * 0.04;
    final innerPadding = screenWidth * 0.03;
    final avatarSize = screenWidth * 0.18;
    final avatarBorderWidth = screenWidth * 0.008;
    final gap = screenWidth * 0.05;
    final badgeTopOffset = -(screenWidth * 0.008);
    final badgeRightOffset = screenWidth * 0.004;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.asset(
                AppAssets.profileHeader,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(innerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Container(
                              padding: EdgeInsets.all(2.r),
                              height: avatarSize,
                              width: avatarSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.profileBadgeBorder,
                                  width: avatarBorderWidth,
                                ),
                              ),
                              child: ClipOval(
                                child:
                                    controller.basicInfo?.profilePic != null
                                        ? CommonAssets.networkImage(
                                          controller
                                                  .basicInfo
                                                  ?.profilePic
                                                  ?.url ??
                                              '',
                                          fit: BoxFit.cover,
                                        )
                                        : Container(
                                          color: AppColors.whiteColor,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: AppColors.primary,
                                            size: avatarSize * 0.32,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: badgeRightOffset,
                            top: badgeTopOffset,
                            child: SvgPicture.asset(
                              AppAssets.badge,
                              height: avatarSize * 0.28,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: gap),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  CommonText.titleMedium(
                                    "${controller.basicInfo?.name ?? ''}, ${controller.basicInfo?.age ?? ''}",
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteColor,
                                  ),
                                  SvgPicture.asset(
                                    AppAssets.verified,
                                    height: 18,
                                  ),
                                ],
                              ),
                            ),
                            5.hBox,
                            InkWell(
                              onTap: () {
                                controller.navigateTo(
                                  AppRoutes.profilePreviewScreen,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenWidth * 0.008,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: AppColors.previewBorder,
                                  ),
                                ),
                                child: CommonText.labelLarge(
                                  AppStrings.preview,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor.withAlpha(153),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.035),
                  LinearProgressBarWithBadge(
                    value: progress,
                    onChanged: (_) {},
                  ),
                  if (progress < 100) ...[
                    SizedBox(height: screenWidth * 0.025),
                    const _ProfileCompletionCard(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCompletionCard extends StatelessWidget {
  const _ProfileCompletionCard();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.lightBlackBorder),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.all(screenWidth * 0.012),
            child: Image.asset(
              AppAssets.userBadge,
              height: screenWidth * 0.04,
              width: screenWidth * 0.04,
            ),
          ),
          SizedBox(width: screenWidth * 0.025),
          Expanded(
            child: CommonText.bodySmall(
              AppStrings.completeYourProfileMessage,
              maxLines: 2,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
