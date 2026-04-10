import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/profile/controller/profile_email_controller.dart';

// ignore: must_be_immutable
class VerifyEmailScreen extends BaseView<ProfileEmailController> {
  VerifyEmailScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void onDispose(ProfileEmailController controller) {
    emailController.clear();
    super.onDispose(controller);
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: controller.navigateBack,
        ),
        title: CommonText.text(
          AppConstants.verifyEmailTitle,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: 20.allPadding,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.text(
                AppConstants.enterValidEmailTitle,
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: AppColors.blackColor,
              ),
              15.hBox,
              CommonText.text(
                AppConstants.enterValidEmailDescription,
                fontSize: 14.sp,
                maxLines: 2,
                fontWeight: FontWeight.w400,
                color: const Color(0xff666666),
              ),
              30.hBox,
              CustomFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppConstants.enterEmailValidation;
                  }
                  if (!AppMethods.isValidEmail(value)) {
                    return AppConstants.enterValidEmailValidation;
                  }
                  return null;
                },
                label: AppConstants.emailLabel,
                hint: AppConstants.emailHint,
                enableBorder: true.obs,
              ),

              const Spacer(),
              AppButton(
                isEnable: true,
                name: AppConstants.verifyButton,
                onTop: () {
                  if (formKey.currentState!.validate()) {
                    controller.sendEmailOtp(emailController.text);
                  }
                },
              ),
              15.hBox,
            ],
          ),
        ),
      ),
    );
  }
}
