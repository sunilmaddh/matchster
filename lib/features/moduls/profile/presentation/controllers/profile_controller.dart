import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isSelected = false.obs;
  RxList<String> selectedItems = <String>[].obs;
  RxInt selectedIndex = 1.obs;
}
