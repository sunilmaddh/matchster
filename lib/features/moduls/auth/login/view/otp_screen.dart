import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/utils/navigation_halper.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/view/onboard_screen.dart';
import 'package:matchster/features/moduls/auth/widgets/otp_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppConstants.otpVerification,
        onTop: () {},
      ),
      body: Padding(
        padding: 20.horizontalPadding + 10.verticalPadding,
        child: Column(
          children: [
            CommonText.text(
              textAlign: TextAlign.center,
              maxLines: 2,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff0C0C0C),
              AppConstants.otpDiscription,
            ),
            40.hBox,
            OtpWidget(),
            32.hBox,
            AppButton(
              name: AppConstants.verifyNumber,
              onTop: () {
                NavigationHelper.push(OnboardScreen());
              },
            ),
            10.hBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText.text(
                  AppConstants.dontSend,
                  fontSize: 16.sp,
                  color: Color(0xff5A5A5A),
                  fontWeight: FontWeight.w400,
                ),
                TextButton(
                  onPressed: () {},
                  child: CommonText.text(
                    AppConstants.resend,
                    fontSize: 16.sp,
                    color: AppColors.otpFieldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
