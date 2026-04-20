import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/widgets/onboard_widgets/posture_sample_card.dart';
import 'package:matchster/features/posture/controller/posture_controller.dart';
import 'package:matchster/routes/app_navigation.dart';

class PostureGestureScreen extends BaseStatelessView<PostureController> {
  const PostureGestureScreen({super.key});

  @override
  Widget buildView(BuildContext context, PostureController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.postureGesture,
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: 15.horizontalPadding + 15.verticalPadding,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.titleMedium(
                  AppConstants.copyThePosture,
                  fontWeight: FontWeight.w400,
                ),
                10.hBox,
                PostureSampleCard(
                  image: controller.postureList[controller.postureIndex.value],
                ),
                10.hBox,
                CommonText.titleMedium(
                  AppConstants.matchYourPose,
                  maxLines: 4,
                  fontWeight: FontWeight.w400,
                ),
                20.hBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Padding(
                            padding: 20.horizontalPadding,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                AppAssets.photoFrame3,
                                width: MediaQuery.of(context).size.width,
                                height: 310.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          if (controller.lastCapturedPath.value != null)
                            Positioned(
                              top: 10.h,
                              bottom: 10.h,
                              left: 30.w,
                              right: 30.w,
                              child: Stack(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(
                                            controller.lastCapturedPath.value!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: 30.horizontalPadding,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.successfully,
                                        ),
                                        CommonText.labelLarge(
                                          AppStrings.photoVerified,
                                          color: AppColors.whiteColor,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Positioned(
                              top: 130.h,
                              left: 30.w,
                              right: 30.w,
                              bottom: 60.h,
                              child: CommonText.labelLarge(
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                AppConstants.readyTopButtonDescription,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7B7B7B),
                              ),
                              // HandTrackerScreen(),
                            ),
                        ],
                      ),
                    ),
                    30.hBox,
                    Obx(
                      () => AppButton(
                        name:
                            controller.isPostureVerify.isTrue
                                ? "Continue"
                                : AppStrings.takeMyPhoto,
                        onTop: () async {
                          controller.verifyAndNavigate();
                        },
                        isEnable: true,
                      ),
                      // controller.isCameraInitialized.isTrue
                      //     ? CircularProgressIndicator(
                      //       color: AppColors.primary,
                      //     )
                      //     : AppButton(
                      //       name:
                      //           controller.isPostureVerify.isTrue
                      //               ? "Continue"
                      //               : AppStrings.takeMyPhoto,
                      //       onTop: () async {
                      //         controller.verifyAndNavigate();
                      //       },
                      //       isEnable: true,
                      //     ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
