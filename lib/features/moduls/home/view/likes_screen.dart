import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/rectangle_card_widget.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';
import 'package:matchster/features/moduls/home/widgets/like_card.dart';

class LikesScreen extends StatelessWidget {
  LikesScreen({super.key});
  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    if (_controller.likeList.isEmpty) {
      _controller.getLikeOnMe();
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
                  "Likes",
                  fontFamily: "Caros",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                20.hBox,
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
                            fontFamily: "Caros",
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                            maxLines: 5,
                            "You have got multiple matches. Find out who they are",
                          ),
                          Row(
                            children: [
                              CommonText.text(
                                fontFamily: "Caros",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                maxLines: 5,
                                color: Color(0xff1D48EF),
                                "Explore",
                              ),
                              10.wBox,
                              Icon(
                                size: 30,
                                Icons.arrow_forward,
                                color: Color(0xff1D48EF),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.text(
                      fontFamily: "Caros",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      maxLines: 5,

                      "Likes",
                    ),
                    Icon(Icons.filter_list, color: Color(0xff797979)),
                  ],
                ),
                20.hBox,
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
                      text1: "99% match",
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
