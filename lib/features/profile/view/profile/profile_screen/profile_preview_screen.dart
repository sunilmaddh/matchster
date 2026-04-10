import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/sub_common_card.dart';
import 'package:matchster/routes/app_navigation.dart';

import '../../../../../core/widgets/fields/common_text.dart';

class ProfilePreviewScreen extends StatelessWidget {
  ProfilePreviewScreen({super.key});
  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Profile preview",
        onTop: () {
          AppNavigation.back();
        },
        actions: [
          Padding(
            padding: 10.horizontalPadding,
            child: TextButton(
              onPressed: () {
                // Get.to(() => SettingScreen());
              },
              child: SvgPicture.asset(AppAssets.settingAssets),
            ),
            // IconButton(
            //   onPressed: () {
            //     // Get.to<SettingScreen>();
            //   },
            //   icon: Icon(Icons.settings_outlined),
            // ),
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
                      child:
                          _controller.allPfFame.isNotEmpty
                              ? CommonAssets.networkImage(
                                _controller.allPfFame[0].url!,
                                height: 518..h,
                                fit: BoxFit.fill,
                              )
                              : SizedBox(height: 518..h),
                      // Image.asset(
                      //   height: 518..h,
                      //   AppAssets.imageAssets6,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    // Align(
                    //   alignment: AlignmentGeometry.bottomCenter,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(bottom: 15.h),
                    //     child: InkWell(
                    //       onTap: () {},
                    //       child: VerifiedCard(
                    //         color: Color(0xff1D48EF),
                    //         title: "Get Verified",
                    //         subTitle: 'Show others you’re real',
                    //         image: AppAssets.verified2,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: 20.horizontalPadding,
                child: CommonText.text(
                  "${_controller.basicInfo.value.name}, ${_controller.basicInfo.value.age}",
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
                      _controller.bio.value.about!.isNotEmpty
                          ? "“${_controller.bio.value.about}.”"
                          : "",
                    ),
                    20.hBox,
                    InshortWrapWidget(list: _controller.inshortList),
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

                    LookingWrapWidget(
                      list: _controller.prefeence.value.lookingFor!,
                    ),

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
                            "",
                            // "${_controller.locations.distance.toString()} km",
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                          5.wBox,
                          CommonText.text(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            _controller
                                        .locations
                                        .value
                                        .currentLocation!
                                        .address !=
                                    null
                                ? "away, ${_controller.locations.value.currentLocation!.address!.city}"
                                : "",
                          ),
                        ],
                      ),
                    ),

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
                    10.hBox,
                    InterestWrapWidget(
                      list: _controller.personal.value.interests!,
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
                    5.hBox,
                    SubCommonCard(
                      widget: CommonText.text(
                        AppMethods.capitalizeFirst(
                          _controller.professional.value.work!.jobTitle!,
                        ),
                      ),
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
                      child:
                          _controller.allPfFame != null &&
                                  _controller.allPfFame.isNotEmpty
                              ? CommonAssets.networkImage(
                                _controller.allPfFame.first.url!,
                              )
                              : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              15.hBox,
              if (_controller.personal.value.languages != null &&
                  _controller.personal.value.languages!.isNotEmpty)
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
                            _controller.personal.value.languages!.map((v) {
                              return Container(
                                padding:
                                    10.horizontalPadding + 4.verticalPadding,
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
              if (_controller.allPfFame != null &&
                  _controller.allPfFame.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Images list
                    Column(
                      children: List.generate(
                        _controller.allPfFame.length - 1,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: CommonCard(
                              widget: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: CommonAssets.networkImage(
                                  _controller.allPfFame[index + 1].url!,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              else
                const SizedBox.shrink(),
              // CommonCard(
              //   widget: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(20.0.r),
              //         child: Image.asset(AppAssets.imageAssets8),
              //       ),
              //     ],
              //   ),
              // ),
              // 15.hBox,
              // CommonCard(
              //   widget: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(20.0.r),
              //         child: Image.asset(AppAssets.imageAssets9),
              //       ),
              //     ],
              //   ),
              // ),
              // 15.hBox,
              // CommonCard(
              //   widget: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(20.0.r),
              //         child: Image.asset(AppAssets.imageAssets10),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
