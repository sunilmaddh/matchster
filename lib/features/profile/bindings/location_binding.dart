import 'package:get/get.dart';
import 'package:matchster/features/profile/controller/profile_location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileLocationController>(
      () =>
          ProfileLocationController(Get.find(), locationRepository: Get.find()),
    );
  }
}
