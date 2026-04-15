import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/routes/app_navigation.dart';

class FilterBottomsheet {
  static void show({
    required final List<String> list,
    final bool? isSelctOnlyOne,
    required Function(String) onTop,
    required bool Function(String) isSelected,
  }) {
    CustomBottomSheet.show(
      child: Obx(
        () => SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton.outlined(
                  onPressed: () {
                    AppNavigation.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              Wrap(
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
            ],
          ),
        ),
      ),
    );
  }
}
