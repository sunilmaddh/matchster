import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/features/moduls/home/helper/home_helper.dart';
import 'package:matchster/features/moduls/profile/widgets/common_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/verified_card.dart';

import '../../../../../core/widgets/fields/common_text.dart';

class ProfilePreviewScreen extends StatelessWidget {
  const ProfilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Profile preview",
        onTop: () {
          Get.back();
        },
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: 15.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.h),
                height: 518..h,
                decoration: BoxDecoration(
                  // color: AppColors.appDisableButton,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      child: Image.asset(
                        height: 518..h,
                        AppAssets.imageAssets6,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: InkWell(
                          onTap: () {},
                          child: VerifiedCard(
                            color: Color(0xff1D48EF),
                            title: "Get Verified",
                            subTitle: 'Show others you’re real',
                            image: AppAssets.verified2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: 20.horizontalPadding,
                child: CommonText.text(
                  "Ryle Sharma, 28",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Caros",
                ),
              ),
              10.hBox,

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
                      "“Hi there! I am Ryle. I will be happy to meet new people and interesting meetings.”",
                    ),

                    20.hBox,

                    // CommonWrapWidget(list: []),
                  ],
                ),
              ),
              15.hBox,
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

                    // ),
                    // CommonWrapWidget(list: []),
                  ],
                ),
              ),
              15.hBox,
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
                    // CommonWrapWidget(list: []),
                  ],
                ),
              ),
              15.hBox,
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

                    // CommonWrapWidget(
                    //   borderColor: Color(0xff363636).withAlpha(33),
                    //   list: [],
                    // ),
                  ],
                ),
              ),
              15.hBox,
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
                  ],
                ),
              ),
              15.hBox,
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
                      borderRadius: BorderRadius.circular(20.0.r),
                      child: Image.asset(AppAssets.imageAssets7),
                    ),
                  ],
                ),
              ),
              15.hBox,
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

                    // ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          HomeHelper().list2.map((v) {
                            return Container(
                              padding: 10.horizontalPadding + 4.verticalPadding,
                              decoration: BoxDecoration(
                                color: Color(0xffD9D9D9).withAlpha(33),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Color(0xff363636).withAlpha(33),
                                  width: 1.w,
                                ),
                              ),
                              child: CommonText.text(
                                v,
                                color: AppColors.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Caros",
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              15.hBox,
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0.r),
                      child: Image.asset(AppAssets.imageAssets8),
                    ),
                  ],
                ),
              ),
              15.hBox,
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0.r),
                      child: Image.asset(AppAssets.imageAssets9),
                    ),
                  ],
                ),
              ),
              15.hBox,
              CommonCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0.r),
                      child: Image.asset(AppAssets.imageAssets10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
