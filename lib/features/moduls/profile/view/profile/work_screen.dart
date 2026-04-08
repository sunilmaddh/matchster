import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';

class WorkScreen extends StatelessWidget {
  WorkScreen({super.key});

  final _controller = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => CircleButtonWidget(
          icon: Icons.check,
          isEnable: _controller.isEditEnable.isTrue,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              _controller.addWork(
                jobTitle: _controller.jobTtileController.text,
                company: _controller.companyController.text,
              );
            }
          },
        ),
      ),

      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Work",
        onTop: () {
          Get.back();
        },
      ),

      body: Padding(
        padding: 15.horizontalPadding,
        child: Form(
          key: _formKey,
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

              20.hBox,

              /// Job Title
              CommonText.text("Job title"),
              10.hBox,

              CustomFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                  FirstLetterUpperCaseFormatter(),
                ],
                label: "",
                hint: "Enter your job title",
                controller: _controller.jobTtileController,
                enableBorder: false.obs,
                onChanged: (job) {
                  if (job!.isNotEmpty &&
                      _controller.companyController.text.isNotEmpty) {
                    _controller.isEditEnable.value = true;
                  } else {
                    _controller.isEditEnable.value = false;
                  }
                },
              ),

              20.hBox,

              /// Company
              CommonText.text("Company(or industry)"),
              10.hBox,
              CustomFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                  FirstLetterUpperCaseFormatter(),
                ],
                label: "",
                hint: "Enter your company name",
                controller: _controller.companyController,
                enableBorder: false.obs,
                onChanged: (com) {
                  if (com!.isNotEmpty &&
                      _controller.jobTtileController.text.isNotEmpty) {
                    _controller.isEditEnable.value = true;
                  } else {
                    _controller.isEditEnable.value = false;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Formatter to capitalize first letter
class FirstLetterUpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final text = newValue.text[0].toUpperCase() + newValue.text.substring(1);
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
