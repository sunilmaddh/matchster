import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class LookingScreen extends StatelessWidget {
  LookingScreen({super.key});

  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.looking,
      title: "Looking for",
      subtitle: "Build your connection more",
      list: CommonLists.releationships,

      /// Single selection
      onTop: (v) {
        _profileController.selectedLookingFor.clear();
        _profileController.selectedLookingFor.add(v);
      },

      /// Selected check
      isSelected: (v) => _profileController.selectedLookingFor.contains(v),

      /// Submit
      onTopButton: () {
        if (_profileController.selectedLookingFor.isEmpty) return;

        _profileController.addLookingFor(
          lookingFor: [
            _profileController.selectedLookingFor.first.toLowerCase(),
          ],
        );
      },

      appBarTitle: 'Looking for',
    );
  }
}
