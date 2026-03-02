import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';

enum GestureStep { detectFist, detectVictory, completed }

class PostureController extends GetxController {
  final currentStep = GestureStep.detectVictory.obs;
  final hands = <Hand>[].obs;

  final isDetecting = false.obs;
  final isCapturing = false.obs;

  final lastCapturedPath = RxnString();

  void moveToNextStep() {
    if (currentStep.value == GestureStep.detectFist) {
      currentStep.value = GestureStep.detectVictory;
    } else {
      currentStep.value = GestureStep.completed;
    }
  }

  void resetImage() {
    lastCapturedPath.value = null;
  }
}
