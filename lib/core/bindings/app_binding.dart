import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart'
    show MatchsterLocalStorage;
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

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MatchsterLocalStorage>(
      MatchsterLocalStorage.instance,
      permanent: true,
    );

    Get.put<BaseService>(
      BaseService(storage: Get.find<MatchsterLocalStorage>()),
      permanent: true,
    );

    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthService());
    Get.lazyPut<LoginService>(
      () => LoginService(baseService: Get.find<BaseService>()),
    );
    Get.lazyPut<OnboardingService>(
      () => OnboardingService(baseService: Get.find<BaseService>()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(loginService: Get.find<LoginService>()),
    );

    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepository(
        onboardingService: Get.find<OnboardingService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<FaceDetectionService>(
      () => FaceDetectionService(),
      fenix: true,
    );
    Get.lazyPut<ImageUploadServices>(() => ImageUploadServices(), fenix: true);
    Get.lazyPut<LocationService>(() => LocationService(), fenix: true);

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
      fenix: true,
    );
    Get.lazyPut<SplashVideoService>(() => SplashVideoService());
    // Get.put(OnboardController(), permanent: true);
    // Get.lazyPut<LoginController>(() => LoginController());
    // Get.put(HomeController(), permanent: true);
    // Get.put(ProfileController(), permanent: true);
    // Get.put(CountryController());
    // Get.put(FilterController());
  }
}
