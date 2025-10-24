import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: Colors.black.withOpacity(0.20),
        radius: Radius.circular(20.r),
        dashPattern: const [4, 5],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          height: 36.h,
          width: 36.w,
          decoration: BoxDecoration(
            color: Color(0xffCEB4DE),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SvgPicture.asset(AppAssets.gymAssets2),
        ),
        title: CommonText.text(
          "Workout",
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          fontFamily: "Caros",
        ),
        subtitle: CommonText.text(
          "Workout",
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
          fontFamily: "Caros",
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
