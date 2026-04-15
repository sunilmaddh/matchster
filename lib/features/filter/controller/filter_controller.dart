import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';

class FilterController extends BaseController {
  final RxString isFilterType = "Basic Filter".obs;
  final RxString selectedWorkout = ''.obs;
  final RxString selectedAcademic = ''.obs;
  final RxList<String> selectedGender = <String>[].obs;
  final RxString selectedSmoke = ''.obs;
  final RxString selectedDrink = ''.obs;
  final RxString selectedLookingFor = ''.obs;
  final RxBool isSwitchOn = false.obs;
  final RxList<String> languageList = <String>[].obs;
  final RxnString selectedReligion = RxnString();
  final RxnString selectedOccupation = RxnString();
  RxBool isKm = false.obs;
  void toggleSwitch(bool value) => isSwitchOn.value = value;
}
