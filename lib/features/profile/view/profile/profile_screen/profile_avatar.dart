import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        controller.allPfFame.isNotEmpty &&
        controller.allPfFame.first.url != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Container(
            padding: EdgeInsets.all(2.r),
            height: 69.h,
            width: 69.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xffE6D534), width: 3),
            ),
            child: ClipOval(
              child:
                  hasImage
                      ? CommonAssets.networkImage(
                        controller.allPfFame.first.url!,
                        fit: BoxFit.cover,
                      )
                      : Container(
                        color: const Color(0xffF0F0F0),
                        child: const Icon(
                          Icons.camera_alt,
                          color: AppColors.primary,
                        ),
                      ),
            ),
          ),
        ),
        Positioned(right: 1, top: -3, child: SvgPicture.asset(AppAssets.badge)),
      ],
    );
  }
}
