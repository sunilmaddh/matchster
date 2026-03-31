import 'package:get/get.dart';
import 'package:matchster/features/profile/controller/email_controller.dart';
import 'package:matchster/features/profile/controller/setting_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailController>(
      () => EmailController(
        profileService: Get.find(),
        profileController: Get.find(),
      ),
    );
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
