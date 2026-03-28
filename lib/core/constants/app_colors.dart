import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();
  static Gradient gradiantPrimary2 = LinearGradient(
        colors: [Color(0xff1B8CF5), Color(0xff83AAF7), Color(0xffB9CBFA)],
      ),
      circleGradiantColor = LinearGradient(
        colors: [Color(0xffD9D9D9), Color(0xff000000).withAlpha(84)],
      ),
      gradiantPrimary = LinearGradient(
        colors: [Color(0xff1D48EF), Color(0xff7A96F8)],
      ),
      gradientCircle = const LinearGradient(
        begin: AlignmentDirectional.topStart,
        end: AlignmentGeometry.bottomCenter,
        colors: [
          Color(0xff1D48EF), // dark blue (top)
          Color(0xff7A96F8), // light blue (center)
        ],
      ),
      gradientBoxCircle = const LinearGradient(
        colors: [
          Color(0xff1D48EF), // dark blue (top)
          Color(0xff7A96F8), // light blue (center)
        ],
      ),
      appGradiantColor = LinearGradient(
        colors: [Color(0xffEDEDED), Color(0xffEDEDED)],
      ),
      homeCardGradiantColor = LinearGradient(
        colors: [Color(0xff292929), Color(0xff858585)],
      ),
      matchTilGradiantColor = LinearGradient(
        colors: [Color(0xffFFD342), Color(0xffDE9800)],
      );

  static const Color progressDissableColor = Color(0xffD9D9D9),
      primary = Color(0xff1D48EF),
      borderColor = Color(0xffEBEBEB),
      blackColor = Color(0xff000000),
      whiteColor = Color(0xffffffff),
      appDisableButton = Color(0xffA4A4A4),
      deviderColor = Color(0xffDADADA),
      textFieldColor = Color(0xff1B8CF5),
      circleColor = Color(0xffF4F4F4),
      otpFieldColor = Color(0xff002DDC),
      filterHearderCardColor = Color(0xffBABABA),
      filterCardColor = Color(0xffFBFAFF),
      loginTitleColor = Color(0xff2B2B2B),
      distenceSwitchTextColor = Color(0xff666666),
      commonLightColor = Color(0xffBABABA);
  static Color hintColor = Color(0xff000000).withAlpha(128);
  static Color loginBorderColor = Color(0xff000000).withAlpha(64);
  static const Color searchFieldBgColor = Color(0xffF9FCFF);
  static const Color searchFieldBorderColor = Color(0xffDEEFFF);
  static const Color educationItemBg = Color(0xffE8E8E8);

  static const Color zodiacCardColor = Color(0xffB4CADE);
  static const Color religionCardColor = Color(0xffB4DEC5);
  static const Color visibilityCardColor = Color(0xffDEDCB4);
  static const Color lookingForCardColor = Color(0xffB4CADE);
  static const Color heightCardColor = Color(0xffE5C3FF);
  static const Color educationCardColor = Color(0xff92C58F);
  static const Color workCardColor = Color(0xffA2D2FF);

  static const Color smokingCardColor = Color(0xffDEB4B4);
  static const Color drinkingCardColor = Color(0xffDEB4C8);
  static const Color interestCardColor = Color(0xffB4B8DE);
  static const Color languagesCardColor = Color(0xff85CFCF);

  static const Color profileBadgeBorder = Color(0xffE6D534);
  static const Color previewBorder = Color(0xffDEDEDE);
  static const Color verifiedCardColor = Color(0xff1D48EF);
  static const Color aboutHintColor = Color(0xff898A8D);
  static const Color lightBlackBorder = Color(0x33000000);
  static const Color sheetBackground = Color(0xffF4F4F4);
}
