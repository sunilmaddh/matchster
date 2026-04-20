import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/circle_gradiant_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.image,
    required this.titleImage,
    required this.badgeImage,
  });
  final String title;
  final String subTitle;
  final String date;
  final String image;
  final String titleImage;
  final String badgeImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 70.h,
          width: 70.w,
          child: Stack(
            children: [
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.progressDissableColor,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.20),
                    width: 1.5.w,
                  ),
                ),
                child: ClipOval(
                  child:
                      badgeImage.isNotEmpty
                          ? CommonAssets.networkImage(badgeImage)
                          : Image.asset(
                            AppAssets.imageAssets2,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 4,
                child: Container(
                  padding: 3.allPadding,
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor,
                  ),
                  child: CircleGradiantCard(
                    widget: SvgPicture.asset(
                      AppAssets.likeAssets,
                    ).paddingAll(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CommonText.titleMedium(title),
                  titleImage.isNotEmpty
                      ? CommonAssets.networkImage(titleImage)
                      : Image.asset(
                        AppAssets.celebrationAssets,
                        height: 24.h,
                        width: 24.w,
                      ),
                ],
              ),
              CommonText.labelMedium(
                subTitle,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              CommonText.labelMedium(
                date,
                fontWeight: FontWeight.w400,
                color: AppColors.notificationGreyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
