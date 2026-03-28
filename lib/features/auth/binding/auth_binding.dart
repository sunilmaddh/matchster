import 'package:get/get.dart';
import 'package:matchster/core/network/api_service.dart';
import 'package:matchster/features/auth/auth_controllers/country_controller.dart';
import 'package:matchster/features/auth/auth_controllers/login_controller.dart';
import 'package:matchster/features/auth/repositories/auth_repository.dart';
import 'package:matchster/features/auth/services/firebase_auth_service.dart';
import 'package:matchster/features/auth/services/login_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthService());
    Get.lazyPut<LoginService>(
      () => LoginService(baseService: Get.find<ApiService>()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(loginService: Get.find<LoginService>()),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(authRepositry: Get.find<AuthRepository>()),
    );
    Get.lazyPut<CountryController>(() => CountryController());
  }
}
