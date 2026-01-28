import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:matchster/features/moduls/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/looking_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/sub_common_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _homeController = Get.find<HomeController>();

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> showUpArrow = ValueNotifier(true);

  @override
  void initState() {
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        showUpArrow.value = true;
      } else if (direction == ScrollDirection.forward) {
        showUpArrow.value = false;
      }
    });
    callGetProfileApi();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void callGetProfileApi() {
    if (_homeController.profileList.isEmpty) {
      _homeController.getProfileList(filterType: 'basic', filter: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      body: Obx(() {
        if (_homeController.isGettingProfile.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = _homeController.currentProfile;
        if (data == null) {
          return SizedBox.shrink();
        }

        final profiles = List<Profile>.from(_homeController.profileList);

        return GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(
                _scrollController.offset - details.delta.dy,
              );
            }
          },
          child: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    spacing: 0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: 15.horizontalPadding + 10.verticalPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(AppAssets.appLogo),
                            Row(
                              children: [
                                DarkCircleWidget(
                                  widget: Icon(
                                    Icons.notifications_outlined,
                                    color: AppColors.whiteColor,
                                  ),
                                  onTop: () {},
                                ),
                                20.wBox,
                                DarkCircleWidget(
                                  widget: Icon(
                                    Icons.filter_list_sharp,
                                    color: AppColors.whiteColor,
                                  ),
                                  onTop: () {
                                    // Get.to(FilterScreen());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 80.h,
                              child: CardSwiper(
                                threshold: 80,
                                maxAngle: 120,
                                controller: _homeController.swiperController,
                                allowedSwipeDirection:
                                    AllowedSwipeDirection.only(
                                      left: true,
                                      right: true,
                                      up: false,
                                      down: false,
                                    ),
                                numberOfCardsDisplayed: profiles.length,
                                cardsCount: profiles.length,
                                backCardOffset: const Offset(20, 20),
                                padding: EdgeInsets.zero,
                                onSwipe: _homeController.onSwipe,
                                cardBuilder: (
                                  context,
                                  index,
                                  horizontalThresholdPercentage,
                                  verticalThresholdPercentage,
                                ) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                        top: 0,
                                        child: Container(
                                          margin: 18.horizontalPadding,

                                          decoration: BoxDecoration(
                                            color: Color(0xffCDF0FF),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40.0.r),
                                              topRight: Radius.circular(40.0.r),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: 10.h,
                                        child: Container(
                                          margin: 13.horizontalPadding,

                                          decoration: BoxDecoration(
                                            color: Color(0xffF6E9FF),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40.0.r),
                                              topRight: Radius.circular(40.0.r),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Positioned.fill(
                                        top: 25.h,
                                        child: MainPhotoCard(
                                          data: profiles[index],

                                          onLikeTap: () {
                                            _homeController.handleInteraction(
                                              isLikeAction: true,
                                            );
                                          },
                                          onDislikeTap: () {
                                            _homeController.handleInteraction(
                                              isLikeAction: false,
                                            );
                                          },
                                          showUpArrow: showUpArrow,
                                          onVerticalDrag: (double dy) {
                                            if (_scrollController.hasClients) {
                                              _scrollController.jumpTo(
                                                (_scrollController.offset - dy)
                                                    .clamp(
                                                      0.0,
                                                      _scrollController
                                                          .position
                                                          .maxScrollExtent,
                                                    ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            Transform.translate(
                              offset: Offset(0, -10), // move upward
                              child: Container(
                                padding:
                                    15.verticalPadding + 15.horizontalPadding,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0.r),
                                    topRight: Radius.circular(20.0.r),
                                  ),
                                ),

                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: 20.horizontalPadding,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonText.text(
                                            "${data.name}, ${data.age}",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Caros",
                                          ),
                                          SvgPicture.asset(
                                            AppAssets.shareAssets,
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.hBox,

                                    if (data.about != null &&
                                        data.about!.isNotEmpty)
                                      CommonHomeCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonText.text(
                                              "In Short",
                                              color: AppColors.whiteColor,
                                            ),
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

                                            InshortWrapWidget(
                                              list: _homeController.inshortList,
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 15.h)
                                    else
                                      SizedBox.shrink(),

                                    if (data.lookingFor != null &&
                                        data.lookingFor!.isNotEmpty)
                                      CommonHomeCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonText.text(
                                              "Looking For",
                                              color: AppColors.whiteColor,
                                              fontFamily: "Caros",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            10.hBox,

                                            LookingWrapWidget(
                                              list: data.lookingFor!,
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 15.h)
                                    else
                                      SizedBox.shrink(),

                                    if (data.distance != null &&
                                        data.distance!.isNotEmpty)
                                      CommonHomeCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    child: CommonText.text(
                                                      "📍",
                                                    ),
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
                                    if (data.interests != null &&
                                        data.interests!.isNotEmpty)
                                      CommonCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            InterestWrapWidget(
                                              list: data.interests!,
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 15.h)
                                    else
                                      SizedBox.shrink(),

                                    if (data.work != null &&
                                        data.work!.isNotEmpty)
                                      CommonCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonText.text(
                                              "Profession",
                                              fontFamily: "Caros",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            5.hBox,
                                            SubCommonCard(
                                              widget: CommonText.text(
                                                data.work!,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      SizedBox.shrink(),
                                    15.hBox,
                                    if (data.morePictures != null &&
                                        data.morePictures!.isNotEmpty)
                                      CommonCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonText.text(
                                              "More Picture",
                                              fontFamily: "Caros",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            10.hBox,
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              child: CommonAssets.networkImage(
                                                data.morePictures!.first,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 15.h)
                                    else
                                      const SizedBox.shrink(),

                                    if (data.languages != null &&
                                        data.languages!.isNotEmpty)
                                      CommonCard(
                                        widget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonText.text(
                                              "Language",
                                              color: AppColors.blackColor,
                                              fontFamily: "Caros",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            10.hBox,

                                            InterestWrapWidget(
                                              list: data.languages!,
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 15.h)
                                    else
                                      SizedBox.shrink(),

                                    if (data.morePictures != null &&
                                        data.morePictures!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// Images list
                                          Column(
                                            children: List.generate(
                                              data.morePictures!.length - 1,
                                              (index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 15.h,
                                                  ),
                                                  child: CommonCard(
                                                    widget: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.r,
                                                          ),
                                                      child: CommonAssets.networkImage(
                                                        data.morePictures![index +
                                                            1],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      100.hBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
