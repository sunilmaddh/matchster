// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/app_toast_message.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/widgets/matchster_progress_indicator.dart';

class OnboardPageViewBuilder extends StatelessWidget {
  OnboardPageViewBuilder({super.key, required this.pages});

  final List<Widget> pages;
  final _onboardController = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    // sync initial index for progress indicator
    _onboardController.currentIndex.value =
        _onboardController.firstIncompleteIndex;

    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: 10.allPadding,
          child: Obx(
            () =>
                _onboardController.isPageLoading.isTrue
                    ? CircularProgressIndicator(color: AppColors.primary)
                    : CircleButtonWidget(
                      isEnable: _onboardController.isEnable.value,
                      onTap: () async {
                        _onboardController.isNextPageEnable.value = false;
                        final current = _onboardController.currentIndex.value;
                        final isSuccess = await _onboardController.submitStep(
                          current,
                        );
                        if (!isSuccess) return;
                        _onboardController.completeStep(current);
                      },
                    ),
          ),
        ),
      ),
      body: Column(
        children: [
          MatchsterProgressIndicator(
            isLarge: true,
            pages: pages,
            valueCurrentIndex: _onboardController.currentIndex,
          ),
          Expanded(
            child: PageView.builder(
              controller: _onboardController.pageController,
              itemCount: pages.length,
              physics: const NeverScrollableScrollPhysics(), // 🔒 lock swipe
              onPageChanged: (index) {
                _onboardController.currentIndex.value = index;
                _onboardController.isEnable.value = false;
              },
              itemBuilder: (_, index) => pages[index],
            ),
          ),
        ],
      ),
    );
  }
}
