import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/controller/login_controller.dart';
import 'package:matchster/features/moduls/auth/login/services/video_services.dart';
import 'package:matchster/features/moduls/auth/login/widgets/login_button.dart';
import 'package:matchster/features/moduls/auth/login/widgets/login_field_with_button.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = Get.find<LoginController>();
  VideoService? _videoService;

  @override
  void initState() {
    super.initState();
    _videoService =
        Get.isRegistered<VideoService>() ? Get.find<VideoService>() : null;
    if (_videoService != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _videoService?.play();
      });
    }
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        bottom: true,
        child: Obx(() {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                /// 🎥 Background Video
                if (_videoService != null)
                  IgnorePointer(
                    child: Video(
                      controller: _videoService!.controller,
                      controls: NoVideoControls,
                      fill: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CommonAssets.svgAsset(AppAssets.appLogo),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: 15.horizontalPadding,
                        child: CommonText.text(
                          AppConstants.discoverSolumates,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          fontSize: 28.sp,
                          fontFamily: "Caros",
                        ),
                      ),
                      _controller.isAccessMyAccount.isTrue ? 5.hBox : 30.hBox,

                      Padding(
                        padding: 28.horizontalPadding,
                        child: Obx(() {
                          if (_controller.isAccessMyAccount.isTrue) {
                            return Column(
                              children: [
                                LoginButton(
                                  image: AppAssets.instagramAssets,
                                  name: AppConstants.instagram,
                                  onTop: () {},
                                ),
                                10.hBox,
                                LoginButton(
                                  image: AppAssets.facebookAssets,
                                  name: AppConstants.facebook,
                                  onTop: () {},
                                ),
                                10.hBox,
                                LoginButton(
                                  image: AppAssets.googleAssets,
                                  name: AppConstants.google,
                                  onTop: () {},
                                ),
                                10.hBox,
                                AppButton(
                                  image: AppAssets.contactAssets,
                                  isEnable: true,
                                  name: AppConstants.number,
                                  onTop: () {
                                    Get.to(LoginFieldWithButton());
                                  },
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              AppButton(
                                isEnable: true,
                                name: AppConstants.createMyAccount,
                                onTop: () {
                                  // _controller.isLoginWithMobile.value = true;
                                  _controller.isAccessMyAccount.value = true;
                                  _controller.isAccessAccount.value = false;
                                },
                              ),
                              10.hBox,
                              LoginButton(
                                name: AppConstants.accessMyAccount,
                                onTop: () {
                                  _controller.isAccessMyAccount.value = true;
                                  _controller.isAccessAccount.value = true;
                                },
                              ),
                            ],
                          );
                        }),
                      ),

                      _controller.isAccessMyAccount.isTrue ? 10.hBox : 30.hBox,
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),

      /// 🔘 Floating Verify Button
    );
  }
}
