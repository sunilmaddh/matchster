import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';

class SearchLocationScreen extends StatelessWidget {
  SearchLocationScreen({super.key});
  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Let us know where you're from!",
        onTop: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: 10.horizontalPadding,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Color(0xffF9FCFF),
                border: Border.all(color: Color(0xffDEEFFF), width: 1.w),
              ),
              child: TextFormField(
                showCursor: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  if (text.length >= 3) {
                    _controller.autoCompleteLocation(query: text);
                  }
                },
              ),
            ),
            10.hBox,
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: 15.horizontalPadding,
                    child: InkWell(
                      onTap: () {
                        _controller.placeDetailsLocation(
                          placeId:
                              _controller.autoCompleteResponse[index].placeId!,
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.locations,
                            color: AppColors.blackColor,
                          ),
                          10.wBox,

                          SizedBox(
                            width: 300.w,
                            child: CommonText.text(
                              maxLines: 3,
                              _controller
                                  .autoCompleteResponse[index]
                                  .description!,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.black.withAlpha(156),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: 15.verticalPadding,
                    child: Divider(height: 1),
                  );
                },
                itemCount: _controller.autoCompleteResponse.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
