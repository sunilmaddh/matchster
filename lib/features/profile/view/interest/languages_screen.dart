import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class LanguagesScreen extends StatelessWidget {
  LanguagesScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.languageAssets,
      title: "What languages do you know?",
      subtitle: "Build your connection more",
      list: CommonLists.languageList,
      onTop: (v) {
        if (_profileFormController.selectedLanguages.contains(v)) {
          _profileFormController.selectedLanguages.remove(v);
        } else {
          _profileFormController.selectedLanguages.add(v);
        }
      },
      isSelected: (v) => _profileFormController.selectedLanguages.contains(v),
      onTopButton: () async {
        final languages = await AppMethods.toApiValues(
          _profileFormController.selectedLanguages,
        );
        _profileController.addLanguages(languages);
      },
      appBarTitle: 'Languages',
    );
  }
}
