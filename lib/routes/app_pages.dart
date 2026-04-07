import 'package:get/route_manager.dart';
import 'package:matchster/features/auth/view/login/login_screen.dart';
import 'package:matchster/features/auth/view/onboard/current_loading_screen.dart';
import 'package:matchster/features/auth/view/onboard/onboard_screen.dart';
import 'package:matchster/features/home/view/landing_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.onboardScreen, page: () => OnboardScreen()),
    GetPage(name: AppRoutes.landingScreen, page: () => LandingScreen()),

    GetPage(
      name: AppRoutes.currentLoadingScreen,
      page: () => CurrentLoadingScreen(),
    ),
  ];
}
