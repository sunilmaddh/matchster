import 'package:get/get.dart';
import 'package:matchster/features/filter/controller/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(() => FilterController());
  }
}
