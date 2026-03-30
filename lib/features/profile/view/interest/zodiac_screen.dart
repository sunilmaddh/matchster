import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class ZodiacScreen extends StatelessWidget {
  ZodiacScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.zodiac2,
      title: "What’s your zodiac sign?",
      subtitle: "Build your connection more",
      list: CommonLists.zodiocss,
      onTop: (v) {
        _profileFormController.selectedZodiac.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected:
          (v) =>
              _profileFormController.selectedZodiac.value
                  .toLowerCase()
                  .trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addZodiacSign(
          _profileFormController.selectedZodiac.toLowerCase(),
        );
      },
      appBarTitle: 'Zodiac sign',
    );
  }
}
