import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class ReligionScreen extends StatelessWidget {
  ReligionScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.religion2,
      title: "What’s your religion?",
      subtitle: "Build your connection more",
      list: CommonLists.religions,
      onTop: (v) {
        _profileFormController.selectedReligion.value = v;
        // if (_profileController.selectedItems.contains(v)) {
        //   _profileController.selectedItems.remove(v);
        // } else {
        //   _profileController.selectedItems.add(v);
        // }
      },
      isSelected:
          (v) =>
              _profileFormController.selectedReligion.value
                  .toLowerCase()
                  .trim() ==
              v.toLowerCase().trim(),
      onTopButton: () {
        _profileController.addReligion(
          normalizeValue(
            _profileFormController.selectedReligion.value.toLowerCase(),
          ),
        );
      },
      appBarTitle: 'Religion',
    );
  }

  String normalizeValue(String value) {
    return removeDiacritics(value)
        .toLowerCase()
        .replaceAll(RegExp(r"[’'ʼ]"), '')
        .replaceAll(RegExp(r'[^a-z\s]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
  }
}
