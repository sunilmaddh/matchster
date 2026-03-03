import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/extentions/interests_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
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
    required this.onVerticalDrag,
    required this.showUpArrow,
    required this.cardId,
  });

  final Profile data;
  final VoidCallback onLikeTap;
  final VoidCallback onDislikeTap;
  final void Function(double dy) onVerticalDrag;
  final ValueNotifier<bool> showUpArrow;
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) => onVerticalDrag(details.delta.dy),

      child: SizedBox(
        height: context.height * 0.80, // ✅ Fixed height
        width: double.infinity,

        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              CachedNetworkImage(
                imageUrl: data.mainPhoto ?? "",
                fit: BoxFit.cover, // 🔥 Important
                fadeInDuration: const Duration(milliseconds: 200),
                placeholder:
                    (_, __) => Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                errorWidget:
                    (_, __, ___) => Container(
                      color: Colors.white,
                      child: Center(child: SvgPicture.asset(AppAssets.appLogo)),
                    ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.85, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.blue.withOpacity(0.5),
                        Colors.blue.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),

              /// ✅ UP / DOWN ARROW
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: EdgeInsets.only(bottom: 120.h),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: showUpArrow,
                    builder: (_, isUp, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset(
                          isUp
                              ? AppAssets.downArrowAssets
                              : AppAssets.upArrowAssets,
                          // key: ValueKey(isUp),
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// ✅ BOTTOM CONTENT
              Positioned(
                left: 15.w,
                right: 15.w,
                bottom: 110.h,
                child: SafeArea(
                  top: false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// LEFT DETAILS
                      Expanded(child: _buildUserDetails()),

                      /// RIGHT BUTTONS
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// NAME + VERIFIED
        Row(
          children: [
            Expanded(
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
              "${data.distance} km away",
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
                  final interest = InterestEnumX.fromString(v);

                  return Container(
                    padding: 10.horizontalPadding + 3.verticalPadding,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.whiteColor),
                    ),
                    child: CommonText.text(
                      interest?.label ?? AppMethods.capitalizeFirst(v),
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  );
                }).toList(),
          ),
        ],
      ],
    );
  }

  String getFirstLetter(String? text) {
    if (text == null || text.trim().isEmpty) return '';
    return text.trim().characters.first.toUpperCase();
  }
}
