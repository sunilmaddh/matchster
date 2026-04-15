import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSwipeButtonController extends GetxController {
  CommonSwipeButtonController({this.completeThreshold = 0.85});

  final double completeThreshold;

  final RxDouble dragPosition = 0.0.obs;
  final RxBool isCompleted = false.obs;

  void updateDrag({required double delta, required double maxDrag}) {
    if (isCompleted.value) return;

    dragPosition.value = (dragPosition.value + delta).clamp(0.0, maxDrag);
  }

  void handleDragEnd({
    required double maxDrag,
    required VoidCallback onSwipeComplete,
  }) {
    if (isCompleted.value) return;

    if (dragPosition.value >= maxDrag * completeThreshold) {
      dragPosition.value = maxDrag;
      isCompleted.value = true;
      onSwipeComplete();
    } else {
      reset();
    }
  }

  void reset() {
    dragPosition.value = 0.0;
    isCompleted.value = false;
  }

  void complete({
    required double maxDrag,
    required VoidCallback onSwipeComplete,
  }) {
    if (isCompleted.value) return;

    dragPosition.value = maxDrag;
    isCompleted.value = true;
    onSwipeComplete();
  }
}
