import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_input_formetters.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/utils/navigation_halper.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/auth/auth_controller/country_controller.dart';
import 'package:matchster/features/auth/auth_controller/login_controller.dart';
import 'package:matchster/features/auth/view/login/country_list_screen.dart';
import 'package:matchster/features/auth/view/login/otp_screen.dart';

class LoginFieldScreen extends StatelessWidget {
  LoginFieldScreen({super.key});

  final _countryController = Get.find<CountryController>();
  final _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      right: true,
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true, // 🔥 KEY FIX
        bottomNavigationBar: Obx(
          () => Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom:
                  MediaQuery.of(context).viewInsets.bottom > 0 ? 10.h : 20.h,
            ),
            child: AppButton(
              isEnable: _loginController.isEnable.value,
              name: AppConstants.verify,
              onTop: () async {
                final number =
                    _loginController.countryCode +
                    _loginController.controller.text;

                _loginController.phoneNumber.value = number;
                if (_loginController.isEnable.isTrue) {
                  await _loginController.sendOtp(number);
                  NavigationHelper.push(OtpScreen());
                }
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
                // height: 350.h,
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
                        child: CommonText.text(
                          textAlign: TextAlign.center,
                          _loginController.isAccessAccount.isTrue
                              ? AppConstants.loginTitle
                              : "Create account",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      20.hBox,

                      CommonText.text(
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        _loginController.isAccessAccount.isTrue
                            ? AppConstants.loginDescription
                            : AppConstants.loginSubtile,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.loginTitleColor,
                      ),

                      50.hBox,

                      CommonText.text(
                        "Phone Number",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),

                      5.hBox,

                      Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // IMPORTANT
                          children: [
                            /// COUNTRY PICKER
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () async {
                                      _countryController
                                          .selectedCountry
                                          .value = await Get.to<Country>(
                                        () => const CountryListScreen(),
                                      );

                                      _loginController.countryCode.value =
                                          "+${_countryController.selectedCountry.value!.phoneCode}";
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
                                              _loginController.isEnable.isTrue
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
                                                ? "${_countryController.selectedCountry.value!.countryCode} +${_countryController.selectedCountry.value!.phoneCode}"
                                                : "IN +91",
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

                                /// 👇 Reserve error space (same height as TextFormField error)
                                SizedBox(height: 20.h),
                              ],
                            ),

                            5.wBox,

                            /// PHONE INPUT
                            Expanded(
                              child: CustomFormField(
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  AppInputFormatters.onlyNumbers(),
                                ],
                                enableBorder: _loginController.isEnable,
                                controller: _loginController.controller,
                                validator: (number) {
                                  return AppMethods.validateMobile(number);
                                },
                                hint: AppConstants.hintLoginMessage,
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    if (value != null && value.length == 10) {
                                      _loginController.isEnable.value = true;
                                      AppMethods.hideKeyboard();
                                    } else {
                                      _loginController.isEnable.value = false;
                                    }
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
