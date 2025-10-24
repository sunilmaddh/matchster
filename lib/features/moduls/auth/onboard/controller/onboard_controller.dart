import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  RxBool isEnable = false.obs;
  var selectedIndex = RxnInt();
  var selectedImageIndex = RxnInt();
  RxBool isSwitchOn = true.obs;
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final heightController = TextEditingController();
  Rx<File?> file = File("").obs;
  RxBool isNotFeet = false.obs;
  void toggleSwitch(bool value) {
    isSwitchOn.value = value;
  }

  RxBool isDateSelected = false.obs;
  RxInt selectedIndexDate = 0.obs;

  void toggleSelection(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null;
    } else {
      selectedIndex.value = index;
    }
  }

  RxList<Rx<File?>> fileList = List.generate(4, (_) => Rx<File?>(null)).obs;
  void updateFile(int index, File file) {
    if (index < fileList.length) {
      fileList[index].value = file;
      fileList.refresh(); // important to trigger Obx
    }
  }

  void removeFile(int index) {
    fileList[index].value = null; // ✅ remove file
  }
}
