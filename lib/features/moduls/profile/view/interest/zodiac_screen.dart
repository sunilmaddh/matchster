import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class ZodiacScreen extends StatelessWidget {
  ZodiacScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.zodiac2,
      title: "What’s your zodiac sign?",
      subtitle: "Build your connection more",
      list: CommonLists.zodiocss,
      onTop: (v) {
        _profileController.selectedZodiac.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected:
          (v) =>
              _profileController.selectedZodiac.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addZodiacsign(
          zodiacsign: _profileController.selectedZodiac.toLowerCase(),
        );
      },
      appBarTitle: 'Zodiac sign',
    );
  }
}
