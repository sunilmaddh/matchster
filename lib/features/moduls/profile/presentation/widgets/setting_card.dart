import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTop,
    this.isLeading = true,
  });

  final String image;
  final String title;
  final VoidCallback onTop;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // ignore: deprecated_member_use
          border: Border.all(width: 1.w, color: Colors.black.withOpacity(0.15)),
        ),
        child: ListTile(
          dense: true,
          leading:
              isLeading
                  ? SvgPicture.asset(height: 17.3.h, width: 17.28.w, image)
                  : SizedBox.shrink(),

          title: CommonText.text(
            title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 20.w),
        ),
      ),
    );
  }
}
