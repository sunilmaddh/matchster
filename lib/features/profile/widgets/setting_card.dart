import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTop,
    this.isLeading = true,
    this.color = AppColors.whiteColor,
  });

  final String image;
  final String title;
  final VoidCallback onTop;
  final bool isLeading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 58.h,
        decoration: BoxDecoration(
          color: AppColors.settingCardColor,
          borderRadius: BorderRadius.circular(20.r),
          // ignore: deprecated_member_use
          // border: Border.all(width: 1.w, color: Colors.black.withOpacity(0.15)),
        ),
        child: ListTile(
          dense: true,
          leading: Container(
            padding: EdgeInsets.all(8.r),
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child:
                image == null
                    ? const Icon(Icons.email_outlined, color: Colors.white)
                    : SvgPicture.asset(image),
          ),
          title: CommonText.titleLarge(title, fontWeight: FontWeight.w400),
          trailing: Icon(Icons.arrow_forward_ios, size: 20.w),
        ),
      ),
    );
  }
}
