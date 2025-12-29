import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';
import 'package:matchster/features/moduls/home/helper/home_helper.dart';
import 'package:matchster/features/moduls/home/view/filter/filter_screen.dart';
import 'package:matchster/features/moduls/home/view/match_screen.dart';
import 'package:matchster/features/moduls/home/widgets/circle_widget.dart';
import 'package:matchster/features/moduls/home/widgets/dark_circle_widget.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/common_wrap_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                spacing: 0,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: 15.horizontalPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AppAssets.appLogo),
                        Row(
                          children: [
                            DarkCircleWidget(
                              widget: Icon(
                                Icons.notifications_outlined,
                                color: AppColors.whiteColor,
                              ),
                              onTop: () {},
                            ),
                            20.wBox,
                            DarkCircleWidget(
                              widget: Icon(
                                Icons.filter_list_sharp,
                                color: AppColors.whiteColor,
                              ),
                              onTop: () {
                                Get.to(FilterScreen());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: 18.horizontalPadding,
                          height: 10.h,

                          decoration: BoxDecoration(
                            color: Color(0xffCDF0FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0.r),
                              topRight: Radius.circular(20.0.r),
                            ),
                          ),
                        ),
                        Container(
                          margin: 13.horizontalPadding,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: Color(0xffF6E9FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0.r),
                              topRight: Radius.circular(10.0.r),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 70.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.imageAssets2),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0.r),
                              topRight: Radius.circular(20.0.r),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: AlignmentGeometry.center,
                                    end: AlignmentGeometry.bottomCenter,

                                    colors: [
                                      const Color(
                                        0xFF7A96F8,
                                      ).withAlpha(0), // 0.0
                                      const Color(
                                        0xFF587DFF,
                                      ).withAlpha(128), // 0.50
                                      const Color(
                                        0xFF5174FF,
                                      ).withAlpha(191), // 0.75
                                      const Color(
                                        0xFF3F66FF,
                                      ).withAlpha(223), // 0.87
                                      const Color(
                                        0xFF1D48EF,
                                      ).withAlpha(0), // 0.0
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            Platform.isAndroid ? 120.h : 160.h,
                                        left: 25.w,
                                        right: 25.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CommonText.text(
                                                    "R, 28",
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Caros",
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  2.wBox,

                                                  SvgPicture.asset(
                                                    AppAssets.verified,
                                                  ),
                                                  100.wBox,

                                                  SvgPicture.asset(
                                                    AppAssets.upArrowAssets,
                                                  ),
                                                ],
                                              ),
                                              CommonText.text(
                                                "4km. away",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Caros",
                                                color: AppColors.whiteColor,
                                              ),
                                              15.hBox,
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        15.horizontalPadding +
                                                        3.verticalPadding,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.r,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            AppColors
                                                                .whiteColor,
                                                        width: 0.96.w,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppAssets.travelImage,
                                                        ),
                                                        5.wBox,
                                                        CommonText.text(
                                                          "Travel",
                                                          fontSize: 11.5.sp,
                                                          fontFamily: "Caros",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors
                                                                  .whiteColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  10.wBox,
                                                  Container(
                                                    padding:
                                                        15.horizontalPadding +
                                                        3.verticalPadding,

                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.r,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            AppColors
                                                                .whiteColor,
                                                        width: 0.96.w,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppAssets.musicImage,
                                                        ),
                                                        5.wBox,
                                                        CommonText.text(
                                                          "Music",
                                                          fontSize: 11.5.sp,
                                                          fontFamily: "Caros",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors
                                                                  .whiteColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          20.hBox,
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleWidget(
                                                image: AppAssets.likeAssets,
                                                text: "Like",
                                                onTop: () {
                                                  _homeController.isLike.value =
                                                      true;
                                                  _homeController
                                                      .isOverlay
                                                      .value = true;
                                                  Future.delayed(
                                                    Duration(seconds: 2),
                                                    () {
                                                      _homeController
                                                          .isOverlay
                                                          .value = false;
                                                      _homeController
                                                          .isLike
                                                          .value = false;

                                                      Get.to(MatchScreen());
                                                    },
                                                  );
                                                },
                                              ),

                                              10.hBox,
                                              CircleWidget(
                                                isGradient: false,
                                                image: AppAssets.dislike,
                                                text: "Dislike",
                                                onTop: () {
                                                  _homeController.isLike.value =
                                                      false;
                                                  _homeController
                                                      .isOverlay
                                                      .value = true;
                                                  Future.delayed(
                                                    Duration(seconds: 2),
                                                    () {
                                                      _homeController
                                                          .isOverlay
                                                          .value = false;
                                                      _homeController
                                                          .isLike
                                                          .value = false;
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.hBox,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Transform.translate(
                          offset: Offset(0, -10), // move upward
                          child: Container(
                            padding: 15.verticalPadding + 15.horizontalPadding,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0.r),
                                topRight: Radius.circular(20.0.r),
                              ),
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: 20.horizontalPadding,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonText.text(
                                        "Ryle Sharma, 28",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Caros",
                                      ),
                                      SvgPicture.asset(AppAssets.shareAssets),
                                    ],
                                  ),
                                ),
                                10.hBox,

                                CommonHomeCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText.text(
                                        "In Short",
                                        color: AppColors.whiteColor,
                                      ),
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

                                      CommonWrapWidget(list: HomeHelper.list),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonHomeCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      CommonWrapWidget(list: HomeHelper.list),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonHomeCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      CommonWrapWidget(list: HomeHelper.list),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                                      CommonWrapWidget(
                                        borderColor: const Color(
                                          0xff363636,
                                        ).withValues(alpha: 33),

                                        list: HomeHelper.list,
                                      ),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText.text(
                                        "Profession",
                                        fontFamily: "Caros",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),

                                      CommonWrapWidget(
                                        borderColor: const Color(
                                          0xff363636,
                                        ).withValues(alpha: 33),
                                        list: HomeHelper.list,
                                      ),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText.text(
                                        "More Picture",
                                        fontFamily: "Caros",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      10.hBox,

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Image.asset(
                                          AppAssets.imageAssets2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                padding:
                                                    10.horizontalPadding +
                                                    4.verticalPadding,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xffD9D9D9,
                                                  ).withValues(alpha: 33),

                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.r,
                                                      ),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xff363636,
                                                    ).withValues(alpha: 33),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Image.asset(
                                          AppAssets.imageAssets3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Image.asset(
                                          AppAssets.imageAssets4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                15.hBox,
                                CommonCard(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Image.asset(
                                          AppAssets.imageAssets5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
