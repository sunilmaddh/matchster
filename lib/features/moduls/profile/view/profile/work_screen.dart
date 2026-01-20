import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';

class WorkScreen extends StatelessWidget {
  WorkScreen({super.key});

  final _controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Height",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,

            CommonText.text(
              "What about your work?",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Caros",
            ),
            // 10.hBox,
            // CommonText.text(
            //   maxLines: 2,
            //   "Share your height to help others to get to know you better",
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.w400,
            //   fontFamily: "Caros",
            // ),
            20.hBox,
            CommonText.text("Job title"),
            20.hBox,
            CustomFormField(
              label: "",
              hint: "Enter you job title",
              controller: _controller.jobTtileController,
              enableBorder: true.obs,
            ),
            20.hBox,
            CommonText.text("Company(or industry)"),
            20.hBox,
            CustomFormField(
              label: "",
              hint: "Enter you job title",
              controller: _controller.companyController,
              enableBorder: true.obs,
            ),
          ],
        ),
      ),
    );
  }
}
