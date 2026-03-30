import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/validation_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/email_controller.dart';
import 'package:matchster/features/profile/view/verify_email_otp_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final _controller = Get.find<EmailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
        title: CommonText.headlineSmall(AppStrings.verifyEmail),
        centerTitle: true,
      ),
      body: Padding(
        padding: 20.allPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.headlineMedium(
              AppStrings.enterValidEmailTitle,
              fontWeight: FontWeight.w900,
            ),
            15.hBox,
            CommonText.labelLarge(
              ValidationStrings.enterValidEmailDesc,
              maxLines: 2,
              fontWeight: FontWeight.w400,
              color: const Color(0xff666666),
            ),
            30.hBox,

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: AppStrings.emailLabel,
                      hintText: AppStrings.emailHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ValidationStrings.emailValidation;
                      }
                      AppMethods.isValid(value);
                      return null;
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  String email = emailController.text.trim();
                  await _controller.sendEmailOtp(email);
                  _controller.navigateTo(
                    AppRoutes.verifyEmailOtpScreen,
                    arguments: email,
                  );
                  // Get.to(() => VerifyEmailOtpScreen(), arguments: email);
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 65.h,
                decoration: BoxDecoration(
                  gradient: AppColors.gradiantPrimary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CommonText.titleMedium(
                  AppStrings.verify,
                  color: AppColors.whiteColor,
                ),
              ),
            ),

            15.hBox,
          ],
        ),
      ),
    );
  }
}
