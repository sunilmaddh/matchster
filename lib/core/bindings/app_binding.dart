import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/features/moduls/auth/login/controller/country_controller.dart';
import 'package:matchster/features/moduls/auth/login/controller/login_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/home/controller/filter_controller.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';
import 'package:matchster/features/moduls/posture/controller/posture_controller.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnboardController(), permanent: true);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put(HomeController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(CountryController());
    Get.put(FilterController());
    Get.put(PostureController());
    Get.put<BaseService>(BaseService(), permanent: true);
  }
}
