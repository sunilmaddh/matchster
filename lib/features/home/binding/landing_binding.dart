import 'package:get/get.dart';
import 'package:matchster/core/network/api_service.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';
import 'package:matchster/features/home/services/home_service.dart';
import 'package:matchster/features/profile/controller/email_controller.dart';
import 'package:matchster/features/profile/controller/location_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_details_list_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/controller/setting_controller.dart';
import 'package:matchster/features/profile/repositories/profile_repository.dart';
import 'package:matchster/features/profile/services/profile_services.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeService>(
      () => HomeService(baseServices: Get.find<ApiService>()),
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(homeService: Get.find<HomeService>()),
    );
    Get.lazyPut<ProfileService>(
      () => ProfileService(baseService: Get.find<ApiService>()),
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
    Get.lazyPut<EmailController>(
      () => EmailController(
        profileService: Get.find(),
        profileController: Get.find(),
      ),
    );
    Get.lazyPut<LocationController>(
      () => LocationController(
        profileController: Get.find(),
        onboardController: Get.find(),
      ),
    );
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
