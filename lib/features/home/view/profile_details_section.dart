import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/address_x_ext.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/sub_common_card.dart';

class ProfileDetailsSection extends StatelessWidget {
  const ProfileDetailsSection({
    super.key,
    required this.data,
    required this.controller,
  });
  final Profile data;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -18),
      child: Container(
        width: double.infinity,
        padding: 40.verticalPadding + 15.horizontalPadding,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: 20.horizontalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonText.text(
                      "${data.name}, ${data.age}",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Caros",
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            10.hBox,

            if (data.about != null && data.about!.isNotEmpty)
              CommonHomeCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text("In Short", color: AppColors.whiteColor),
                    CommonText.text(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Caros",
                      maxLines: 7,
                      fontStyle: FontStyle.italic,
                      color: AppColors.whiteColor,
                      "“${data.about}.”",
                    ),

                    20.hBox,

                    InshortWrapWidget(list: controller.inshortList),
                  ],
                ),
              ).paddingOnly(bottom: 15.h)
            else
              SizedBox.shrink(),

            if (data.lookingFor != null && data.lookingFor!.isNotEmpty)
              CommonHomeCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      "Looking For",
                      color: AppColors.whiteColor,
                      fontFamily: "Caros",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,

                    LookingWrapWidget(list: data.lookingFor!),
                  ],
                ),
              ).paddingOnly(bottom: 15.h)
            else
              SizedBox.shrink(),

            if (data.distance != null && data.distance!.isNotEmpty)
              CommonHomeCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      "Location",
                      color: AppColors.whiteColor,
                      fontFamily: "Caros",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,

                    // ),
                    CommonCard(
                      widget: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: 7.allPadding,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffF4F4F4),
                            ),
                            child: CommonText.text("📍"),
                          ),
                          5.wBox,
                          CommonText.text(
                            color: Color(0xffD90380),
                            "${data.distance.toString()} km",
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                          5.wBox,
                          CommonText.text(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            "away, ${data.currentAddress!.city}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox.shrink(),
            15.hBox,
            if (data.interests != null && data.interests!.isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      "My Interest",
                      fontFamily: "Caros",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    CommonText.text(
                      "Express your interests to find your ideal match",
                      fontFamily: "Caros",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    10.hBox,
                    InterestWrapWidget(list: data.interests!),
                  ],
                ),
              ).paddingOnly(bottom: 15.h)
            else
              SizedBox.shrink(),

            if (data.work != null && data.work!.isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      "Profession",
                      fontFamily: "Caros",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    5.hBox,
                    SubCommonCard(widget: CommonText.text(data.work!)),
                  ],
                ),
              )
            else
              SizedBox.shrink(),
            15.hBox,
            if (data.morePictures != null && data.morePictures!.isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      "More Picture",
                      fontFamily: "Caros",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: CommonAssets.networkImage(
                        data.morePictures!.first,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 15.h)
            else
              const SizedBox.shrink(),

            if (data.languages != null && data.languages!.isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      "Language",
                      color: AppColors.blackColor,
                      fontFamily: "Caros",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,

                    InterestWrapWidget(list: data.languages!),
                  ],
                ),
              ).paddingOnly(bottom: 15.h)
            else
              SizedBox.shrink(),

            if (data.morePictures != null && data.morePictures!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Images list
                  Column(
                    children: List.generate(data.morePictures!.length - 1, (
                      index,
                    ) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: CommonCard(
                          widget: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: CommonAssets.networkImage(
                              data.morePictures![index + 1],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
