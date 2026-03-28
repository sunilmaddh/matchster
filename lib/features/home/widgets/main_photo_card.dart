import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/widgets/circle_widget.dart';

class MainPhotoCard extends StatelessWidget {
  const MainPhotoCard({
    super.key,
    required this.data,
    required this.onLikeTap,
    required this.onDislikeTap,
    required this.onVerticalDrag,
    required this.showUpArrow,
  });

  final Profile data;
  final VoidCallback onLikeTap;
  final VoidCallback onDislikeTap;
  final void Function(double dy) onVerticalDrag;
  final RxBool showUpArrow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (details) {
        onVerticalDrag(details.delta.dy);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
                child: Image(
                  image: NetworkImage(data.mainPhoto.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.6, 0.85, 1.0],
                    colors: [
                      const Color(0xFF7A96F8).withAlpha(0),
                      const Color(0xFF587DFF).withAlpha(150),
                      const Color(0xFF3F66FF).withAlpha(220),
                      const Color(0xFF1D48EF),
                    ],
                  ),
                ),
              ),
            ),

            Obx(() {
              final isUp = showUpArrow.value;
              return Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: EdgeInsets.only(bottom: 120.h),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(
                      isUp
                          ? AppAssets.downArrowAssets
                          : AppAssets.upArrowAssets,
                      key: ValueKey(isUp),
                    ),
                  ),
                ),
              );
            }),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                minimum: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  bottom: 110.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: CommonText.text(
                                  "${getFirstLetter(data.name)}, ${data.age}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Caros",
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              6.wBox,
                              SvgPicture.asset(AppAssets.verified),
                            ],
                          ),

                          if (data.distance?.isNotEmpty ?? false)
                            Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: CommonText.text(
                                "${data.distance} km ${AppStrings.away}",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),

                          if (data.interests?.isNotEmpty ?? false) ...[
                            12.hBox,
                            Wrap(
                              spacing: 6.w,
                              runSpacing: 6.h,
                              children:
                                  data.interests!.take(2).map((v) {
                                    final interest = InterestEnumX.fromString(
                                      v,
                                    );
                                    return Container(
                                      padding:
                                          10.horizontalPadding +
                                          3.verticalPadding,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.whiteColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: CommonText.text(
                                        interest?.label ??
                                            AppMethods.capitalizeFirst(v),
                                        fontSize: 11.5.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.whiteColor,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleWidget(
                          image: AppAssets.likeAssets,
                          text: AppStrings.like,
                          onTop: onLikeTap,
                        ),
                        10.hBox,
                        CircleWidget(
                          isGradient: false,
                          image: AppAssets.dislike,
                          text: AppStrings.dislike,
                          onTop: onDislikeTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String shortName(String name) =>
      name.length > 5 ? "${name.substring(0, 5)}…" : name;

  String getFirstLetter(String? text) {
    if (text == null || text.trim().isEmpty) return '';
    return text.trim().characters.first.toUpperCase();
  }
}
