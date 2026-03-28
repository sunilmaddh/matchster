import 'package:flutter/material.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/extentions/snack_case.ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_details_list_controller.dart';
import 'package:matchster/features/profile/models/my_profile_response.dart';
import 'package:matchster/features/profile/widgets/interest_card.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileDetailsListScreen extends BaseView<ProfileDetailsListController> {
  const ProfileDetailsListScreen({
    super.key,
    required this.personal,
    required this.preference,
    required this.professional,
    required this.basicInfo,
  });

  final Personal personal;
  final Preferences preference;
  final Professional professional;
  final BasicInfo basicInfo;

  @override
  bool get useDefaultLoader => false;

  @override
  State<ProfileDetailsListScreen> createState() =>
      _ProfileDetailsListScreenState();
}

class _ProfileDetailsListScreenState
    extends
        BaseViewState<ProfileDetailsListController, ProfileDetailsListScreen> {
  @override
  void onInit() {
    super.onInit();
    controller.setData(
      personalData: widget.personal,
      preferenceData: widget.preference,
      professionalData: widget.professional,
      basicInfoData: widget.basicInfo,
    );
  }

  @override
  Widget buildView(BuildContext context) {
    final personal = controller.personal;
    final preference = controller.preference;
    final professional = controller.professional;
    final basicInfo = controller.basicInfo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.titleMedium(AppStrings.profileDetails),
        5.hBox,
        _buildProfileCard(
          context: context,
          title: AppStrings.zodiacSign,
          subTitle: _formattedText(personal.zodiacSign),
          image: AppAssets.zodizcAssets,
          color: AppColors.zodiacCardColor,
          onTap: () {
            controller.onTapZodiac();
            controller.navigateTo(AppRoutes.zodiacScreen);
          },
        ),
        _buildProfileCard(
          context: context,
          title: AppStrings.religion,
          subTitle: _formattedSnakeText(personal.religion),
          image: AppAssets.religionAssest,
          color: AppColors.religionCardColor,
          onTap: () {
            controller.onTapReligion();
            controller.navigateTo(AppRoutes.religionScreen);
          },
        ),
        _buildProfileCard(
          context: context,
          title: AppStrings.profileVisibility,
          subTitle: _formattedSnakeText(preference.visibility),
          image: AppAssets.profileEditAssets,
          color: AppColors.visibilityCardColor,
          onTap: () {
            controller.onTapVisibility();
            controller.navigateTo(AppRoutes.visibilityScreen);
          },
        ),
        _buildProfileCard(
          context: context,
          title: AppStrings.lookingFor,
          subTitle: _formattedLookingFor(preference.lookingFor?.first),
          image: AppAssets.lookingAssets,
          color: AppColors.lookingForCardColor,
          onTap: () {
            controller.onTapLookingFor();
            controller.navigateTo(AppRoutes.lookingScreen);
          },
        ),
        _buildProfileCard(
          context: context,
          title: AppStrings.height,
          subTitle: _formattedText(basicInfo.height),
          image: AppAssets.heightAssets,
          color: AppColors.heightCardColor,
          onTap: () {
            controller.onTapHeight();
            controller.navigateTo(AppRoutes.height);
          },
        ),
        _buildProfileCard(
          context: context,
          title: AppStrings.education,
          subTitle: _formattedSnakeText(personal.qualification),
          image: AppAssets.educationAssets,
          color: AppColors.educationCardColor,
          onTap: () {
            controller.onTapEducation();
            controller.navigateTo(AppRoutes.education);
          },
        ),
        _buildProfileCard(
          context: context,
          title: AppStrings.work,
          subTitle: _formattedWork(
            professional.work?.jobTitle,
            professional.work?.company,
          ),
          image: AppAssets.workAssets,
          color: AppColors.workCardColor,
          onTap: () {
            controller.onTapWork();
            controller.navigateTo(AppRoutes.work);
          },
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String image,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: InkWell(
        onTap: onTap,
        child: InterestCard(
          color: color,
          title: title,
          subTitle: subTitle,
          image: image,
        ),
      ),
    );
  }

  String _formattedText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.notAdded;
    }
    return AppMethods.capitalizeFirst(value);
  }

  String _formattedSnakeText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.notAdded;
    }
    return value.removeSnakeAndCapitalize();
  }

  String _formattedLookingFor(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.notAdded;
    }
    return value;
  }

  String _formattedWork(String? jobTitle, String? company) {
    final safeJobTitle =
        (jobTitle == null || jobTitle.trim().isEmpty)
            ? AppStrings.notAdded
            : AppMethods.capitalizeFirst(jobTitle);

    final safeCompany =
        (company == null || company.trim().isEmpty)
            ? AppStrings.notAdded
            : AppMethods.capitalizeFirst(company);

    return "$safeJobTitle, $safeCompany";
  }
}
