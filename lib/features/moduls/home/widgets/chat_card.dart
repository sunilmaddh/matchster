import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,
    required this.onTop,
  });
  final String image;
  final String text1;
  final String text2;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Row(
        children: [
          SizedBox(
            height: 67.h,
            width: 68.w,
            child: Stack(
              children: [
                ClipOval(
                  child: Image.asset(
                    height: 67.h,
                    width: 67.w,
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 6.w,
                  bottom: 7.h,
                  child: Container(
                    padding: EdgeInsets.zero,
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          15.wBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.text(
                text1,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Caros",
              ),
              CommonText.text(
                overflow: TextOverflow.ellipsis,
                text2,
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                fontFamily: "Caros",
                color: Colors.black.withOpacity(0.50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
