import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/features/auth/auth_controller/country_controller.dart';
import 'package:matchster/features/auth/auth_controller/login_controller.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/auth_controller/onboard_location_controller.dart';
import 'package:matchster/features/auth/auth_controller/onboard_photo_controller.dart';
import 'package:matchster/features/auth/repositories/auth_repository.dart';
import 'package:matchster/features/auth/repositories/onboard_repository.dart';
import 'package:matchster/features/auth/services/login_service.dart';
import 'package:matchster/features/auth/services/onboard_service.dart';
import 'package:matchster/features/home/controller/filter_controller.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseService>(() => BaseService());
    Get.lazyPut<LoginService>(() => LoginService(baseService: Get.find()));
    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepository(onboardingService: Get.find()),
    );
    Get.lazyPut<OnboardingService>(
      () => OnboardingService(baseService: Get.find()),
    );
    Get.lazyPut<AuthRepository>(() => AuthRepository(loginService: Get.find()));
    Get.lazyPut(
      () => OnboardController(onboardingRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<FaceDetectionService>(() => FaceDetectionService());
    Get.lazyPut<OnboardPhotoController>(
      () => OnboardPhotoController(
        onboardingRepository: Get.find(),
        faceService: Get.find(),
      ),
    );
    Get.lazyPut<OnboardLocationController>(
      () => OnboardLocationController(onboardingRepository: Get.find()),
    );
    Get.lazyPut(() => LoginController(authRepository: Get.find()), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CountryController(), fenix: true);
    Get.lazyPut(() => FilterController());
  }
}
