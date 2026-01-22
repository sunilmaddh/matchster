import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/widgets/common_wrap_widget.dart';

class InshortWrapWidget extends StatelessWidget {
  const InshortWrapWidget({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return CommonWrapWidget(
      listWidget:
          list.map((v) {
            return v.isNotEmpty
                ? Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CommonText.text(AppMethods.capitalizeFirst(v)),
                )
                : SizedBox.shrink();
          }).toList(),
    );
  }
}
