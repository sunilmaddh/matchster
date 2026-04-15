import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class FilterCommonWidget extends StatelessWidget {
  const FilterCommonWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.list,
    this.isSelctOnlyOne,
    required this.onTop,
    required this.isSelected,
  });
  final String title;

  final String subtitle;
  final List<String> list;
  final bool? isSelctOnlyOne;
  final Function(String) onTop;
  final bool Function(String) isSelected;
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
            Obx(
              () => Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,

                alignment: WrapAlignment.start,
                spacing: 10,
                children:
                    list.map((v) {
                      final selected = isSelected(v);
                      return GestureDetector(
                        onTap: () {
                          if ((isSelctOnlyOne == true) && isSelected(v)) return;
                          onTop(v);
                        },
                        child: Container(
                          margin: 5.verticalPadding,

                          decoration: BoxDecoration(
                            gradient:
                                selected ? AppColors.gradiantPrimary : null,
                            color: !selected ? Color(0xffBABABA) : null,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            ),
                            child: CommonText.labelLarge(
                              v,
                              color: AppColors.whiteColor,
                            ),
                          ),
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
