import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class CommonWrapWidget extends StatelessWidget {
  const CommonWrapWidget({
    super.key,
    required this.list,
    this.boxColor = AppColors.whiteColor,
    this.borderColor = AppColors.whiteColor,
  });

  final List<Map<String, dynamic>> list;
  final Color boxColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children:
          list.map((v) {
            return Container(
              padding: 10.horizontalPadding + 4.verticalPadding,
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: borderColor, width: 1.w),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  v["image"] != null
                      ? Image.asset(v["image"], height: 11.h, width: 12.w)
                      : SizedBox.shrink(),
                  10.wBox,
                  CommonText.text(
                    v["value"],
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Caros",
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
