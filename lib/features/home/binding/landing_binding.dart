import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/controller/location_controller.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';
import 'package:matchster/features/home/services/home_service.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/profile_details_list_controller.dart';
import 'package:matchster/features/profile/repositories/profile_repository.dart';
import 'package:matchster/features/profile/services/profile_services.dart';
import 'package:matchster/features/profile/widgets/profile_details_list_screen.dart';

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
    Get.lazyPut<ProfileFormController>(() => ProfileFormController());
    Get.lazyPut<ProfileDetailsListController>(
      () => ProfileDetailsListController(
        profileController: Get.find<ProfileController>(),
        controller: Get.find<ProfileFormController>(),
      ),
    );
    Get.lazyPut<LocationController>(
      () => LocationController(
        profileController: Get.find(),
        onboardController: Get.find(),
      ),
    );
  }
}
