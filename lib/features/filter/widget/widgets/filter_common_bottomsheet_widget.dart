import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/filter/widget/widgets/filter_bottomsheet.dart';

class FilterCommonBottomsheetWidget extends StatelessWidget {
  const FilterCommonBottomsheetWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.list,
    required this.hintText,
    required this.value,
    required this.controller,
  });
  final String title;
  final String subtitle;
  final List<String> list;
  final String hintText;
  final FilterController controller;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: 5.horizontalPadding + 5.verticalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText.titleMedium(
              textAlign: TextAlign.center,
              title,
              fontWeight: FontWeight.w700,
            ),
            CommonText.labelLarge(subtitle, fontWeight: FontWeight.w500),
            20.hBox,
            InkWell(
              onTap: () {
                FilterBottomsheet.show(
                  list: list,
                  onTop: (v) {
                    if (controller.languageList.contains(v)) {
                      controller.languageList.remove(v);
                    } else {
                      controller.languageList.add(v);
                    }
                  },
                  isSelected: (v) => controller.languageList.contains(v),
                );
              },
              child: Container(
                padding: 7.horizontalPadding + 10.verticalPadding,
                // height: 26.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Color(0xffA4A4A4).withOpacity(0.15),
                  ),
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.labelLarge(controller.languageList.join(',')),
                      Icon(Icons.arrow_drop_down, size: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
