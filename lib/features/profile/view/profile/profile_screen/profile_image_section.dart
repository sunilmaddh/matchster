import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/features/profile/controller/profile_image_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/add_image_grid_widget.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final imageController = Get.find<ProfileImageController>();

    return AddImageGrid(
      imageList: profileController.hallOfFames,
      onTop: (_) => imageController.showImagePickerSheet(),
      onTopRemove: (id) => imageController.showRemoveImageSheet(id),
      onSwap: (position1, position2) {
        imageController.swapProfileImages(
          position1: position1,
          position2: position2,
        );
      },
    );
  }
}
