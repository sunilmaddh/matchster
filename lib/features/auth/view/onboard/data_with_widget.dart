import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_font_type.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/switch_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';

class DateWidget extends StatelessWidget {
  DateWidget({super.key});
  final _controller = Get.find<OnboardController>();
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.displaySmall(
            maxLines: 2,
            AppConstants.datingTitle,
            fontWeight: FontWeight.w600,
          ),

          2.hBox,
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: CommonText.titleMedium(
              maxLines: 3,
              AppConstants.dateDescription,

              fontWeight: FontWeight.w400,
            ),
          ),
          20.hBox,
          Padding(
            padding: 8.horizontalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.text(
                  AppStrings.openToDateEverybody,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
                Obx(
                  () => GradientSwitch(
                    value: _controller.isDateWithSwitchOn.value,
                    onChanged: _controller.toggleDateSwitch,
                  ),
                ),
              ],
            ),
          ),

          10.hBox,

          Expanded(
            child: ListView.builder(
              itemCount: OnboardHalper.dateList.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => Padding(
                    padding: 5.verticalPadding,
                    child: InkWell(
                      onTap: () => _controller.toggleDateSelection(index),
                      child: Container(
                        padding: 10.horizontalPadding + 8.verticalPadding,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color:
                                _controller.selectedDates.contains(index)
                                    ? Color(0xff1D48EF)
                                    : _controller.isDateWithSwitchOn.value
                                    ? Color(0xff1D48EF)
                                    : Color(0xffEBEBEB),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.titleLarge(
                              fontType: AppFontType.mono,
                              AppMethods.capitalizeFirst(
                                OnboardHalper.dateList[index],
                              ),
                            ),

                            // ✔ filled checkbox if selected, else outline
                            _controller.selectedDates.contains(index)
                                ? SvgPicture.asset(AppAssets.checkboxFill)
                                : _controller.isDateWithSwitchOn.value
                                ? SvgPicture.asset(AppAssets.checkboxFill)
                                : SvgPicture.asset(AppAssets.checkBoxOutline),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
