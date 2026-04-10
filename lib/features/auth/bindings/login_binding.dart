import 'package:get/get.dart';
import 'package:matchster/features/auth/auth_controller/country_controller.dart';
import 'package:matchster/features/auth/auth_controller/login_controller.dart';
import 'package:matchster/features/auth/repositories/auth_repository.dart';
import 'package:matchster/features/auth/services/login_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginService>(() => LoginService(baseService: Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepository(loginService: Get.find()));
    Get.lazyPut(() => LoginController(authRepository: Get.find()), fenix: true);
    Get.lazyPut(() => CountryController(), fenix: true);
  }
}
