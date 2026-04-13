import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class ProfilePhotoCard extends StatelessWidget {
  const ProfilePhotoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 110.w,
      height: 108.h,
      decoration: BoxDecoration(
        color: Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: Color(0xff464646).withAlpha(112)),
          CommonText.labelSmall("Add Photos", color: Color(0xff464646)),
        ],
      ),
    );
  }
}
