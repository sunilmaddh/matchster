import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/shared/widgets/bar/custom_app_bar.dart';
import 'package:matchster/shared/widgets/bar/linear_progress_bar_with_badge.dart';
import 'package:matchster/shared/widgets/circular_image_with_shimmer.dart';
import 'package:matchster/shared/widgets/fields/common_text.dart';
import 'package:matchster/features/modules/profile/presentation/widgets/add_instagram_card.dart';
import 'package:matchster/features/modules/profile/presentation/widgets/add_spotify_card.dart';
import 'package:matchster/features/modules/profile/presentation/widgets/interest_card.dart';
import 'package:matchster/features/modules/profile/presentation/widgets/location_card.dart';
import 'package:matchster/features/modules/profile/presentation/widgets/profile_photo_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile", onTop: () {}),
      body: ListView(
        children: [
          Padding(
            padding: 15.horizontalPadding,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    AppAssets.profileHeader,
                    width: double.infinity,
                    height: 145.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 69.h,
                                width: 69.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xffE6D534),
                                    width: 3,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                top: -3,
                                child: SvgPicture.asset(AppAssets.badge),
                              ),
                            ],
                          ),
                          20.wBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  CommonText.text(
                                    "Role, 28",
                                    fontSize: 16.sp,
                                    fontFamily: "Caros",
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteColor,
                                  ),
                                  10.wBox,

                                  SvgPicture.asset(AppAssets.verified),
                                ],
                              ),
                              5.hBox,
                              Container(
                                padding:
                                    15.horizontalPadding + 2.verticalPadding,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffDEDEDE)),
                                ),
                                child: CommonText.text(
                                  "Preview Profile",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffBFBFBF),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      LinearProgressBarWithBadge(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(padding: 15.horizontalPadding, child: ProfilePhotoCard()),
          20.hBox,
          Padding(
            padding: 15.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Interests",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                5.hBox,
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: InterestCard(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: InterestCard(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: InterestCard(),
                ),

                10.hBox,
                CommonText.text(
                  "Location",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                5.hBox,
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: LocationCard(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: LocationCard(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: LocationCard(),
                ),
                10.hBox,
                CommonText.text(
                  "Make it short & funky",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                5.hBox,
                Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.20)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: 10.horizontalPadding + 5.verticalPadding,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hint: CommonText.text(
                          "a little bit about yourself...",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff898A8D),
                        ),
                        border: InputBorder.none,
                      ),
                      showCursor: false,
                    ),
                  ),
                ),
              ],
            ),
          ),

          20.hBox,
          Divider(color: Colors.black.withOpacity(0.20)),
          10.hBox,
          Padding(
            padding: 15.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  "Connect Accounts",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Caros",
                ),
                CommonText.text(
                  "build your connection more",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Caros",
                ),
                5.hBox,
                AddInstagramCard(),
                30.hBox,
                AddSpotifyCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
