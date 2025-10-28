import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extensions.dart';
import 'package:matchster/shared/widgets/fields/common_text.dart';

class AddInstagramCard extends StatelessWidget {
  const AddInstagramCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 10.horizontalPadding + 10.verticalPadding,
      decoration: BoxDecoration(
        color: Color(0xffF8EAFF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppAssets.circleInstagramAssets),
              10.wBox,
              CommonText.text(
                "Add your Instagram",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Caros",
              ),
            ],
          ),
          10.hBox,
          CommonText.text(
            maxLines: 4,
            AppConstants.linkingYourInstagram,
            fontWeight: FontWeight.w300,
            fontSize: 10.sp,
            fontFamily: "Caros",
          ),
          20.hBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              return SizedBox(
                width: 55.w,
                height: 60.h,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 46.w,
                      height: 46.h,
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: Colors.black.withOpacity(0.50),
                          radius: Radius.circular(20.r),
                          dashPattern: [3, 4],
                        ),
                        child: Container(
                          width: 46.w,
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: -1,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        // width: 15.w,
                        // height: 15.h,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(blurRadius: 3, color: Colors.black26),
                          ],
                        ),
                        child: Icon(Icons.close, size: 15),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
