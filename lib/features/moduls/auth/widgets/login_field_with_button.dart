import 'package:flutter/material.dart';
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
              30.hBox,
              CommonText.text(
                AppConstants.loginSubtile,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.loginTitleColor,
              ),
              90.hBox,
              CustomFormField(
                label: "",
                hint: AppConstants.hintLoginMessage,
                controller: controller,
              ),
              30.hBox,
              AppButton(
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
