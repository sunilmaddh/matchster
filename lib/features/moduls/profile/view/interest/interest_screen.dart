import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/common_lists.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/moduls/profile/controller/profile_controller.dart';
import 'package:matchster/features/moduls/profile/widgets/common_widget.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({super.key});

  final _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return CommonWidget(
      image: AppAssets.interest2,
      title: "What’s your interests?",
      subtitle: "Build your connection more",
      list: CommonLists.interestText,
      onTop: (v) {
        if (_profileController.selectedInterests.contains(v)) {
          _profileController.selectedInterests.remove(v);
        } else {
          _profileController.selectedInterests.add(v);
        }
      },
      isSelected: (v) => _profileController.selectedInterests.contains(v),
      onTopButton: () async {
        final interestList = await AppMethods.toApiValues(
          _profileController.selectedInterests,
        );
        _profileController.addInterests(interests: interestList);
      },
      appBarTitle: 'Interests',
    );
  }
}
