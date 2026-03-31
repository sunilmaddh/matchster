import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/features/common/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';

class ProfileHeaderSection extends StatelessWidget {
  final BasicInfo? basicInfo;
  final Meta? meta;
  final VoidCallback onPreviewTap;

  const ProfileHeaderSection({
    super.key,
    required this.basicInfo,
    required this.meta,
    required this.onPreviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Image.asset(
              AppAssets.profileHeader,
              width: double.infinity,
              height: 145.h,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            height: 69.h,
                            width: 69.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.profileBadgeBorder,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child:
                                  basicInfo?.profilePic != null
                                      ? CommonAssets.networkImage(
                                        basicInfo?.profilePic?.url ?? "",
                                      )
                                      : const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 1,
                          top: -3,
                          child: SvgPicture.asset(AppAssets.badge),
                        ),
                      ],
                    ),
                    20.wBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CommonText.titleMedium(
                              "${basicInfo?.name ?? ''}, ${basicInfo?.age ?? ''}",
                              fontWeight: FontWeight.w700,
                              color: AppColors.whiteColor,
                            ),
                            10.wBox,
                            SvgPicture.asset(AppAssets.verified),
                          ],
                        ),
                        5.hBox,
                        InkWell(
                          onTap: onPreviewTap,
                          child: Container(
                            padding: 15.horizontalPadding + 2.verticalPadding,
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
                  ],
                ),
                15.hBox,
                LinearProgressBarWithBadge(
                  value: meta?.progress?.toDouble() ?? 0,
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
