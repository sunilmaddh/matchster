import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class InterestCard extends StatelessWidget {
  InterestCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.color = const Color(0xffCEB4DE),
  });
  final String title;
  final String subTitle;
  final String image;
  Color color;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: Colors.black.withAlpha(53),
        radius: Radius.circular(20.r),
        dashPattern: const [4, 5],
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: Container(
          padding: EdgeInsets.all(8.r),
          height: 36.h,
          width: 36.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SvgPicture.asset(image),
        ),
        title: CommonText.text(
          title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          fontFamily: "Caros",
        ),
        subtitle: CommonText.text(
          subTitle,
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
          fontFamily: "Caros",
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
