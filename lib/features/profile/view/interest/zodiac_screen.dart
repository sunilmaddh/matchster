import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class ZodiacScreen extends StatelessWidget {
  ZodiacScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.zodiac2,
      title: AppStrings.zodiacTitle,
      subtitle: AppStrings.zodiacSubtitle,
      list: CommonLists.zodiocss,
      onTop: (v) {
        _profileController.selectedZodiac.value = v;
      },
      isSelected:
          (v) =>
              _profileController.selectedZodiac.value.toLowerCase().trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        if (_profileController.selectedZodiac.value.isNotEmpty) {
          _profileController.addZodiacsign(
            zodiacsign:
                _profileController.selectedZodiac.value
                    .toLowerCase(), // ✅ FIXED
          );
        }
      },
      appBarTitle: AppStrings.zodiacAppBarTitle,
    );
  }
}
