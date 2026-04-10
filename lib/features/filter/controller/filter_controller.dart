import 'package:get/get.dart';

class FilterController extends GetxController {
  RxString isFilterType = "Basic Filter".obs;
  RxBool isSwitchOn = false.obs;

  RxBool isKm = false.obs;

  void toggleSwitch(bool value) => isSwitchOn.value = value;
}
