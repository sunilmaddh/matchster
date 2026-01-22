import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/widgets/common_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/sub_common_card.dart';

class InterestWrapWidget extends StatelessWidget {
  const InterestWrapWidget({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return CommonWrapWidget(
      listWidget:
          list.map((v) {
            return SubCommonCard(
              widget: CommonText.text(
                AppMethods.capitalizeFirst(v),
                color: AppColors.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                fontFamily: "Caros",
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     v["image"] != null
              //         ? Image.asset(v["image"], height: 11.h, width: 12.w)
              //         : SizedBox.shrink(),
              //     10.wBox,
              //     CommonText.text(
              //       v["value"],
              //       color: AppColors.blackColor,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w300,
              //       fontFamily: "Caros",
              //     ),
              //   ],
              // ),
            );
          }).toList(),
    );
  }
}
