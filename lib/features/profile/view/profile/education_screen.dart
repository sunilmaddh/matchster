import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});

  final ProfileController _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: () {
          final qualification = _controller.qualification.value;

          if (qualification.isNotEmpty) {
            _controller.addQualification(qualification.toLowerCase());
          }
        },
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.education,
        onTop: Get.back,
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              AppStrings.whatAboutStudies,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            20.hBox,
            Column(
              children: List.generate(CommonLists.studieList.length, (index) {
                return Obx(() {
                  final isSelected =
                      _controller.selectedEduIndex.value == index;

                  return InkWell(
                    onTap: () {
                      _controller.selectedEduIndex.value = index;
                      _controller.qualification.value =
                          CommonLists.studieList2[index];
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: 15.horizontalPadding,
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color:
                            isSelected
                                ? AppColors.primary
                                : AppColors.educationItemBg,
                      ),
                      child: CommonText.text(
                        CommonLists.studieList[index],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color:
                            isSelected
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                      ),
                    ),
                  );
                });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
