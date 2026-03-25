import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/view/verify_email_otp_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final _controller = Get.find<ProfileController>();

  Future<void> sendEmailOtp() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();

      await _controller.sendEmailOtp(email);

      Get.to(
        () => VerifyEmailOtpScreen(),
        arguments: email, // 👈 pass email
      );
    }
  }

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
        title: CommonText.text(
          "Verify Email",
          fontSize: 18.sp,
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
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                sendEmailOtp();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 65.h,
                decoration: BoxDecoration(
                  gradient: AppColors.gradiantPrimary,
                  borderRadius: BorderRadius.circular(20.r),
                  // BorderRadius.only(
                  //   topLeft: Radius.circular(20.r),
                  //   topRight: Radius.circular(20.r),
                  // ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    15.wBox,
                    CommonText.text(
                      "verify",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ],
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
