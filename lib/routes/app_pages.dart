import 'package:get/route_manager.dart';
import 'package:matchster/features/moduls/auth/login/view/login_screen.dart';
import 'package:matchster/features/moduls/auth/onboard/view/onboard_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.onboardScreen, page: () => OnboardScreen()),
  ];
}
