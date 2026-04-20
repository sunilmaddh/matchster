import 'package:get/get.dart';
import 'package:matchster/features/posture/controller/posture_controller.dart';
import 'package:matchster/features/posture/repositories/i_posture_repository.dart';
import 'package:matchster/features/posture/repositories/posture_repository.dart';
import 'package:matchster/features/posture/services/camera/i_posture_camera_service.dart';
import 'package:matchster/features/posture/services/camera/posture_camera_service.dart';
import 'package:matchster/features/posture/services/face/i_posture_face_detection_service.dart';
import 'package:matchster/features/posture/services/face/posture_face_detection_service.dart';
import 'package:matchster/features/posture/services/gesture/gesture_detection_service.dart';
import 'package:matchster/features/posture/services/gesture/i_gesture_detection_service.dart';

class PostureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPostureCameraService>(() => PostureCameraService());
    Get.lazyPut<IFaceDetectionService>(() => PostureFaceDetectionService());
    Get.lazyPut<IGestureDetectionService>(() => GestureDetectionService());

    Get.lazyPut<IPostureRepository>(
      () => PostureRepository(
        cameraService: Get.find<IPostureCameraService>(),
        faceDetectionService: Get.find<IFaceDetectionService>(),
        gestureDetectionService: Get.find<IGestureDetectionService>(),
      ),
    );

    Get.lazyPut<PostureController>(
      () => PostureController(repository: Get.find<IPostureRepository>()),
    );
  }
}
