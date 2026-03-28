import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controllers/login_controller.dart';
import 'package:matchster/features/auth/services/video_services.dart';
import 'package:matchster/features/auth/widgets/login_widget/login_button.dart';
import 'package:matchster/routes/app_routes.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LoginScreen extends BaseView<LoginController> {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseViewState<LoginController, LoginScreen> {
  late final VideoService _videoService;

  @override
  void onInit() {
    _videoService = Get.find<VideoService>();
  }

  @override
  void onReady() {
    _videoService.play();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        bottom: true,
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              IgnorePointer(
                child: Video(
                  controller: _videoService.controller,
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
                      child: CommonText.displayMedium(
                        AppConstants.discoverSolumates,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Obx(
                      () =>
                          controller.isAccessMyAccount.isTrue
                              ? 5.hBox
                              : 30.hBox,
                    ),
                    Padding(
                      padding: 28.horizontalPadding,
                      child: Obx(() {
                        if (controller.isAccessMyAccount.isTrue) {
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
                                onTop: controller.signWithGoogle,
                              ),
                              10.hBox,
                              AppButton(
                                image: AppAssets.contactAssets,
                                isEnable: true,
                                name: AppConstants.number,
                                onTop: () {
                                  controller.navigateTo(
                                    AppRoutes.loginFieldWitButton,
                                  );
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
                                controller.isAccessMyAccount.value = true;
                                controller.isAccessAccount.value = false;
                              },
                            ),
                            10.hBox,
                            LoginButton(
                              name: AppConstants.accessMyAccount,
                              onTop: () {
                                controller.isAccessMyAccount.value = true;
                                controller.isAccessAccount.value = true;
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                    Obx(
                      () =>
                          controller.isAccessMyAccount.isTrue
                              ? 10.hBox
                              : 30.hBox,
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
