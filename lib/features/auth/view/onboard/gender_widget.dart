import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';
import 'package:matchster/features/auth/widgets/onboard_widgets/radio_widget.dart';
import 'package:matchster/features/auth/widgets/onboard_widgets/switch_widget.dart';

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
            CommonText.displaySmall(
              AppConstants.whatYourGender,

              fontWeight: FontWeight.w600,
            ),
            // 20.hBox,
            CommonText.titleMedium(
              maxLines: 2,
              AppConstants.genderDiscription,
              fontWeight: FontWeight.w400,
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
                  child: CommonText.labelLarge(
                    maxLines: 3,
                    AppConstants.genderNote,

                    fontWeight: FontWeight.w300,
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
