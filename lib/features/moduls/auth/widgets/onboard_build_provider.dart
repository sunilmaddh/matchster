import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/widgets/matchster_progress_indicator.dart';
import 'package:matchster/features/moduls/home/view/landing_screen.dart';

// ignore: must_be_immutable
class OnboardPageViewBuilder extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final List<Widget> pages;

  OnboardPageViewBuilder({super.key, required this.pages});

  final _onboardController = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, currentIndex, child) {
            return Padding(
              padding: 10.allPadding,
              child: Obx(
                () => CircleButtonWidget(
                  isEnable: _onboardController.isEnable.value,
                  onTap: () {
                    if (currentIndex == pages.length - 1) {
                      // var data = AppMethods.getstoreQuestionAnswer();
                      Get.to(LandingScreen());
                      // AppNavigation.to(AppRoutes.congratulationsScreen);
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
              ),
            );
          },
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
              onPageChanged: (index) {
                _currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
