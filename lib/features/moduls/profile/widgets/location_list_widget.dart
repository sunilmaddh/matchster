import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/widgets/location_card.dart';

class LocationListWidget extends StatelessWidget {
  const LocationListWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.to(CurrentLocation());
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: LocationCard(title: title, subTitle: subTitle),
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(CurrentLocation());
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: LocationCard(title: 'Home town', subTitle: subTitle),
          ),
        ),
      ],
    );
  }
}
