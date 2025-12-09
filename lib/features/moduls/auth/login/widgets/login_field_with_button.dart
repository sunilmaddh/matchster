import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/utils/navigation_halper.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/login/view/otp_screen.dart';

// ignore: must_be_immutable
class LoginFieldWithButton extends StatelessWidget {
  LoginFieldWithButton({super.key});

  TextEditingController controller = TextEditingController();
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
            children: [
              CommonText.text(
                AppConstants.login,
                fontSize: 32.sp,
                fontWeight: FontWeight.w400,
              ),
              20.hBox,
              CommonText.text(
                textAlign: TextAlign.center,
                maxLines: 3,
                AppConstants.loginSubtile,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.loginTitleColor,
              ),
              90.hBox,
              CustomFormField(
                keyboardType: TextInputType.number,
                label: "",
                hint: AppConstants.hintLoginMessage,
                controller: controller,
                onChanged: (mobileNUmber) {
                  if (mobileNUmber != null && mobileNUmber.length == 10) {
                    isEnable.value = true;
                  } else {
                    isEnable.value = false;
                  }
                },
              ),
              30.hBox,
              AppButton(
                isEnable: isEnable,
                name: AppConstants.verify,
                onTop: () {
                  NavigationHelper.push(OtpScreen());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
