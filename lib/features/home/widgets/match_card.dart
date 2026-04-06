import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.onTop, required this.image});
  final VoidCallback onTop;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: SizedBox(
        height: 100.h,
        width: 62.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(image, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
