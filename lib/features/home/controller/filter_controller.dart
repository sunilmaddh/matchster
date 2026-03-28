import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';

class FilterController extends BaseController {
  RxString isFilterType = "Basic Filter".obs;
  RxBool isSwitchOn = false.obs;

  RxBool isKm = false.obs;

  void toggleSwitch(bool value) => isSwitchOn.value = value;
}
