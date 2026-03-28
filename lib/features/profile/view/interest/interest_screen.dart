import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/widgets/common_widget.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  final _profileFormController = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.interest2,
      title: "What’s your interests?",
      subtitle: "Build your connection more",
      list: CommonLists.interestText,
      onTop: (v) {
        if (_profileFormController.selectedInterests.contains(v)) {
          _profileFormController.selectedInterests.remove(v);
        } else {
          _profileFormController.selectedInterests.add(v);
        }
      },
      isSelected: (v) => _profileFormController.selectedInterests.contains(v),
      onTopButton: () async {
        final interestList = await AppMethods.toApiValues(
          _profileFormController.selectedInterests,
        );
        _profileController.addInterests(interestList);
      },
      appBarTitle: 'Interests',
    );
  }
}
