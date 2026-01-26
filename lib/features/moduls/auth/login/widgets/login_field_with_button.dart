import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_input_formetters.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/login/controller/country_controller.dart';
import 'package:matchster/features/moduls/auth/login/controller/login_controller.dart';
import 'package:matchster/features/moduls/auth/login/view/country_list_screen.dart';

// ignore: must_be_immutable
class LoginFieldWithButton extends StatelessWidget {
  LoginFieldWithButton({super.key});

  final _countryController = Get.find<CountryController>();
  final _loginController = Get.find<LoginController>();
  final RxBool isEnable = false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset(AppAssets.loginImage2),
        ),

        Padding(
          padding: EdgeInsets.only(top: 60.0.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentGeometry.center,
                child: CommonText.text(
                  textAlign: TextAlign.center,
                  "Create account",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.hBox,
              CommonText.text(
                fontFamily: "DM Sans",
                textAlign: TextAlign.center,
                maxLines: 3,
                AppConstants.loginSubtile,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.loginTitleColor,
              ),
              70.hBox,
              CommonText.text(
                "Phone Number",
                fontFamily: "DM Sans",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              5.hBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        padding: 10.horizontalPadding,
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 2,
                            color:
                                _loginController.isEnable.isTrue
                                    ? AppColors.textFieldColor
                                    : AppColors.blackColor.withAlpha(64),
                          ),
                        ),
                        child: Row(
                          children: [
                            Obx(
                              () => CommonText.text(
                                _countryController.selectedCountry.value != null
                                    ? "${_countryController.selectedCountry.value!.countryCode} +${_countryController.selectedCountry.value!.phoneCode}"
                                    : "IN +91",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DM Sans",
                                color: Colors.black.withAlpha(128),
                              ),
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
                  5.wBox,
                  Flexible(
                    child: CustomFormField(
                      inputFormatters: [AppInputFormatters.onlyNumbers()],
                      maxLength: 10,
                      enableBorder: _loginController.isEnable,
                      keyboardType: TextInputType.number,
                      label: AppConstants.hintLoginMessage,
                      hint: AppConstants.hintLoginMessage,
                      controller: _loginController.controller,
                      onChanged: (mobileNUmber) {
                        if (mobileNUmber != null && mobileNUmber.length == 10) {
                          _loginController.isEnable.value = true;
                          AppMethods.hideKeyboard();
                        } else {
                          _loginController.isEnable.value = true;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
