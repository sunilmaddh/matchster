import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

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
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width:
                      isCurrent
                          ? (isLarge ? 28.w : 20.w)
                          : (isLarge ? 22.w : 16.w),
                  height: isLarge ? 8.h : 6.h,
                  decoration: BoxDecoration(
                    color:
                        isCompleted || isCurrent
                            ? const Color(0xff1B8CF5)
                            : const Color(0xffD1E8FD),
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),

            10.wBox,

            CommonText.text(
              '${currentIndex + 1} / ${pages.length}',

              fontSize: isLarge ? 16.sp : 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1B8CF5),
            ),
          ],
        );
      },
    );
  }
}
