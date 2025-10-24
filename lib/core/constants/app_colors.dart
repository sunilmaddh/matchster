import 'package:flutter/cupertino.dart';

class AppColors {
  static Gradient gradiantPrimary = LinearGradient(
        colors: [Color(0xff1B8CF5), Color(0xff83AAF7), Color(0xffB9CBFA)],
      ),
      circleGradiantColor = LinearGradient(
        colors: [Color(0xffD9D9D9), Color(0xff000000).withOpacity(0.33)],
      ),
      appGradiantColor = LinearGradient(
        colors: [Color(0xffEDEDED), Color(0xffEDEDED)],
      );

  static const Color progressDissableColor = Color(0xffD9D9D9),
      borderColor = Color(0xffEBEBEB),
      blackColor = Color(0xff000000),
      whiteColor = Color(0xffffffff),
      appDisableButton = Color(0xffA4A4A4),
      deviderColor = Color(0xffDADADA),
      textFieldColor = Color(0xff1B8CF5),
      circleColor = Color(0xffF4F4F4),
      otpFieldColor = Color(0xff002DDC),
      loginTitleColor = Color(0xff2B2B2B);
  static Color hintColor = Color(0xff000000).withOpacity(0.50);
  static Color loginBorderColor = Color(0xff000000).withOpacity(0.25);
}
