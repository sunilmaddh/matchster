import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/features/modules/home/controller/home_controller.dart';
import 'package:matchster/features/modules/home/repositories/home_repository.dart';
import 'package:matchster/features/modules/home/services/home_service.dart';
import 'package:matchster/features/modules/profile/controller/profile_controller.dart';
import 'package:matchster/features/modules/profile/repositories/profile_repository.dart';
import 'package:matchster/features/modules/profile/services/profile_services.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeService>(
      () => HomeService(baseServices: Get.find<BaseService>()),
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(homeService: Get.find<HomeService>()),
    );
    Get.lazyPut<ProfileService>(
      () => ProfileService(baseService: Get.find<BaseService>()),
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(profileService: Get.find<ProfileService>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(homeRepository: Get.find<HomeRepository>()),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(profileRepository: Get.find<ProfileRepository>()),
    );
  }
}
