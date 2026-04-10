import 'package:get/get.dart';
import 'package:matchster/features/profile/controller/profile_email_controller.dart';

class EmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEmailController>(
      () => ProfileEmailController(Get.find(), profileRepository: Get.find()),
    );
  }
}
