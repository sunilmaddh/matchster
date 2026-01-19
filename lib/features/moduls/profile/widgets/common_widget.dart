import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.list,
    required this.onTop,
    required this.isSelected,
    required this.onTopButton,
  });

  final String image;
  final String title;
  final String subtitle;
  final List<String> list;
  final VoidCallback onTopButton;
  final Function(String) onTop; // changed to accept selected item
  final bool Function(String) isSelected; // dynamic item-based selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: onTopButton,
      ),
      appBar: CustomAppBar(
        title: "Workout",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding + 15.verticalPadding,
        child: Column(
          children: [
            Image.asset(height: 66.h, width: 66.w, image),
            20.hBox,
            CommonText.text(
              title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            CommonText.text(
              subtitle,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
            30.hBox,
            Obx(
              () => Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceAround,
                spacing: 10,

                // runSpacing: 10,
                children:
                    list.map((v) {
                      final selected = isSelected(v);
                      return GestureDetector(
                        onTap: () => onTop(v),
                        child: Container(
                          margin: 5.verticalPadding,
                          padding: 10.horizontalPadding + 4.verticalPadding,
                          decoration: BoxDecoration(
                            gradient:
                                selected ? AppColors.gradiantPrimary : null,
                            color: !selected ? Color(0xffE8E8E8) : null,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CommonText.text(
                            v,
                            color:
                                selected
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Caros",
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
