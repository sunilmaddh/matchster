import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/home/models/inshort_list.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/sub_common_card.dart';
import 'package:matchster/features/profile/widgets/verified_card.dart';
import 'package:matchster/routes/app_navigation.dart';

class ProfilePreviewScreen extends StatelessWidget {
  ProfilePreviewScreen({super.key});

  final ProfileController _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final address = _controller.locations.value.currentLocation?.address;
    final profileImages = _controller.allPfFame;
    final languages = _controller.personal.value.languages ?? [];
    final interests = _controller.personal.value.interests ?? [];
    final lookingFor = _controller.prefeence.value.lookingFor ?? "";
    final about = _controller.bio.value.about ?? '';
    final name = _controller.basicInfo.value.name ?? '';
    final age = _controller.basicInfo.value.age?.toString() ?? '';
    final profession = _controller.professional.value.work?.jobTitle ?? '';
    return Scaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: AppStrings.profilePreview,
        onTop: AppNavigation.back,
        actions: [
          Padding(
            padding: 10.horizontalPadding,
            child: TextButton(
              onPressed: () {},
              child: SvgPicture.asset(AppAssets.settingAssets),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: 15.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePreviewHeaderSection(
                imageUrl:
                    profileImages.isNotEmpty
                        ? profileImages.first.url ?? ''
                        : '',
              ),
              SizedBox(height: 20.h),

              ProfileNameSection(name: name, age: age),
              10.hBox,

              InShortSection(
                about: about,
                inshortList: _controller.inshortList,
              ),
              15.hBox,

              if (lookingFor.isNotEmpty)
                LookingForSection(lookingFor: lookingFor),
              if (lookingFor.isNotEmpty) 15.hBox,

              LocationSection(address: address),
              15.hBox,

              if (interests.isNotEmpty) InterestsSection(interests: interests),
              if (interests.isNotEmpty) 15.hBox,

              if (profession.trim().isNotEmpty)
                ProfessionSection(profession: profession),
              if (profession.trim().isNotEmpty) 15.hBox,

              if (profileImages.isNotEmpty)
                MorePhotosPreviewSection(
                  firstImageUrl: profileImages.first.url ?? '',
                ),
              if (profileImages.isNotEmpty) 15.hBox,

              if (languages.isNotEmpty) LanguagesSection(languages: languages),
              if (languages.isNotEmpty) 15.hBox,

              if (profileImages.length > 1)
                AdditionalPhotosSection(
                  imageUrls:
                      profileImages
                          .skip(1)
                          .map((e) => e.url ?? '')
                          .where((e) => e.isNotEmpty)
                          .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePreviewHeaderSection extends StatelessWidget {
  const ProfilePreviewHeaderSection({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
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
            child:
                imageUrl.isNotEmpty
                    ? CommonAssets.networkImage(
                      imageUrl,
                      height: 518.h,
                      fit: BoxFit.fill,
                    )
                    : SizedBox(height: 518.h),
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
                  subTitle: AppStrings.showYouAreReal,
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

class ProfileNameSection extends StatelessWidget {
  const ProfileNameSection({super.key, required this.name, required this.age});

  final String name;
  final String age;

  @override
  Widget build(BuildContext context) {
    final title = [
      if (name.trim().isNotEmpty) name.trim(),
      if (age.trim().isNotEmpty) age.trim(),
    ].join(', ');

    return Padding(
      padding: 20.horizontalPadding,
      child: CommonText.titleMedium(title, fontWeight: FontWeight.w700),
    );
  }
}

class InShortSection extends StatelessWidget {
  const InShortSection({
    super.key,
    required this.about,
    required this.inshortList,
  });

  final String about;
  final List<InshortList> inshortList;

  @override
  Widget build(BuildContext context) {
    return CommonHomeCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(AppStrings.inShort, color: AppColors.whiteColor),
          CommonText.displaySmall(
            maxLines: 7,
            fontStyle: FontStyle.italic,
            color: AppColors.whiteColor,
            about.trim().isNotEmpty ? "“$about.”" : "",
          ),
          20.hBox,
          InshortWrapWidget(list: inshortList),
        ],
      ),
    );
  }
}

class LookingForSection extends StatelessWidget {
  const LookingForSection({super.key, required this.lookingFor});

  final String lookingFor;

  @override
  Widget build(BuildContext context) {
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
          LookingWrapWidget(list: lookingFor),
        ],
      ),
    );
  }
}

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.address});

  final dynamic address;

  @override
  Widget build(BuildContext context) {
    final city = address?.city ?? '';
    final country = address?.country ?? '';

    String locationText = '';
    if (city.toString().trim().isNotEmpty &&
        country.toString().trim().isNotEmpty) {
      locationText = '$city, $country';
    } else if (city.toString().trim().isNotEmpty) {
      locationText = city;
    } else if (country.toString().trim().isNotEmpty) {
      locationText = country;
    }

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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffF4F4F4),
                  ),
                  child: CommonText.text("📍"),
                ),
                5.wBox,
                Flexible(
                  child: CommonText.text(
                    locationText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key, required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.myInterest,
            fontWeight: FontWeight.w700,
          ),
          CommonText.labelMedium(
            AppStrings.interestSubtitle,
            fontWeight: FontWeight.w300,
          ),
          10.hBox,
          InterestWrapWidget(list: interests),
        ],
      ),
    );
  }
}

class ProfessionSection extends StatelessWidget {
  const ProfessionSection({super.key, required this.profession});

  final String profession;

  @override
  Widget build(BuildContext context) {
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
            widget: CommonText.text(AppMethods.capitalizeFirst(profession)),
          ),
        ],
      ),
    );
  }
}

class MorePhotosPreviewSection extends StatelessWidget {
  const MorePhotosPreviewSection({super.key, required this.firstImageUrl});

  final String firstImageUrl;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.titleMedium(
            AppStrings.morePictures,
            fontWeight: FontWeight.w700,
          ),
          10.hBox,
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child:
                firstImageUrl.isNotEmpty
                    ? CommonAssets.networkImage(firstImageUrl)
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key, required this.languages});

  final List<dynamic> languages;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
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
                languages.map((language) {
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
                    child: CommonText.labelLarge(
                      language.toString(),
                      fontWeight: FontWeight.w300,
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class AdditionalPhotosSection extends StatelessWidget {
  const AdditionalPhotosSection({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(imageUrls.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: CommonCard(
            widget: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CommonAssets.networkImage(imageUrls[index]),
            ),
          ),
        );
      }),
    );
  }
}
