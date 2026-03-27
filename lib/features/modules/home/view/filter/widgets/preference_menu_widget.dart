import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/common_gradient_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class PreferenceMenuWidget extends StatelessWidget {
  const PreferenceMenuWidget({
    super.key,
    required this.list,
    required this.onTop,
  });
  final List<String> list;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children:
          list.map((v) {
            return InkWell(
              onTap: onTop,
              child: CommonGradientCard(
                widget: Padding(
                  padding: 10.horizontalPadding + 5.verticalPadding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonText.text(
                        v,
                        color: AppColors.whiteColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      5.wBox,
                      Icon(
                        Icons.check_box_outlined,
                        color: AppColors.whiteColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
