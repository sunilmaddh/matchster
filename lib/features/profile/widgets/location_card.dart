import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';

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
        title: CommonText.labelLarge(title, fontWeight: FontWeight.w700),
        subtitle: CommonText.labelSmall(subTitle, fontWeight: FontWeight.w300),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
