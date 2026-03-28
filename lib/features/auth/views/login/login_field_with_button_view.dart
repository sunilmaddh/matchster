import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_input_formetters.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/common/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/auth/auth_controllers/country_controller.dart';
import 'package:matchster/features/auth/auth_controllers/login_controller.dart';
import 'package:matchster/features/auth/views/login/country_list_screen.dart';
import 'package:matchster/routes/app_navigation.dart';

class LoginFieldWithButtonView extends BaseView<LoginController> {
  const LoginFieldWithButtonView({super.key});

  @override
  State<LoginFieldWithButtonView> createState() => _LoginFieldWithButtonState();
}

class _LoginFieldWithButtonState
    extends BaseViewState<LoginController, LoginFieldWithButtonView> {
  final CountryController _countryController = Get.find<CountryController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController phoneController;

  @override
  void onInit() {
    phoneController = TextEditingController();
  }

  @override
  void onDispose() {
    phoneController.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      right: true,
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Obx(
          () => Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom:
                  MediaQuery.of(context).viewInsets.bottom > 0 ? 10.h : 20.h,
            ),
            child: AppButton(
              isEnable: controller.isEnable.value,
              name: AppConstants.verify,
              onTop: () async {
                AppMethods.hideKeyboard();

                if (!(_formKey.currentState?.validate() ?? false)) return;

                final number =
                    '${controller.countryCode.value}${phoneController.text.trim()}';

                await controller.submitPhone(number);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.hBox,
              Align(
                alignment: Alignment.center,
                child: CommonAssets.svgAsset(AppAssets.appLogo),
              ),
              60.hBox,
              Container(
                margin: EdgeInsets.only(right: 5.w),
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.loginImage2),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      50.hBox,
                      Align(
                        alignment: Alignment.center,
                        child: Obx(
                          () => CommonText.text(
                            textAlign: TextAlign.center,
                            controller.isAccessAccount.isTrue
                                ? AppConstants.loginTitle
                                : 'Create account',
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      20.hBox,
                      Obx(
                        () => CommonText.text(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          controller.isAccessAccount.isTrue
                              ? AppConstants.loginDescription
                              : AppConstants.loginSubtile,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.loginTitleColor,
                        ),
                      ),
                      50.hBox,
                      CommonText.text(
                        'Phone Number',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      5.hBox,
                      Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () async {
                                      final selectedCountry =
                                          await AppNavigation.toWithClassName<
                                            Country
                                          >(CountryListScreen());

                                      if (selectedCountry == null) return;

                                      _countryController.selectedCountry.value =
                                          selectedCountry;

                                      controller.updateCountryCode(
                                        '+${selectedCountry.phoneCode}',
                                      );
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height <
                                                  750
                                              ? 57.h
                                              : 48.h,
                                      padding: 10.horizontalPadding,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color:
                                              controller.isEnable.value
                                                  ? AppColors.textFieldColor
                                                  : AppColors.blackColor
                                                      .withAlpha(64),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          CommonText.text(
                                            _countryController
                                                        .selectedCountry
                                                        .value !=
                                                    null
                                                ? '${_countryController.selectedCountry.value!.countryCode} +${_countryController.selectedCountry.value!.phoneCode}'
                                                : 'IN +91',
                                            fontSize: 16.sp,
                                            color: Colors.black.withAlpha(128),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black.withAlpha(128),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                            5.wBox,
                            Expanded(
                              child: CustomFormField(
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  AppInputFormatters.onlyNumbers(),
                                ],
                                enableBorder: controller.isEnable,
                                controller: phoneController,
                                validator: (number) {
                                  return AppMethods.validateMobile(number);
                                },
                                hint: AppConstants.hintLoginMessage,
                                onChanged: (value) {
                                  controller.updatePhoneNumber(value ?? '');

                                  if ((value ?? '').length == 10) {
                                    AppMethods.hideKeyboard();
                                  }
                                },
                                label: 'Enter Mobile Number',
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.hBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
