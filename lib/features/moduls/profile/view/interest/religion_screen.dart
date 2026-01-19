import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class ReligionScreen extends StatelessWidget {
  ReligionScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.religion2,
      title: "What’s your religion?",
      subtitle: "Build your connection more",
      list: CommonLists.religions,
      onTop: (v) {
        _profileController.selectedReligion.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected: (v) => _profileController.selectedReligion.contains(v),
      onTopButton: () {
        _profileController.addReligion(
          religion: _profileController.selectedReligion.value.toLowerCase(),
        );
      },
    );
  }
}
