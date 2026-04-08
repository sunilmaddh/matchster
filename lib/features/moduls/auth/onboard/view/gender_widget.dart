import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/widgets/radio_widget.dart';
import 'package:matchster/features/moduls/auth/widgets/switch_widget.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              AppConstants.whatYourGender,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "Caros",
            ),
            // 20.hBox,
            CommonText.text(
              maxLines: 2,
              AppConstants.genderDiscription,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Caros",
            ),
            40.hBox,
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: OnboardHalper.radioList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: 5.verticalPadding,
                  child: RadioWidget(
                    text: OnboardHalper.radioList[index],
                    index: index,
                  ),
                );
              },
            ),
            5.hBox,
            SwitchWidget(),
            10.hBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 20),
                5.wBox,
                Expanded(
                  child: CommonText.text(
                    maxLines: 3,
                    AppConstants.genderNote,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Caros",
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
