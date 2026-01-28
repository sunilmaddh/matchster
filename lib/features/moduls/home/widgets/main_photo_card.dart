import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:matchster/features/moduls/home/widgets/circle_widget.dart';

class MainPhotoCard extends StatelessWidget {
  const MainPhotoCard({
    super.key,
    required this.data,

    required this.onLikeTap,
    required this.onDislikeTap,
    required this.showUpArrow,
    required this.onVerticalDrag,
  });
  final Profile data;

  final VoidCallback onLikeTap;
  final VoidCallback onDislikeTap;
  final void Function(double dy) onVerticalDrag;
  final ValueNotifier<bool> showUpArrow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (details) {
        onVerticalDrag(details.delta.dy);
      },
      child: Container(
        height: MediaQuery.of(context).size.height - 80.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data.mainPhoto.toString()),

            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0.r),
            topRight: Radius.circular(40.0.r),
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.center,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    const Color(0xFF7A96F8).withAlpha(0), // 0.0
                    const Color(0xFF587DFF).withAlpha(128), // 0.50
                    const Color(0xFF5174FF).withAlpha(191), // 0.75
                    const Color(0xFF3F66FF).withAlpha(223), // 0.87
                    const Color(0xFF1D48EF).withAlpha(0), // 0.0
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: showUpArrow,
              builder: (_, isUp, __) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 220.h),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      key: ValueKey(isUp),
                      child: SvgPicture.asset(
                        isUp
                            ? AppAssets.downArrowAssets
                            : AppAssets.upArrowAssets,
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Platform.isAndroid ? 120.h : 160.h,
                      left: 25.w,
                      right: 25.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: CommonText.text(
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    "${data.name}, ${data.age}",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Caros",
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                2.wBox,

                                SvgPicture.asset(AppAssets.verified),
                                100.wBox,
                              ],
                            ),
                            if (data.distance != null &&
                                data.distance!.isNotEmpty)
                              CommonText.text(
                                "${data.distance}km. away",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Caros",
                                color: AppColors.whiteColor,
                              ),
                            15.hBox,
                            if (data.interests != null &&
                                data.interests!.isNotEmpty)
                              Wrap(
                                children:
                                    data.interests!.take(2).map((v) {
                                      final intarestList =
                                          InterestEnumX.fromString(v);
                                      return Container(
                                        margin: EdgeInsets.only(right: 5.w),
                                        padding:
                                            10.horizontalPadding +
                                            3.verticalPadding,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                          border: Border.all(
                                            color: AppColors.whiteColor,
                                            width: 0.96.w,
                                          ),
                                        ),
                                        child: CommonText.text(
                                          intarestList?.label ??
                                              AppMethods.capitalizeFirst(v),
                                          fontSize: 11.5.sp,
                                          fontFamily: "Caros",
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteColor,
                                        ),
                                      );
                                    }).toList(),
                              )
                            else
                              SizedBox.shrink(),
                          ],
                        ),
                        20.hBox,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleWidget(
                              image: AppAssets.likeAssets,
                              text: "Like",
                              onTop: onLikeTap,
                            ),

                            10.hBox,
                            CircleWidget(
                              isGradient: false,
                              image: AppAssets.dislike,
                              text: "Dislike",
                              onTop: onDislikeTap,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.hBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
