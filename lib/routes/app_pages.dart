import 'package:get/route_manager.dart';
import 'package:matchster/features/modules/auth/binding/auth_binding.dart';
import 'package:matchster/features/modules/auth/views/login/country_list_screen.dart';
import 'package:matchster/features/modules/auth/views/login/login_screen.dart';
import 'package:matchster/features/modules/auth/views/onboarding/onboard_screen.dart';
import 'package:matchster/features/modules/auth/views/onboarding/photo_preview_screen.dart';
import 'package:matchster/features/modules/home/binding/landing_binding.dart';
import 'package:matchster/features/modules/home/view/landing_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.onboardScreen,
      page: () => OnboardScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.landingScreen,
      page: () => const LandingScreen(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePreviewScreen,
      page: () => PhotoPreviewScreen(),
    ),
    GetPage(name: AppRoutes.countryListScreen, page: () => CountryListScreen()),
  ];
}
