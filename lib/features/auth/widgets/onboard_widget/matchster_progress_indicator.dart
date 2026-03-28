import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class MatchsterProgressIndicator extends StatelessWidget {
  const MatchsterProgressIndicator({
    super.key,
    required this.pages,
    required this.valueCurrentIndex,
    this.isLarge = false,
  });

  final ValueNotifier<int> valueCurrentIndex;
  final List<dynamic> pages;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: valueCurrentIndex,
      builder: (context, currentIndex, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Step Progress (each as a small card)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                final bool isCompleted = index < currentIndex;
                final bool isCurrent = index == currentIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  // margin: 5.horizontalPadding,
                  width: isCurrent ? 50.w : 50.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient:
                        isCompleted || isCurrent
                            ? AppColors.gradiantPrimary
                            : LinearGradient(
                              colors: [Color(0xffD1E8FD), Color(0xffD1E8FD)],
                            ),

                    // color:
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),

            10.wBox,

            CommonText.text(
              '${currentIndex + 1}/${pages.length}',

              fontSize: isLarge ? 16.sp : 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ],
        );
      },
    );
  }
}
