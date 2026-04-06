import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/auth/helper/onboard_halper.dart';

class CommonBottomSheet {
  static Future<void> showHeightPicker({
    required BuildContext context,
    required List<HeightItem> heightList,
    required HeightItem defaultValue,
    required Function(HeightItem value) onSelected,
    required VoidCallback onTap,
    required final RxBool isEnable,
  }) {
    int selectedIndex = heightList.indexWhere(
      (e) => e.feet == defaultValue.feet && e.inch == defaultValue.inch,
    );

    if (selectedIndex < 0) selectedIndex = 0;

    final controller = FixedExtentScrollController(initialItem: selectedIndex);

    /// ✅ IMPORTANT: return the Future
    return CustomBottomSheet.show(
      child: SizedBox(
        height: 300.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// CLOSE BUTTON
            Obx(
              () => Align(
                alignment: Alignment.centerRight,
                child: CircleButtonWidget(
                  size: 50,
                  isEnable: isEnable.value,

                  onTap: onTap,
                  // _controller.isButtonEnabled.value,
                  // onTap: () async {
                  //   if (_controller.isButtonEnabled.value) {
                  //     _controller.isNextPageEnable.value = false;
                  //     final current = _controller.currentIndex.value;
                  //     final isSuccess = await _controller.submitStep(
                  //       current,
                  //     );

                  //     _controller.completeStep(current);
                  //   }
                  //   AppMethods.hideKeyboard();

                  //   // if (!isSuccess) return;
                  //   // _onboardController.completeStep(current);
                  // },
                ),
              ),
            ),

            /// HEIGHT PICKER (FIXED)
            Expanded(
              child: CupertinoPicker(
                scrollController: controller,
                itemExtent: 50,
                looping: true,
                onSelectedItemChanged: (index) {
                  onSelected(heightList[index]);
                },
                children:
                    heightList.map((item) {
                      return Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${item.feet} feet   ${item.inch} inch",
                              style: TextStyle(
                                fontFamily: "Caros",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            20.wBox,
                            Text(
                              "(${item.cm.toStringAsFixed(2)} cm)",
                              style: TextStyle(
                                fontFamily: "Caros",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
