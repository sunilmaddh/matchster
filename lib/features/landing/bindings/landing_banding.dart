import 'package:get/get.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';
import 'package:matchster/features/home/services/home_services.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_location_controller.dart';
import 'package:matchster/features/profile/repositories/profile_repository.dart';
import 'package:matchster/features/profile/services/profile_services.dart';

class LandingBanding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileLocationController>(
      () =>
          ProfileLocationController(Get.find(), locationRepository: Get.find()),
    );

    Get.lazyPut<ProfileService>(
      () => ProfileService(baseService: Get.find()),
      fenix: true,
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(profileService: Get.find()),
      fenix: true,
    );
    Get.lazyPut<HomeService>(() => HomeService(baseServices: Get.find()));
    Get.lazyPut<HomeRepository>(() => HomeRepository(homeService: Get.find()));

    Get.lazyPut(() => HomeController(homeRepository: Get.find()), fenix: true);
    Get.lazyPut(
      () => ProfileController(profileRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => FilterController());
  }
}
