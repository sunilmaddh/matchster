import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';

class DateWidget extends StatelessWidget {
  DateWidget({super.key});
  final _controller = Get.find<OnboardController>();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            maxLines: 2,
            AppConstants.datingTitle,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),

          // 10.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.dateDescription,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          20.hBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText.text(
                "Open to Date Everybody",
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
              Obx(
                () => Switch(
                  focusColor: Color(0xff1D48EF),
                  activeTrackColor: Color(0xff1D48EF),
                  padding: EdgeInsets.zero,
                  value: _controller.isSwitchOn.value,
                  onChanged:
                      _controller
                          .toggleDateSwitch, // ← Select All / Unselect All
                ),
              ),
            ],
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
                                    : _controller.isSwitchOn.value
                                    ? Color(0xff1D48EF)
                                    : Color(0xffEBEBEB),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.text(
                              fontFamily: "DM Sans",
                              color: AppColors.blackColor,
                              AppMethods.capitalizeFirst(
                                OnboardHalper.dateList[index],
                              ),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),

                            // ✔ filled checkbox if selected, else outline
                            _controller.selectedDates.contains(index)
                                ? SvgPicture.asset(AppAssets.checkboxFill)
                                : _controller.isSwitchOn.value
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
