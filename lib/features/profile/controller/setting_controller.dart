import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/routes/app_routes.dart';

class SettingController extends BaseController {
  RxBool isSwitchOn = true.obs;
  RxBool isLoggingOut = false.obs;
  Future<void> logout() async {
    MatchsterLocalStorage.instance.logout();

    navigateOffAll(AppRoutes.loginScreen);
  }
}
