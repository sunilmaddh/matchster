import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/filter/controller/common_swip_button_controller.dart';

class CommonSwipeButton extends StatelessWidget {
  const CommonSwipeButton({
    super.key,
    required this.tag,
    required this.text,
    required this.onSwipeComplete,
    this.height = 48,
    this.borderRadius = 20,
    this.doneText = 'Done',
  });

  final String tag;
  final String text;
  final String doneText;
  final VoidCallback onSwipeComplete;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final CommonSwipeButtonController controller =
        Get.isRegistered<CommonSwipeButtonController>(tag: tag)
            ? Get.find<CommonSwipeButtonController>(tag: tag)
            : Get.put(CommonSwipeButtonController(), tag: tag);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double thumbSize = height - 8;
        final double maxDrag = constraints.maxWidth - thumbSize - 8;

        return Container(
          padding: 1.allPadding,
          height: height,
          decoration: BoxDecoration(
            gradient: AppColors.gradiantPrimary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Obx(
            () => Stack(
              children: [
                Center(
                  child: Text(
                    controller.isCompleted.value ? doneText : text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  left: controller.dragPosition.value + 4,
                  top: 4,
                  bottom: 4,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      controller.updateDrag(
                        delta: details.delta.dx,
                        maxDrag: maxDrag,
                      );
                    },
                    onHorizontalDragEnd: (_) {
                      controller.handleDragEnd(
                        maxDrag: maxDrag,
                        onSwipeComplete: onSwipeComplete,
                      );
                    },
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.check, color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
