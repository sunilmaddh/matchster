import 'package:get/get.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart'
    show MatchsterLocalStorage;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MatchsterLocalStorage>(
      MatchsterLocalStorage.instance,
      permanent: true,
    );

    Get.put<BaseService>(
      BaseService(storage: Get.find<MatchsterLocalStorage>()),
      permanent: true,
    );
    // Get.put(OnboardController(), permanent: true);
    // Get.lazyPut<LoginController>(() => LoginController());
    // Get.put(HomeController(), permanent: true);
    // Get.put(ProfileController(), permanent: true);
    // Get.put(CountryController());
    // Get.put(FilterController());
  }
}
