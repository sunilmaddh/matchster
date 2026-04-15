import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/gender_preference_extension.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/chat/widget/text_with_widget.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';

class GenderPreferenceWidget extends StatelessWidget {
  const GenderPreferenceWidget({super.key, required this.controller});

  final FilterController controller;
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      isBorder: false,
      color: AppColors.filterCardColor,
      widget: PreferenceWidget(
        title: AppStrings.filterString.preference,
        subtitle: AppStrings.filterString.preferenceSub,
        list: GenderPreferenceExtension.list.toSet().toList(),
        onTop: (v) {
          if (controller.selectedGender.contains(v)) {
            controller.selectedGender.remove(v);
          } else {
            controller.selectedGender.add(v);
          }
        },
        isSelected: (v) => controller.selectedGender.contains(v),
      ),
    );
  }
}

class PreferenceWidget extends StatelessWidget {
  const PreferenceWidget({
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonText.labelLarge(
                                  v,
                                  color: AppColors.whiteColor,
                                ),
                                5.wBox,
                                selected
                                    ? Icon(
                                      Icons.check_box_outlined,
                                      color: AppColors.whiteColor,
                                      size: 18,
                                    )
                                    : Icon(
                                      Icons.check_box_outline_blank,
                                      color: AppColors.whiteColor,
                                      size: 18,
                                    ),
                              ],
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
