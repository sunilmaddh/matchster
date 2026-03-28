import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/controller/profile_form_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_routes.dart';

class PreferenceListWidget extends StatelessWidget {
  PreferenceListWidget({
    super.key,
    required this.lifestyle,
    required this.personal,
  });

  final Lifestyle lifestyle;
  final Personal personal;

  final ProfileController _profileController = Get.find<ProfileController>();
  final ProfileFormController _controller = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText.titleMedium(AppStrings.preferences),
        5.hBox,
        _buildCard(
          onTap: () {
            _controller.selectedWorkout.value = lifestyle.workout ?? '';
            _profileController.navigateTo(AppRoutes.workout);
          },
          child: InterestCard(
            title: AppStrings.workout,
            subTitle: _formatSingleValue(lifestyle.workout),
            image: AppAssets.gymAssets2,
          ),
        ),
        _buildCard(
          onTap: () {
            _controller.selectedSmoke.value = lifestyle.smoking ?? '';
            _profileController.navigateTo(AppRoutes.smoke);
          },
          child: InterestCard(
            color: AppColors.smokingCardColor,
            title: AppStrings.smoking,
            subTitle: _formatSingleValue(lifestyle.smoking),
            image: AppAssets.smokingAssets,
          ),
        ),
        _buildCard(
          onTap: () {
            _controller.selectedDrinking.value = lifestyle.drinking ?? '';
            _profileController.navigateTo(AppRoutes.alcohol);
          },
          child: InterestCard(
            color: AppColors.drinkingCardColor,
            title: AppStrings.drinking,
            subTitle: _formatSingleValue(lifestyle.drinking),
            image: AppAssets.drinkAsssets,
          ),
        ),
        _buildCard(
          onTap: () {
            if (personal.interests != null && personal.interests!.isNotEmpty) {
              // _profileController.(personal.interests!);
            } else {
              _controller.selectedInterests.clear();
            }
            _profileController.navigateTo(AppRoutes.interest);
          },
          child: InterestCard(
            color: AppColors.interestCardColor,
            title: AppStrings.interest,
            subTitle: _formatListValue(personal.interests),
            image: AppAssets.interestAssets,
          ),
        ),
        _buildCard(
          onTap: () async {
            if (personal.languages != null && personal.languages!.isNotEmpty) {
              // await _profileController.setLanguageFromApi(personal.languages);
            } else {
              _controller.selectedLanguages.clear();
            }
            _profileController.navigateTo(AppRoutes.landingScreen);
          },
          child: InterestCard(
            color: AppColors.languagesCardColor,
            title: AppStrings.languages,
            subTitle: _formatListValue(personal.languages),
            image: AppAssets.gymAssets2,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required VoidCallback onTap, required Widget child}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: InkWell(onTap: onTap, child: child),
    );
  }

  String _formatSingleValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.notAdded;
    }
    return AppMethods.capitalizeFirst(value);
  }

  String _formatListValue(dynamic value) {
    if (value == null) {
      return AppStrings.notAdded;
    }

    final text = value.toString().trim();
    if (text.isEmpty) {
      return AppStrings.notAdded;
    }

    return text;
  }
}
