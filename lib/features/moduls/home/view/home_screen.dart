import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_card.dart';
import 'package:matchster/core/widgets/fields/common_home_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';
import 'package:matchster/features/moduls/home/widgets/dark_circle_widget.dart';
import 'package:matchster/features/moduls/home/widgets/main_photo_card.dart';
import 'package:matchster/features/moduls/profile/widgets/inshort_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/interest_wrap_widget.dart';
import 'package:matchster/features/moduls/profile/widgets/sub_common_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _homeController = Get.find<HomeController>();
  late AnimationController _controller;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> showUpArrow = ValueNotifier(true);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));

    _controller.forward();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        showUpArrow.value = true;
      } else if (direction == ScrollDirection.forward) {
        showUpArrow.value = false;
      }
    });
    _homeController.callGetProfile();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      body: Obx(() {
        final data = _homeController.profile.value;
        return _homeController.isGettingProfile.isTrue
            ? Center(child: CircularProgressIndicator())
            : Stack(
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
                              MainPhotoCard(
                                data: data,
                                animation: _animation,
                                onLikeTap: () {
                                  _homeController.isLike.value = true;
                                  _homeController.isOverlay.value = true;
                                  _homeController.createInterection(
                                    userId: data.userId!,
                                    action: "like",
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    _homeController.isOverlay.value = false;
                                    _homeController.isLike.value = false;

                                    _homeController.updateList();
                                    _controller
                                      ..reset()
                                      ..forward();
                                  });
                                },
                                onDislikeTap: () {
                                  _homeController.isLike.value = false;
                                  _homeController.isOverlay.value = true;
                                  _homeController.createInterection(
                                    userId: data.userId!,
                                    action: "dislike",
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    _homeController.isOverlay.value = false;
                                    _homeController.isLike.value = false;
                                    _homeController.updateList();
                                    _controller
                                      ..reset()
                                      ..forward();
                                  });
                                },
                                showUpArrow: showUpArrow,
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
                                                list:
                                                    _homeController.inShortList,
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

                                              // InshortWrapWidget(
                                              //   list: data.lookingFor!,
                                              // ),
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
                                                widget: CommonText.text(
                                                  "${data.distance.toString()} ",
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
                                                child:
                                                    CommonAssets.networkImage(
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
            );
      }),
    );
  }
}
