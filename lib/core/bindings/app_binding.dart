import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/services/face_detection_service.dart';
import 'package:matchster/features/auth/auth_controller/onboard_controller.dart';
import 'package:matchster/features/auth/auth_controller/onboard_location_controller.dart';
import 'package:matchster/features/auth/auth_controller/onboard_photo_controller.dart';
import 'package:matchster/features/auth/repositories/onboard_repository.dart';
import 'package:matchster/features/auth/services/onboard_service.dart';
import 'package:matchster/features/profile/repositories/location_repository.dart';
import 'package:matchster/features/profile/services/location_services.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseService>(() => BaseService(), fenix: true);
    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepository(onboardingService: Get.find()),
    );

    Get.lazyPut<LocationService>(
      () => LocationService(baseService: Get.find()),
      fenix: true,
    );
    Get.lazyPut<LocationRepository>(
      () => LocationRepository(locationService: Get.find()),
      fenix: true,
    );
    Get.lazyPut<OnboardingService>(
      () => OnboardingService(baseService: Get.find()),
    );

    Get.lazyPut(
      () => OnboardController(onboardingRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<FaceDetectionService>(
      () => FaceDetectionService(),
      fenix: true,
    );
    Get.lazyPut<OnboardPhotoController>(
      () => OnboardPhotoController(
        onboardingRepository: Get.find(),
        faceService: Get.find(),
        controller: Get.find(),
      ),
    );
    Get.lazyPut<OnboardLocationController>(
      () => OnboardLocationController(
        onboardingRepository: Get.find(),
        locationService: Get.find(),
      ),
    );
  }
}
