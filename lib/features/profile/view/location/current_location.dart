import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/buttons/app_button.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.currentLocation,
        onTop: Get.back,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: 20.horizontalPadding + 20.verticalPadding,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.black.withAlpha(77)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 65.h,
                  decoration: BoxDecoration(
                    gradient: AppColors.gradiantPrimary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding: 12.horizontalPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.locations),
                        15.wBox,
                        Expanded(
                          child: CommonText.text(
                            AppStrings.currentLocation,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                30.hBox,
                Padding(
                  padding: 7.horizontalPadding,
                  child: CommonText.text(
                    AppStrings.changeCurrentLocationTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                10.hBox,
                Padding(
                  padding: 15.horizontalPadding,
                  child: CommonText.text(
                    AppStrings.changeCurrentLocationDescription,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                40.hBox,
                SubscriptionRow(
                  selectedIndex: selectedIndex,
                  onPlanSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                20.hBox,
                const PlanTypeFaqList(),
                30.hBox,
                Padding(
                  padding: 20.horizontalPadding,
                  child: AppButton(
                    isEnable: true,
                    name: AppStrings.upgradeToChange,
                    onTop: () {
                      // Add premium purchase action here
                    },
                  ),
                ),
                20.hBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlanTypeFaqList extends StatelessWidget {
  const PlanTypeFaqList({super.key});

  static const List<Map<String, String>> faqItems = [
    {
      "title": AppStrings.lookDifferent,
      "subtitle": AppStrings.premiumProfileCover,
    },
    {
      "title": AppStrings.lookDifferent,
      "subtitle": AppStrings.premiumProfileCover,
    },
    {
      "title": AppStrings.lookDifferent,
      "subtitle": AppStrings.premiumProfileCover,
    },
    {
      "title": AppStrings.lookDifferent,
      "subtitle": AppStrings.premiumProfileCover,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 8.allPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            faqItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check, color: Colors.black, size: 20),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: item["title"],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: item["subtitle"],
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
            }).toList(),
      ),
    );
  }
}

class SubscriptionRow extends StatelessWidget {
  const SubscriptionRow({
    super.key,
    required this.selectedIndex,
    required this.onPlanSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onPlanSelected;

  static const List<Map<String, String>> plans = [
    {
      "duration": AppStrings.three,
      "label": AppStrings.month,
      "price": AppStrings.priceThreeMonth,
      "unit": AppStrings.unitThreeMonth,
      "discount": AppStrings.discountTen,
    },
    {
      "duration": AppStrings.one,
      "label": AppStrings.week,
      "price": AppStrings.priceOneWeek,
      "unit": AppStrings.unitOneWeek,
      "discount": AppStrings.discountFortyFive,
      "tag": AppStrings.popular,
    },
    {
      "duration": AppStrings.one,
      "label": AppStrings.month,
      "price": AppStrings.priceOneMonth,
      "unit": AppStrings.unitOneMonth,
      "discount": AppStrings.discountTwenty,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(plans.length, (index) {
        final plan = plans[index];
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onPlanSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 106.w,
            height: isSelected ? 190.h : 183.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 20.r : 0),
                bottomLeft: Radius.circular(index == 0 ? 20.r : 0),
                topRight: Radius.circular(index == plans.length - 1 ? 20.r : 0),
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
                      : Border.all(color: Colors.black.withAlpha(77)),
              boxShadow:
                  isSelected
                      ? [
                        BoxShadow(
                          color: const Color(0xff1B8CF5).withAlpha(77),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ]
                      : [],
            ),
            child: Column(
              children: [
                if (plan["tag"] != null)
                  Container(
                    width: double.infinity,
                    height: 22.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xffFFC592).withAlpha(128),
                          const Color(0xff1B8CF5).withAlpha(128),
                        ],
                      ),
                    ),
                    child: CommonText.text(
                      plan["tag"]!,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                  ),
                8.hBox,
                CommonText.text(
                  plan["duration"]!,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xff1B8CF5) : Colors.black,
                ),
                CommonText.text(
                  plan["label"]!,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                ),
                RichText(
                  text: TextSpan(
                    text: plan["price"]!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: plan["unit"]!,
                        style: TextStyle(
                          color: Colors.black,
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
                    plan["discount"]!,
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
    );
  }
}
