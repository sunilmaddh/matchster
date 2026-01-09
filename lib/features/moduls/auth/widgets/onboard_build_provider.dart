// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/widgets/matchster_progress_indicator.dart';
import 'package:matchster/features/moduls/home/view/landing_screen.dart';

class OnboardPageViewBuilder extends StatelessWidget {
  OnboardPageViewBuilder({super.key, required this.pages});

  final List<Widget> pages;
  final _onboardController = Get.find<OnboardController>();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  late final PageController _pageController = PageController(
    initialPage: _onboardController.firstIncompleteIndex,
  );

  @override
  Widget build(BuildContext context) {
    // sync initial index for progress indicator
    _currentIndex.value = _onboardController.firstIncompleteIndex;

    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: 10.allPadding,
          child: Obx(
            () => CircleButtonWidget(
              isEnable: _onboardController.isEnable.value,
              onTap: () {
                final current = _currentIndex.value;

                // 1️⃣ Submit API for current step
                _onboardController.submitStep(current);

                // 2️⃣ Mark step completed locally
                _onboardController.completeStep(current);

                // 3️⃣ Find next incomplete step
                final nextIndex = _onboardController.nextIncompleteIndex;

                // ✅ All steps completed → go home
                if (nextIndex == -1) {
                  _onboardController.allOfFame(
                    imageUrlList: _onboardController.fileList,
                  );
                  return;
                }

                // 4️⃣ Jump directly to next incomplete page
                _pageController.animateToPage(
                  nextIndex,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );

                _currentIndex.value = nextIndex;
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
            valueCurrentIndex: _currentIndex,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              physics: const NeverScrollableScrollPhysics(), // 🔒 lock swipe
              onPageChanged: (index) {
                _currentIndex.value = index;
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
