import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
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

class HomeProfileDetailsSection extends StatelessWidget {
  const HomeProfileDetailsSection({
    super.key,
    required this.data,
    required this.controller,
  });

  final Profile data;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final city = data.currentAddress?.city ?? "";
    final distance = data.distance ?? "";

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
            /// Name + Age
            Padding(
              padding: 20.horizontalPadding,
              child: Row(
                children: [
                  Expanded(
                    child: CommonText.titleMedium(
                      "${data.name}, ${data.age}",
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            10.hBox,

            /// In Short
            if ((data.about ?? "").isNotEmpty)
              CommonHomeCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.text(
                      AppStrings.inShort,
                      color: AppColors.whiteColor,
                    ),
                    CommonText.displaySmall(
                      maxLines: 7,
                      fontStyle: FontStyle.italic,
                      color: AppColors.whiteColor,
                      "“${data.about}.”",
                    ),
                    20.hBox,
                    InshortWrapWidget(list: controller.inshortList),
                  ],
                ),
              ).paddingOnly(bottom: 15.h),

            /// Looking For
            if (data.lookingFor != null && data.lookingFor!.isNotEmpty)
              CommonHomeCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleMedium(
                      AppStrings.lookingFor,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,
                    LookingWrapWidget(list: data.lookingFor!),
                  ],
                ),
              ).paddingOnly(bottom: 15.h),

            /// Location
            if (distance.isNotEmpty)
              CommonHomeCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleMedium(
                      AppStrings.location,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,
                    CommonCard(
                      widget: Row(
                        children: [
                          Container(
                            padding: 7.allPadding,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffF4F4F4),
                            ),
                            child: CommonText.text("📍"),
                          ),
                          5.wBox,

                          /// Distance
                          CommonText.text(
                            "$distance ${AppStrings.km}",
                            color: const Color(0xffD90380),
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                          5.wBox,

                          /// Better UX
                          Flexible(
                            child: CommonText.text(
                              city.isNotEmpty ? "$city" : "",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            15.hBox,

            /// Interests
            if ((data.interests ?? []).isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleMedium(
                      AppStrings.myInterest,
                      fontWeight: FontWeight.w700,
                    ),
                    CommonText.labelMedium(
                      AppStrings.interestSubtitle,
                      fontWeight: FontWeight.w300,
                    ),
                    10.hBox,
                    InterestWrapWidget(list: data.interests!),
                  ],
                ),
              ).paddingOnly(bottom: 15.h),

            /// Profession
            if ((data.work ?? "").isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleMedium(
                      AppStrings.profession,
                      fontWeight: FontWeight.w700,
                    ),
                    5.hBox,
                    SubCommonCard(widget: CommonText.text(data.work!)),
                  ],
                ),
              ),

            15.hBox,

            if ((data.morePictures ?? []).isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleMedium(
                      AppStrings.morePictures,
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
              ).paddingOnly(bottom: 15.h),

            /// Languages
            if ((data.languages ?? []).isNotEmpty)
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleMedium(
                      AppStrings.language,
                      fontWeight: FontWeight.w700,
                    ),
                    10.hBox,
                    InterestWrapWidget(list: data.languages!),
                  ],
                ),
              ).paddingOnly(bottom: 15.h),

            /// Remaining Images
            if ((data.morePictures ?? []).length > 1)
              Column(
                children: List.generate(
                  data.morePictures!.length - 1,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: CommonCard(
                      widget: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: CommonAssets.networkImage(
                          data.morePictures![index + 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
