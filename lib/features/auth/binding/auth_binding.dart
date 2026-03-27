import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/features/auth/auth_controllers/country_controller.dart';
import 'package:matchster/features/auth/auth_controllers/login_controller.dart';
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/repositories/Onboarding_repository.dart';
import 'package:matchster/features/auth/repositories/auth_repository.dart';
import 'package:matchster/features/auth/services/face_detection_service.dart';
import 'package:matchster/features/auth/services/firebase_auth_service.dart';
import 'package:matchster/features/auth/services/location_service.dart';
import 'package:matchster/features/auth/services/login_service.dart';
import 'package:matchster/features/auth/services/onboarding_service.dart';
import 'package:matchster/features/auth/services/splash_video_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthService());
    Get.lazyPut<LoginService>(
      () => LoginService(baseService: Get.find<BaseService>()),
    );
    Get.lazyPut<OnboardingService>(
      () => OnboardingService(baseService: Get.find<BaseService>()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(loginService: Get.find<LoginService>()),
    );

    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepository(
        onboardingService: Get.find<OnboardingService>(),
      ),
    );
    Get.lazyPut<FaceDetectionService>(() => FaceDetectionService());
    Get.lazyPut<ImageUploadServices>(() => ImageUploadServices());
    Get.lazyPut<LocationService>(() => LocationService());

    Get.lazyPut<LoginController>(
      () => LoginController(authRepositry: Get.find<AuthRepository>()),
    );
    Get.lazyPut<CountryController>(() => CountryController());

    Get.lazyPut<OnboardController>(
      () => OnboardController(
        onboardingRepository: Get.find<OnboardingRepository>(),
        faceDetectionService: Get.find<FaceDetectionService>(),
        imageService: Get.find<ImageUploadServices>(),
        locationService: Get.find<LocationService>(),
      ),
    );
    Get.lazyPut<SplashVideoService>(() => SplashVideoService());
  }
}
