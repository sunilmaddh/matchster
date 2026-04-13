import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/routes/app_navigation.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.list,
    this.isSelctOnlyOne,
    required this.onTop,
    required this.isSelected,
    required this.onTopButton,
    // required this.onTapBack,
    required this.appBarTitle,
  });

  final String image;
  final String title;
  final String appBarTitle;
  final String subtitle;
  final List<String> list;
  final bool? isSelctOnlyOne;
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
        title: appBarTitle,
        isCenterTitle: false,
        onTop: () {
          AppNavigation.back();
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: 15.horizontalPadding + 15.verticalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(height: 66.h, width: 66.w, image),
              40.hBox,
              CommonText.text(
                textAlign: TextAlign.center,
                title,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              CommonText.text(
                subtitle,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
              20.hBox,
              Obx(
                () => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,

                  alignment: WrapAlignment.start,
                  spacing: 10,

                  // runSpacing: 10,
                  children:
                      list.map((v) {
                        final selected = isSelected(v);
                        return GestureDetector(
                          onTap: () {
                            if ((isSelctOnlyOne == true) && isSelected(v))
                              return;
                            onTop(v);
                          },
                          child: Container(
                            margin: 5.verticalPadding,

                            decoration: BoxDecoration(
                              gradient:
                                  selected ? AppColors.gradiantPrimary : null,
                              color: !selected ? Color(0xffE8E8E8) : null,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                                vertical: 10.0,
                              ),
                              child: CommonText.labelLarge(
                                v,
                                color:
                                    selected
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
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
      ),
    );
  }
}
