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
    this.image,
    this.color = const Color(0xffCEB4DE),
    this.showBackArrow = true,
  });
  final String title;
  final String subTitle;
  String? image;
  Color color;
  bool showBackArrow;

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
          child:
              image == null
                  ? const Icon(Icons.email_outlined, color: Colors.white)
                  : SvgPicture.asset(image!),
        ),
        title: CommonText.labelLarge(title, fontWeight: FontWeight.w700),
        subtitle: CommonText.labelMedium(subTitle, fontWeight: FontWeight.w300),
        trailing: showBackArrow ? Icon(Icons.arrow_forward_ios) : null,
      ),
    );
  }
}
