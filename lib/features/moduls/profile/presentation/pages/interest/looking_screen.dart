import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/features/moduls/profile/presentation/controllers/profile_controller.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/common_widget.dart';

class LookingScreen extends StatelessWidget {
  LookingScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.looking,
      title: "Looking for",
      subtitle: "Build your connection more",
      list: ["Everyday", "Sometimes", "Often"],
      onTop: (v) {
        if (_profileController.selectedItems.contains(v)) {
          _profileController.selectedItems.remove(v);
        } else {
          _profileController.selectedItems.add(v);
        }
      },
      isSelected: (v) => _profileController.selectedItems.contains(v),
      onTopButton: () {},
    );
  }
}
