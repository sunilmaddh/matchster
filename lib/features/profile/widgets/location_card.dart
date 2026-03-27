import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(51)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        leading: SvgPicture.asset(AppAssets.locationAssets),
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
