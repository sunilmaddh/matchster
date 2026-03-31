import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/auth/widgets/login_widget/posture_sample_card.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/posture/controller/posture_controller.dart';
import 'package:matchster/test/hand_landmark.dart';

class PostureGestureScreen extends StatelessWidget {
  PostureGestureScreen({super.key});

  final PostureController _postureController = Get.find<PostureController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.postureGesture, onTop: () {}),
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
                  image:
                      _postureController.postureList[_postureController
                          .postureIndex
                          .value],
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
                          if (_postureController.lastCapturedPath.value != null)
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
                                            _postureController
                                                .lastCapturedPath
                                                .value!,
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
                              bottom: 30.h,
                              left: 30.w,
                              right: 30.w,
                              child: HandTrackerView(),
                            ),
                        ],
                      ),
                    ),
                    30.hBox,
                    AppButton(
                      name: AppStrings.takeMyPhoto,
                      onTop: () async {
                        _postureController.moveToNextStep();
                        _postureController.restartDetection();
                      },
                      isEnable: true,
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
