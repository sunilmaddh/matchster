import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';

class CommonBottomSheet {
  static void showHeightPicker({
    required BuildContext context,
    required List<HeightItem> heightList,
    required HeightItem defaultValue,
    required Function(HeightItem value) onSelected,
  }) {
    int selectedIndex = heightList.indexWhere(
      (e) => e.feet == defaultValue.feet && e.inch == defaultValue.inch,
    );

    if (selectedIndex < 0) selectedIndex = 0;

    final controller = FixedExtentScrollController(initialItem: selectedIndex);

    CustomBottomSheet.show(
      child: SizedBox(
        height: 300.h,
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
                        // item.label, // 🔥 5 feet 1 inch (154.94 cm)
                        style: TextStyle(
                          fontFamily: "Caros",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      20.wBox,
                      Text(
                        "(${item.cm.toStringAsFixed(2)} cm)", // 🔥 5 feet 1 inch (154.94 cm)
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
    );
  }
}
