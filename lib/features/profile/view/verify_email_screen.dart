import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/common/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/profile/controller/email_controller.dart';
import 'package:matchster/routes/app_navigation.dart';
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
        title: CommonText.headlineSmall(
          "Verify Email",

          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: 20.allPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.text(
              "Enter valid email ID",
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              color: AppColors.blackColor,
            ),
            15.hBox,
            CommonText.text(
              "Please enter a valid email address to continue.",
              fontSize: 14.sp,
              maxLines: 2,
              fontWeight: FontWeight.w400,
              color: Color(0xff666666),
            ),
            30.hBox,

            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter email";
                      }
                      if (!AppMethods.isValidEmail(value.trim())) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                    label: "Email",
                    hint: "Enter your email",
                    enableBorder: _controller.isValidEmail,
                  ),
                ],
              ),
            ),
            const Spacer(),

            AppButton(
              name: "Verify",
              isEnable: true,
              onTop: () {
                if (_formKey.currentState!.validate()) {
                  _controller.sendEmailOtp(emailController.text.trim());
                  AppNavigation.to(
                    AppRoutes.verifyEmailOtpScreen,
                    arguments: emailController.text,
                  );
                }
              },
            ),
            // InkWell(
            //   onTap: () {
            //     _controller.sendEmailOtp(emailController.text);
            //   },
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: MediaQuery.of(context).size.width,
            //     height: 65.h,
            //     decoration: BoxDecoration(
            //       gradient: AppColors.gradiantPrimary,
            //       borderRadius: BorderRadius.circular(20.r),
            //       // BorderRadius.only(
            //       //   topLeft: Radius.circular(20.r),
            //       //   topRight: Radius.circular(20.r),
            //       // ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         15.wBox,
            //         CommonText.text(
            //           "verify",
            //           fontSize: 16.sp,
            //           fontWeight: FontWeight.w500,
            //           color: AppColors.whiteColor,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            15.hBox,
          ],
        ),
      ),
    );
  }
}
