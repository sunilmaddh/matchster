import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/modules/profile/controller/profile_controller.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});
  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: () {
          debugPrint(_controller.qualification.toString());
          _controller.addQualification(
            qualification: _controller.qualification.value.toLowerCase(),
          );
        },
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Education",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              "What about your studies?",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            20.hBox,
            Column(
              children:
                  List.generate(CommonLists.studieList.length, (index) {
                    return Obx(
                      () => InkWell(
                        onTap: () {
                          _controller.selectedEduIndex.value = index;
                          _controller.qualification.value =
                              CommonLists.studieList2[index];
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: 15.horizontalPadding,
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: 48.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            color:
                                _controller.selectedEduIndex.value == index
                                    ? AppColors.primary
                                    : Color(0xffE8E8E8),
                          ),
                          child: CommonText.text(
                            CommonLists.studieList[index],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color:
                                _controller.selectedEduIndex.value == index
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
