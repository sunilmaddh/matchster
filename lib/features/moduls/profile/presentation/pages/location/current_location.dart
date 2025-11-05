import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/presentation/controllers/profile_controller.dart';
import 'package:matchster/features/moduls/profile/presentation/pages/location/add_location_screen.dart';
import 'package:matchster/shared/widgets/bar/custom_app_bar.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: "Current Location",
        onTop: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: 20.horizontalPadding + 20.verticalPadding,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.black.withOpacity(0.30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 65.h,
                decoration: BoxDecoration(
                  gradient: AppColors.gradiantPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.locations),
                    15.wBox,
                    CommonText.text(
                      "Jamnagar, India",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
              30.hBox,
              Padding(
                padding: 7.horizontalPadding,
                child: CommonText.text(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  "Want to change your current location?",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.hBox,
              Padding(
                padding: 15.horizontalPadding,
                child: CommonText.text(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  "Don’t miss out! Upgrade to Matchster Premium to change your current location!",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              40.hBox,
              SubscriptionRow(),
              20.hBox,
              PlanTypeFaqList(),
              40.hBox,
              Padding(
                padding: 20.horizontalPadding,
                child: AppButton(
                  isEnable: true,
                  name: 'Upgrade to Change',
                  onTop: () {
                    Get.to(AddLocationScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanTypeFaqList extends StatelessWidget {
  const PlanTypeFaqList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check, color: Colors.black, size: 20),
                SizedBox(width: 8.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "Look Different ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: "(Get a Premium Profile cover)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class SubscriptionRow extends StatelessWidget {
  SubscriptionRow({super.key});

  final controller = Get.find<ProfileController>();

  final List<Map<String, dynamic>> plans = [
    {
      "duration": "3",
      "label": "Month",
      "price": "₹349/",
      "unit": "3mo",
      "discount": "10%",
    },
    {
      "duration": "1",
      "label": "Week",
      "price": "₹49/",
      "unit": "wk",
      "discount": "45%",
      "tag": "Popular",
    },
    {
      "duration": "1",
      "label": "Month",
      "price": "₹149/",
      "unit": "mo",
      "discount": "20%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(plans.length, (index) {
          final plan = plans[index];
          final isSelected = controller.selectedIndex.value == index;

          return GestureDetector(
            onTap: () => controller.selectedIndex.value = index,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 0.w),
              width: 106.w,
              height: isSelected ? 190.h : 183.h, // subtle height bump
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(index == 0 ? 20.r : 0),
                  bottomLeft: Radius.circular(index == 0 ? 20.r : 0),
                  topRight: Radius.circular(
                    index == plans.length - 1 ? 20.r : 0,
                  ),
                  bottomRight: Radius.circular(
                    index == plans.length - 1 ? 20.r : 0,
                  ),
                ),
                color: Colors.white,
                border:
                    isSelected
                        ? const GradientBoxBorder(
                          width: 2,
                          gradient: LinearGradient(
                            colors: [Color(0xff1B8CF5), Color(0xffFFC100)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        )
                        : Border.all(color: Colors.black.withOpacity(0.3)),
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: const Color(0xff1B8CF5).withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ]
                        : [],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top tag for "Popular"
                  if (plan["tag"] != null)
                    Container(
                      width: double.infinity,
                      height: 22.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffFFC592).withOpacity(0.5),
                            const Color(0xff1B8CF5).withOpacity(0.5),
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: CommonText.text(
                        plan["tag"],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  8.hBox,
                  CommonText.text(
                    plan["duration"],
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? const Color(0xff1B8CF5) : Colors.black,
                  ),
                  CommonText.text(
                    plan["label"],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      text: plan["price"],
                      children: [
                        TextSpan(
                          text: plan["unit"],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.hBox,
                  Container(
                    padding: 2.horizontalPadding + 2.verticalPadding,
                    alignment: Alignment.center,
                    width: 76.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: CommonText.text(
                      plan["discount"],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff1B8CF5),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
