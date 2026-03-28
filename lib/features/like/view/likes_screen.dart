import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/common/widgets/rectangle_card_widget.dart';
import 'package:matchster/features/home/controller/home_controller.dart';
import 'package:matchster/features/like/widget/like_card.dart';

class LikesScreen extends StatelessWidget {
  LikesScreen({super.key});
  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    if (_controller.likeList.isEmpty) {
      _controller.likeOnMe();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: 10.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text(
                  AppStrings.likesTitle,

                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                20.hBox,

                /// Top Card Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: RectangleCardWidget(isBlur: true)),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.text(
                            AppStrings.multipleMatchesMessage,

                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                            maxLines: 5,
                          ),
                          Row(
                            children: [
                              CommonText.text(
                                AppStrings.explore,

                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                maxLines: 5,
                                color: const Color(0xff1D48EF),
                              ),
                              10.wBox,
                              const Icon(
                                Icons.arrow_forward,
                                size: 30,
                                color: Color(0xff1D48EF),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.text(
                      AppStrings.likesTitle,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      maxLines: 5,
                    ),
                    const Icon(Icons.filter_list, color: Color(0xff797979)),
                  ],
                ),

                20.hBox,

                /// Grid
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.likeList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final value = _controller.likeList[index];

                    return LikeCard(
                      isBlur: true,
                      image: value.mainPhoto!,
                      text1: AppStrings.matchPercentage,
                      text2: "${value.name}, ${value.age}",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
