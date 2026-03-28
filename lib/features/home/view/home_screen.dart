import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/address_x_ext.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/features/common/widgets/fields/common_card.dart';
import 'package:matchster/features/common/widgets/fields/common_home_card.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/widgets/dark_circle_widget.dart';
import 'package:matchster/features/home/widgets/main_photo_card.dart';
import 'package:matchster/features/home/widgets/no_more_profile_widget.dart';
import 'package:matchster/features/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/profile/widgets/sub_common_card.dart';

class HomeScreen extends BaseView<HomeController> {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  bool get useDefaultLoader => false;
}

class _HomeScreenState extends BaseViewState<HomeController, HomeScreen> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isGettingProfile.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final profile = controller.currentProfile;

        return Column(
          children: [
            _buildTopBar(),
            10.hBox,
            Expanded(
              child:
                  profile == null || controller.profileList.isEmpty
                      ? const NoMoreProfileWidget()
                      : SingleChildScrollView(
                        controller: controller.scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom:
                              kBottomNavigationBarHeight +
                              MediaQuery.of(context).padding.bottom +
                              20.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHomeCardSection(context),
                            _buildProfileDetailsSection(profile),
                          ],
                        ),
                      ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: 15.horizontalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppAssets.appLogo),
            Row(
              children: [
                DarkCircleWidget(
                  widget: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.whiteColor,
                  ),
                  onTop: () {},
                ),
                20.wBox,
                DarkCircleWidget(
                  widget: const Icon(
                    Icons.filter_list_sharp,
                    color: AppColors.whiteColor,
                  ),
                  onTop: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCardSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.88,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: 18.horizontalPadding,
              decoration: BoxDecoration(
                color: const Color(0xffCDF0FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
              ),
            ),
          ),
          Positioned.fill(
            top: 7.h,
            child: Container(
              margin: 13.horizontalPadding,
              decoration: BoxDecoration(
                color: const Color(0xffF6E9FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
              ),
            ),
          ),
          CardSwiper(
            padding: EdgeInsets.only(top: 15.h),
            controller: controller.swiperController,
            cardsCount: controller.profileList.length,
            numberOfCardsDisplayed:
                controller.profileList.length > 3
                    ? 3
                    : controller.profileList.length,
            allowedSwipeDirection: const AllowedSwipeDirection.only(
              left: true,
              right: true,
            ),
            onSwipe: controller.onSwipe,
            cardBuilder: (context, index, _, __) {
              return MainPhotoCard(
                data: controller.profileList[index],
                showUpArrow: controller.showUpArrow,
                onLikeTap: controller.onLikeTap,
                onDislikeTap: controller.onDislikeTap,
                onVerticalDrag: controller.onVerticalDrag,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetailsSection(Profile profile) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        width: double.infinity,
        padding: 15.verticalPadding + 15.horizontalPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: _buildProfileDetails(profile),
      ),
    );
  }

  Widget _buildProfileDetails(Profile profile) {
    final city = profile.currentAddress?.city ?? '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: 20.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText.text(
                  AppStrings.profileTitle(name: profile.name, age: profile.age),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Caros',
                ),
              ),
            ],
          ),
        ),
        10.hBox,

        if ((profile.about ?? '').isNotEmpty)
          CommonHomeCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.inShort,
                  color: AppColors.whiteColor,
                ),
                CommonText.text(
                  AppStrings.quotedAbout(profile.about ?? ''),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Caros',
                  maxLines: 7,
                  fontStyle: FontStyle.italic,
                  color: AppColors.whiteColor,
                ),
                20.hBox,
                InshortWrapWidget(list: controller.inShortItems),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.lookingFor ?? []).isNotEmpty)
          CommonHomeCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.lookingFor,
                  color: AppColors.whiteColor,
                  fontFamily: 'Caros',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,
                LookingWrapWidget(list: profile.lookingFor!),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.distance ?? '').toString().isNotEmpty)
          CommonHomeCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.location,
                  color: AppColors.whiteColor,
                  fontFamily: 'Caros',
                  fontSize: 16.sp,
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
                        child: CommonText.text('📍'),
                      ),
                      5.wBox,
                      CommonText.text(
                        AppStrings.distanceKm(profile.distance.toString()),
                        color: const Color(0xffD90380),
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      5.wBox,
                      Expanded(
                        child: CommonText.text(
                          AppStrings.awayFromCity(city: city),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.interests ?? []).isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.myInterest,
                  fontFamily: 'Caros',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                CommonText.text(
                  AppStrings.interestSubtitle,
                  fontFamily: 'Caros',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
                10.hBox,
                InterestWrapWidget(list: profile.interests!),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.work ?? '').isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.profession,
                  fontFamily: 'Caros',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                5.hBox,
                SubCommonCard(widget: CommonText.text(profile.work!)),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.morePictures ?? []).isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.morePicture,
                  fontFamily: 'Caros',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CommonAssets.networkImage(profile.morePictures!.first),
                ),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.languages ?? []).isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.language,
                  color: AppColors.blackColor,
                  fontFamily: 'Caros',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,
                InterestWrapWidget(list: profile.languages!),
              ],
            ),
          ).paddingOnly(bottom: 15.h),

        if ((profile.morePictures ?? []).length > 1)
          Column(
            children: List.generate(
              profile.morePictures!.length - 1,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: CommonCard(
                  widget: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CommonAssets.networkImage(
                      profile.morePictures![index + 1],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
