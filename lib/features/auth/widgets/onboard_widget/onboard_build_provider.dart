// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/widgets/onboard_widget/matchster_progress_indicator.dart';

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
      floatingActionButton: Obx(
        () => AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: 0.h,
            //  _onboardController.isBottomSheetOpen.isTrue ? 320.h : 0.h,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: 10.allPadding,
              child: CircleButtonWidget(
                isEnable: _onboardController.isButtonEnabled.value,
                onTap: () async {
                  if (_onboardController.isButtonEnabled.value) {
                    _onboardController.isNextPageEnable.value = false;
                    final current = _onboardController.currentIndex.value;
                    final isSuccess = await _onboardController.submitStep(
                      current,
                    );

                    _onboardController.completeStep(current);
                  }
                  AppMethods.hideKeyboard();

                  // if (!isSuccess) return;
                  // _onboardController.completeStep(current);
                },
              ),
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
                _onboardController.isButtonEnabled;
                _onboardController.updateButtonState();
              },
              itemBuilder: (_, index) => pages[index],
            ),
          ),
        ],
      ),
    );
  }
}
