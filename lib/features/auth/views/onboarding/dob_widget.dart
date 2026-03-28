import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/extentions/date_x_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';

class DobWidget extends StatelessWidget {
  DobWidget({super.key});
  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.displaySmall(
            AppConstants.whatYourDob,

            fontWeight: FontWeight.w600,
          ),

          // 20.hBox,
          CommonText.titleMedium(
            maxLines: 2,
            AppConstants.dobDiscription,

            fontWeight: FontWeight.w400,
          ),
          20.hBox,
          InkWell(
            onTap: () async {
              _controller.isBottomSheetOpen.value = true;
              await CustomBottomSheet.show(
                child: SizedBox(
                  height: 300.h, // fixed & predictable
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// CLOSE BUTTON
                      Obx(
                        () => Align(
                          alignment: Alignment.centerRight,
                          child: CircleButtonWidget(
                            size: 50,
                            isEnable: _controller.isButtonEnabled.value,
                            onTap: () async {
                              if (_controller.isButtonEnabled.value) {
                                _controller.isNextPageEnable.value = false;
                                final current = _controller.currentIndex.value;
                                final isSuccess = await _controller.submitStep(
                                  current,
                                );

                                _controller.completeStep(current);
                              }
                              Get.back();
                              AppMethods.hideKeyboard();
                            },
                          ),
                        ),
                      ),

                      /// DATE PICKER
                      Expanded(
                        child: CupertinoDatePicker(
                          itemExtent: 50,
                          mode: CupertinoDatePickerMode.date,
                          dateOrder: DatePickerDateOrder.dmy,
                          initialDateTime: DateTime.now().eighteenYearsAgo,
                          minimumDate: DateTime(1925),
                          maximumDate: DateTime(2050),
                          onDateTimeChanged: (DateTime newDate) {
                            final formattedDate = DateFormat(
                              'yyyy-MM-dd',
                            ).format(newDate);

                            _controller.dobController.value = newDate.readable;
                            _controller.selectedDob.value = formattedDate;

                            _controller
                                .isDobSelected
                                .value = AppMethods.isAge18OrAbove(newDate);

                            _controller.updateButtonState();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
              _controller.isBottomSheetOpen.value = false;
            },
            child: Obx(
              () => Container(
                padding: 15.horizontalPadding,
                alignment: Alignment.centerLeft,
                width: Get.width,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    width: 1.w,
                    color:
                        _controller.isEnable.value
                            ? AppColors.textFieldColor
                            : AppColors.blackColor.withAlpha(64),
                  ),
                ),
                child: CommonText.titleLarge(
                  _controller.dobController.isNotEmpty
                      ? _controller.dobController.value
                      : "Select your birthdate",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  color:
                      _controller.dobController.isNotEmpty
                          ? AppColors.blackColor
                          : AppColors.blackColor.withAlpha(128),
                ),
              ),
            ),
          ),
          10.hBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 20),
              5.wBox,

              Flexible(
                child: RichText(
                  maxLines: 3,
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Caros",
                    ),

                    children: [
                      TextSpan(
                        text: AppConstants.dobNote1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Caros",
                        ),
                      ),
                      TextSpan(
                        text: AppConstants.dobNote2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Caros",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: AppConstants.dobNote3,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Caros",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
