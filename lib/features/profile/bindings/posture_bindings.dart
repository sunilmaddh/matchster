import 'package:get/get.dart';
import 'package:matchster/features/posture/controller/posture_controller.dart';

class PostureBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostureController>(() => PostureController());
  }
}
