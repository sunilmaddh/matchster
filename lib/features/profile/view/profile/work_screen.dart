import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/common/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';

class WorkScreen extends StatelessWidget {
  WorkScreen({super.key});

  final ProfileController _controller = Get.find<ProfileController>();
  final ProfileFormController _formController =
      Get.find<ProfileFormController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _updateButtonState() {
    final hasJobTitle =
        _formController.jobTitleController.text.trim().isNotEmpty;
    final hasCompany = _formController.companyController.text.trim().isNotEmpty;

    _formController.isEditEnable.value = hasJobTitle && hasCompany;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => CircleButtonWidget(
          icon: Icons.check,
          isEnable: _formController.isEditEnable.value,
          onTap: () {
            if (_formKey.currentState?.validate() ?? false) {
              _controller.addWork(
                jobTitle: _formController.jobTitleController.text.trim(),
                company: _formController.companyController.text.trim(),
              );
            }
          },
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.work,
        onTop: Get.back,
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
                AppStrings.whatAboutYourWork,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Caros",
              ),
              20.hBox,
              CommonText.text(AppStrings.jobTitle),
              10.hBox,
              CustomFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
                label: '',
                hint: AppStrings.enterYourJobTitle,
                controller: _formController.jobTitleController,
                enableBorder: false.obs,
                onChanged: (_) => _updateButtonState(),
              ),
              20.hBox,
              CommonText.text(AppStrings.companyOrIndustry),
              10.hBox,
              CustomFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
                label: '',
                hint: AppStrings.enterYourCompanyName,
                controller: _formController.companyController,
                enableBorder: false.obs,
                onChanged: (_) => _updateButtonState(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
