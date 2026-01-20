import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/widgets/toggle_button_widget.dart';

class HeightScreen extends StatelessWidget {
  HeightScreen({super.key});

  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: () {},
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Height",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,

            CommonText.text(
              "What is your Height",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Caros",
            ),
            10.hBox,
            CommonText.text(
              maxLines: 2,
              "Share your height to help others to get to know you better",
              fontSize: 16.sp,
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
                    _controller.heightController.text =
                        "${height.feet} feet, ${height.inch} inch";
                    print(
                      "${height.feet}'${height.inch}\" = ${height.cm.toStringAsFixed(2)} cm",
                    );
                    // _controller.feet.value = height.feet;
                    print(
                      "${height.feet}'${height.inch}\" = ${height.cm.toStringAsFixed(2)} cm",
                    );
                  },
                );
              },
              child: CustomFormField(
                enableBorder: true.obs,
                enable: false,
                label: "",
                hint: AppConstants.hintHeight,
                controller: _controller.heightController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
