import 'package:get/get.dart';
import 'package:matchster/core/network/api_service.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/services/image_upload_services.dart';

import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/auth/repositories/Onboarding_repository.dart';
import 'package:matchster/features/auth/services/face_detection_service.dart';

import 'package:matchster/features/auth/services/location_service.dart';
import 'package:matchster/features/auth/services/onboarding_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    /// ---------------- CORE ----------------
    Get.put<MatchsterLocalStorage>(
      MatchsterLocalStorage.instance,
      permanent: true,
    );

    Get.put<ApiService>(
      ApiService(storage: Get.find<MatchsterLocalStorage>()),
      permanent: true,
    );

    /// ---------------- SERVICES ----------------

    Get.lazyPut<OnboardingService>(
      () => OnboardingService(baseService: Get.find<ApiService>()),
      fenix: true,
    );

    Get.lazyPut<FaceDetectionService>(
      () => FaceDetectionService(),
      fenix: true,
    );

    Get.lazyPut<ImageUploadServices>(() => ImageUploadServices(), fenix: true);

    Get.lazyPut<LocationService>(() => LocationService(), fenix: true);

    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepository(
        onboardingService: Get.find<OnboardingService>(),
      ),
      fenix: true,
    );

    Get.put<OnboardController>(
      OnboardController(
        onboardingRepository: Get.find<OnboardingRepository>(),
        faceDetectionService: Get.find<FaceDetectionService>(),
        imageService: Get.find<ImageUploadServices>(),
        locationService: Get.find<LocationService>(),
      ),
      permanent: true,
    );
  }
}
