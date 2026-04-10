import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/home/view/background_card.dart';
import 'package:matchster/features/home/view/profile_details_section.dart';
import 'package:matchster/features/home/widgets/dark_circle_widget.dart';
import 'package:matchster/features/home/widgets/main_photo_card.dart';
import 'package:matchster/features/home/widgets/no_more_profile_widget.dart';

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
    _homeController.callGetProfileApi();
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
                          _homeController.callGetRetriveProfileApi();
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
                                  BackgroundCard(
                                    homeController: _homeController,
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
                                                () => ValueNotifier(false),
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

                            ProfileDetailsSection(
                              data: data,
                              controller: _homeController,
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
}
