import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class LanguagesScreen extends StatelessWidget {
  LanguagesScreen({super.key});

  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.languageAssets,
      title: "What languages do you know?",
      subtitle: "Build your connection more",
      list: CommonLists.languageList,
      onTop: (v) {
        if (_profileController.selectedLanguage.contains(v)) {
          _profileController.selectedLanguage.remove(v);
        } else {
          _profileController.selectedLanguage.add(v);
        }
      },
      isSelected: (v) => _profileController.selectedLanguage.contains(v),
      onTopButton: () async {
        if (_profileController.selectedLanguage.isNotEmpty) {
          final languages = await AppMethods.toApiValues(
            _profileController.selectedLanguage,
          );
          _profileController.addLanguages(languages: languages);
        }
      },
      appBarTitle: 'Languages',
    );
  }
}
