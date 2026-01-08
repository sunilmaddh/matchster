import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';

class YourHeightWidget extends StatelessWidget {
  YourHeightWidget({super.key});

  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.whatYourHeight,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),
          // 20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.heightDescription,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),

          20.hBox,
          InkWell(
            onTap: () {
              CommonBottomSheet.showHeightPicker(
                context: context,
                heightList: OnboardHalper().generateHeightList(),
                defaultValue: OnboardHalper().generateHeightList()[0],

                onSelected: (height) {
                  _controller.feet.value = double.parse(
                    '${height.feet}.${height.inch}',
                  );
                  _controller.cm.value = height.cm;
                  print(
                    "${height.feet}'${height.inch}\" = ${height.cm.toStringAsFixed(2)} cm",
                  );
                },
              );
            },
            child: CustomFormField(
              enable: false,
              label: "",
              hint: AppConstants.hintHeight,
              controller: _controller.heightController,
            ),
          ),
        ],
      ),
    );
  }
}
