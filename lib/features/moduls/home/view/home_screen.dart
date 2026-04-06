import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/address_x_ext.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:matchster/features/moduls/home/widgets/dark_circle_widget.dart';
import 'package:matchster/features/moduls/home/widgets/main_photo_card.dart';
import 'package:matchster/features/moduls/home/widgets/no_more_profile_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/sub_common_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.find<HomeController>();
  final ScrollController _scrollController = ScrollController();
  final Map<String, ValueNotifier<bool>> _arrowNotifiers = {};

  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    callGetProfileApi();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final currentOffset = _scrollController.offset;

    final currentCardId =
        _homeController.currentProfile?.userId ??
        'card_${_homeController.profileList.indexOf(_homeController.currentProfile)}';

    final notifier = _arrowNotifiers.putIfAbsent(
      currentCardId,
      () => ValueNotifier(false),
    );

    const double threshold = 5.0;

    if (currentOffset - _lastOffset > threshold && !notifier.value) {
      notifier.value = true;
    } else if (_lastOffset - currentOffset > threshold && notifier.value) {
      notifier.value = false;
    }

    _lastOffset = currentOffset;
  }

  void callGetProfileApi() async {
    if (_homeController.profileList.isEmpty) {
      await _homeController.getProfileList(filterType: 'basic', filter: 10);
    }
  }

  Future<void> callGetRetriveProfileApi() async {
    if (_homeController.profileList.isEmpty) {
      await _homeController.getRetriveProfileList();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    for (var notifier in _arrowNotifiers.values) {
      notifier.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Obx(() {
        if (_homeController.isGettingProfile.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final data = _homeController.currentProfile;

        return Column(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(AppAssets.appLogo, height: 20.h),
                    Row(
                      children: [
                        DarkCircleWidget(
                          widget: const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.whiteColor,
                          ),
                          onTop: () {},
                        ),
                        10.wBox,
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
            ),

            /// MAIN CONTENT
            Expanded(
              child:
                  data == null ||
                          _homeController.profileList.isEmpty ||
                          _homeController.currentIndex.value >=
                              _homeController.profileList.length
                      ? NoMoreProfileWidget(
                        retrieveProfileonTap: () {
                          callGetRetriveProfileApi();
                        },
                      )
                      : SingleChildScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom:
                              kBottomNavigationBarHeight +
                              MediaQuery.of(context).padding.bottom +
                              20.h, // space above bottom nav
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  /// BACKGROUND CARD 2 (BOTTOM)
                                  if (_homeController.profileList.length > 2)
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.80,
                                        margin: EdgeInsets.only(
                                          left: 16.w,
                                          right: 16.w,
                                          top: 16.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            40.r,
                                          ),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.black.withOpacity(
                                          //       0.1,
                                          //     ),
                                          //     blurRadius: 10,
                                          //     offset: const Offset(0, 5),
                                          //   ),
                                          // ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.r),
                                            topRight: Radius.circular(40.r),
                                          ),
                                          child: Obx(() {
                                            final nextIndex =
                                                _homeController
                                                    .currentIndex
                                                    .value +
                                                2;
                                            if (nextIndex <
                                                _homeController
                                                    .profileList
                                                    .length) {
                                              return CommonAssets.networkImage(
                                                _homeController
                                                        .profileList[nextIndex]
                                                        .mainPhoto ??
                                                    '',
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return Container(
                                              color: Colors.white,
                                            );
                                          }),
                                        ),
                                      ),
                                    ),

                                  /// BACKGROUND CARD 1 (MIDDLE)
                                  if (_homeController.profileList.length > 1)
                                    Positioned(
                                      top: 20,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.90,
                                        margin: EdgeInsets.only(
                                          left: 8.w,
                                          right: 8.w,
                                          top: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            40.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.15,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.r),
                                            topRight: Radius.circular(40.r),
                                          ),
                                          child: Obx(() {
                                            final nextIndex =
                                                _homeController
                                                    .currentIndex
                                                    .value +
                                                1;
                                            if (nextIndex <
                                                _homeController
                                                    .profileList
                                                    .length) {
                                              return CommonAssets.networkImage(
                                                _homeController
                                                        .profileList[nextIndex]
                                                        .mainPhoto ??
                                                    '',
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          }),
                                        ),
                                      ),
                                    ),

                                  /// CARD SWIPER (TOP)
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.65,
                                      child: CardSwiper(
                                        key: ValueKey(
                                          _homeController.swiperKey.value,
                                        ),
                                        padding: EdgeInsets.zero,
                                        backCardOffset: const Offset(0, 0),
                                        controller:
                                            _homeController.swiperController,
                                        cardsCount:
                                            _homeController.profileList.length,
                                        numberOfCardsDisplayed:
                                            _homeController
                                                        .profileList
                                                        .length >=
                                                    3
                                                ? 3
                                                : _homeController
                                                    .profileList
                                                    .length,
                                        allowedSwipeDirection:
                                            AllowedSwipeDirection.only(
                                              left: true,
                                              right: true,
                                            ),
                                        onSwipe: _homeController.onSwipe,
                                        cardBuilder: (context, index, _, __) {
                                          if (index >=
                                              _homeController
                                                      .profileList
                                                      .length -
                                                  1) {
                                            return Container(
                                              height: Get.height,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                            );
                                          }
                                          final cardId =
                                              _homeController
                                                  .profileList[index]
                                                  .userId ??
                                              'card_$index';
                                          final showUpArrow = _arrowNotifiers
                                              .putIfAbsent(
                                                cardId,
                                                () => ValueNotifier(true),
                                              );
                                          return MainPhotoCard(
                                            key: ValueKey(cardId),
                                            data:
                                                _homeController
                                                    .profileList[index],
                                            showUpArrow: showUpArrow,
                                            cardId: cardId,
                                            onLikeTap:
                                                () => _homeController
                                                    .handleInteraction(
                                                      isLikeAction: true,
                                                    ),
                                            onDislikeTap:
                                                () => _homeController
                                                    .handleInteraction(
                                                      isLikeAction: false,
                                                    ),
                                            onVerticalDrag: (dy) {
                                              if (_scrollController
                                                  .hasClients) {
                                                _scrollController.jumpTo(
                                                  (_scrollController.offset -
                                                          dy)
                                                      .clamp(
                                                        0.0,
                                                        _scrollController
                                                            .position
                                                            .maxScrollExtent,
                                                      ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// PROFILE DETAILS (THIS PART SCROLLS)
                            Transform.translate(
                              offset: const Offset(0, -10),
                              child: Container(
                                width: double.infinity,
                                padding:
                                    40.verticalPadding + 15.horizontalPadding,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r),
                                  ),
                                ),
                                child: _buildProfileDetails(data),
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileDetails(Profile data) {
    return
    //  Transform.translate(
    //   offset: Offset(0, -20), // move upward
    //   child: Container(
    //     padding: 15.verticalPadding + 15.horizontalPadding,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(20.0.r),
    //         topRight: Radius.circular(20.0.r),
    //       ),
    //     ),
    //  child:
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: 20.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText.text(
                  "${data.name}, ${data.age}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Caros",
                  overflow: TextOverflow.fade,
                ),
              ),
              // SvgPicture.asset(
              //   AppAssets.shareAssets,
              // ),
            ],
          ),
        ),
        10.hBox,

        if (data.about != null && data.about!.isNotEmpty)
          CommonHomeCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text("In Short", color: AppColors.whiteColor),
                CommonText.text(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Caros",
                  maxLines: 7,
                  fontStyle: FontStyle.italic,
                  color: AppColors.whiteColor,
                  "“${data.about}.”",
                ),

                20.hBox,

                InshortWrapWidget(list: _homeController.inshortList),
              ],
            ),
          ).paddingOnly(bottom: 15.h)
        else
          SizedBox.shrink(),

        if (data.lookingFor != null && data.lookingFor!.isNotEmpty)
          CommonHomeCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Looking For",
                  color: AppColors.whiteColor,
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,

                LookingWrapWidget(list: data.lookingFor!),
              ],
            ),
          ).paddingOnly(bottom: 15.h)
        else
          SizedBox.shrink(),

        if (data.distance != null && data.distance!.isNotEmpty)
          CommonHomeCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Location",
                  color: AppColors.whiteColor,
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,

                // ),
                CommonCard(
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: 7.allPadding,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffF4F4F4),
                        ),
                        child: CommonText.text("📍"),
                      ),
                      5.wBox,
                      CommonText.text(
                        color: Color(0xffD90380),
                        "${data.distance.toString()} km",
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      5.wBox,
                      CommonText.text(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        "away, ${data.currentAddress!.city}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox.shrink(),
        15.hBox,
        if (data.interests != null && data.interests!.isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "My Interest",
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                CommonText.text(
                  "Express your interests to find your ideal match",
                  fontFamily: "Caros",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
                10.hBox,
                InterestWrapWidget(list: data.interests!),
              ],
            ),
          ).paddingOnly(bottom: 15.h)
        else
          SizedBox.shrink(),

        if (data.work != null && data.work!.isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Profession",
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                5.hBox,
                SubCommonCard(widget: CommonText.text(data.work!)),
              ],
            ),
          )
        else
          SizedBox.shrink(),
        15.hBox,
        if (data.morePictures != null && data.morePictures!.isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "More Picture",
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CommonAssets.networkImage(data.morePictures!.first),
                ),
              ],
            ),
          ).paddingOnly(bottom: 15.h)
        else
          const SizedBox.shrink(),

        if (data.languages != null && data.languages!.isNotEmpty)
          CommonCard(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Language",
                  color: AppColors.blackColor,
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                10.hBox,

                InterestWrapWidget(list: data.languages!),
              ],
            ),
          ).paddingOnly(bottom: 15.h)
        else
          SizedBox.shrink(),

        if (data.morePictures != null && data.morePictures!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Images list
              Column(
                children: List.generate(data.morePictures!.length - 1, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: CommonCard(
                      widget: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: CommonAssets.networkImage(
                          data.morePictures![index + 1],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
