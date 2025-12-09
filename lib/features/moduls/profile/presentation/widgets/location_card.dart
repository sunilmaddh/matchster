import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.20)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        leading: SvgPicture.asset(AppAssets.locationAssets),
        title: CommonText.text(
          "Current Location",
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          fontFamily: "Caros",
        ),
        subtitle: CommonText.text(
          "Jamnagar, IND",
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
          fontFamily: "Caros",
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
