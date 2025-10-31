import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleButtonWidget(
        icon: Icons.check,
        isEnable: true,
        onTap: () {},
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
            10.hBox,
            Column(
              children:
                  List.generate(5, (index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: 15.horizontalPadding,
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 48.h,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        color: Color(0xffE8E8E8),
                      ),
                      child: CommonText.text(
                        "Diploma",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
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
