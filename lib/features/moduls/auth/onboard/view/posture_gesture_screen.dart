import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/widgets/posture_sample_card.dart';

class PostureGestureScreen extends StatelessWidget {
  PostureGestureScreen({super.key});

  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Posture Gesture", onTop: () {}),
      body: SafeArea(
        child: Padding(
          padding: 15.horizontalPadding + 15.verticalPadding,
          child: Obx(() {
            final image = _controller.postureImage.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppConstants.copyThePosture,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                10.hBox,
                PostureSampleCard(),
                10.hBox,
                CommonText.text(
                  maxLines: 4,
                  AppConstants.matchYourPose,
                  fontSize: 16.sp,
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
                                width: MediaQuery.of(context).size.width,
                                height: 310.h,
                                AppAssets.photoFrame3,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          if (image != null)
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
                                        borderRadius:
                                            BorderRadiusGeometry.circular(20),
                                        child: Image.file(
                                          _controller.postureImage.value!,
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
                                        CommonText.text(
                                          color: AppColors.whiteColor,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          "Your photo has been successfully verified",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
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
                              child: CommonText.text(
                                maxLines: 2,
                                "When you are ready, tap the button below and snap your gesture!",
                                fontSize: 14.sp,
                                textAlign: TextAlign.center,
                                color: Color(0xff7B7B7B),
                              ),
                            ),
                        ],
                      ),
                    ),
                    30.hBox,
                    AppButton(
                      name: "Take My Photo",
                      onTop: () async {
                        _controller.pickImageFromCameraForPosture();
                        if (_controller.faceImage.value != null) {
                          await _controller.loadImageSize(
                            _controller.faceImage.value!,
                          );
                          await _controller.analyzeFace(
                            _controller.faceImage.value!,
                          );
                          // Get.to(FaceRecognisationPage());
                        }
                      },
                      isEnable: true,
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
