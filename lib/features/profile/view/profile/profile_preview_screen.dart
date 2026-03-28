import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_stateless_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/fields/common_card.dart';
import 'package:matchster/features/common/widgets/fields/common_home_card.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/sub_common_card.dart';
import 'package:matchster/features/profile/widgets/verified_card.dart';

class ProfilePreviewScreen extends BaseStatelessView<ProfileController> {
  const ProfilePreviewScreen({super.key});

  @override
  Widget buildView(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.profilePreview,
        onTop: Get.back,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: 15.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileHeaderSection(controller: controller),
              SizedBox(height: 20.h),
              _NameSection(controller: controller),
              10.hBox,
              _InShortSection(controller: controller),
              15.hBox,
              _LookingForSection(controller: controller),
              15.hBox,
              _LocationSection(controller: controller),
              15.hBox,
              _InterestSection(controller: controller),
              15.hBox,
              _ProfessionSection(controller: controller),
              15.hBox,
              _MorePictureSection(controller: controller),
              15.hBox,
              _LanguageSection(controller: controller),
              _GallerySection(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderSection extends StatelessWidget {
  const _ProfileHeaderSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final imageUrl = controller.basicInfo?.profilePic?.url ?? '';

    return Container(
      padding: EdgeInsets.only(top: 10.h),
      height: 518.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            child: CommonAssets.networkImage(
              imageUrl,
              height: 518.h,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: InkWell(
                onTap: () {},
                child: VerifiedCard(
                  color: const Color(0xff1D48EF),
                  title: AppStrings.getVerified,
                  subTitle: AppStrings.showOthersYouAreReal,
                  image: AppAssets.verified2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
  const _NameSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final name = controller.basicInfo?.name ?? '';
    final age = controller.basicInfo?.age?.toString() ?? '';

    return Padding(
      padding: 20.horizontalPadding,
      child: CommonText.titleMedium(
        _buildNameAge(name, age),

        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _buildNameAge(String name, String age) {
    if (name.isEmpty && age.isEmpty) return '';
    if (name.isNotEmpty && age.isNotEmpty) return '$name, $age';
    return name.isNotEmpty ? name : age;
  }
}

class _InShortSection extends StatelessWidget {
  const _InShortSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final about = controller.bio?.about ?? '';

    return CommonHomeCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(AppStrings.inShort, color: AppColors.whiteColor),
          if (about.trim().isNotEmpty) ...[
            CommonText.displaySmall(
              '“$about.”',

              maxLines: 7,
              fontStyle: FontStyle.italic,
              color: AppColors.whiteColor,
            ),
            20.hBox,
          ],
          InshortWrapWidget(list: controller.inshortList),
        ],
      ),
    );
  }
}

class _LookingForSection extends StatelessWidget {
  const _LookingForSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final lookingForList = controller.preferences?.lookingFor ?? [];

    return CommonHomeCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.lookingFor,
            color: AppColors.whiteColor,

            fontWeight: FontWeight.w700,
          ),
          10.hBox,
          LookingWrapWidget(list: lookingForList),
        ],
      ),
    );
  }
}

class _LocationSection extends StatelessWidget {
  const _LocationSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final city = controller.locations?.currentLocation?.address?.city ?? '';

    return CommonHomeCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.location,
            color: AppColors.whiteColor,

            fontWeight: FontWeight.w700,
          ),
          10.hBox,
          CommonCard(
            widget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: 7.allPadding,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF4F4F4),
                  ),
                  child: CommonText.text(AppStrings.locationIcon),
                ),
                5.wBox,
                CommonText.labelLarge(
                  city.isNotEmpty ? '${AppStrings.away}, $city' : '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestSection extends StatelessWidget {
  const _InterestSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final interests = controller.personal?.interests ?? <String>[];

    return CommonCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.myInterest,

            fontWeight: FontWeight.w700,
          ),
          CommonText.labelMedium(
            AppStrings.expressYourInterests,

            fontWeight: FontWeight.w300,
          ),
          10.hBox,
          InterestWrapWidget(list: interests),
        ],
      ),
    );
  }
}

class _ProfessionSection extends StatelessWidget {
  const _ProfessionSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final jobTitle = controller.professional?.work?.jobTitle ?? '';

    return CommonCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.profession,

            fontWeight: FontWeight.w700,
          ),
          5.hBox,
          SubCommonCard(
            widget: CommonText.text(AppMethods.capitalizeFirst(jobTitle)),
          ),
        ],
      ),
    );
  }
}

class _MorePictureSection extends StatelessWidget {
  const _MorePictureSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final hallOfFames = controller.hallOfFames;

    return CommonCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.morePicture,

            fontWeight: FontWeight.w700,
          ),
          10.hBox,
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child:
                hallOfFames.isNotEmpty
                    ? CommonAssets.networkImage(hallOfFames.first.url ?? '')
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final languages = controller.personal?.languages ?? <String>[];

    if (languages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CommonCard(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.titleMedium(
                AppStrings.language,
                color: AppColors.blackColor,

                fontWeight: FontWeight.w700,
              ),
              10.hBox,
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    languages
                        .map((language) => _LanguageChip(title: language))
                        .toList(),
              ),
            ],
          ),
        ),
        15.hBox,
      ],
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final hallOfFames = controller.hallOfFames;

    if (hallOfFames.length <= 1) {
      return const SizedBox.shrink();
    }

    return Column(
      children: List.generate(
        hallOfFames.length - 1,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: CommonCard(
            widget: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CommonAssets.networkImage(
                hallOfFames[index + 1].url ?? '',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 10.horizontalPadding + 4.verticalPadding,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9).withAlpha(33),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xff363636).withAlpha(33),
          width: 1.w,
        ),
      ),
      child: CommonText.bodyMedium(
        title,
        color: AppColors.blackColor,

        fontWeight: FontWeight.w300,
      ),
    );
  }
}
