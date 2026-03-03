

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/widgets/profile_photo_card.dart';

class AddImageGrid extends StatelessWidget {
  const AddImageGrid({
    super.key,
    required this.imageList,
    required this.onTop,
    required this.onTopRemove,
  });
  final RxList<HallOfFame> imageList;
  final Function(int index) onTop;
  final Function(String index) onTopRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final count = imageList.length; // Access observable here
        return GridView.builder(
          shrinkWrap: true,
          itemCount: 6, // Always show 6 slots
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            if (index < count) {
              // Show uploaded image
              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: CommonAssets.networkImage(
                        imageList[index].url!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: () {
                        onTopRemove(imageList[index].id!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withAlpha(40),
                              blurRadius: 2.07,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Show "Add Photo" placeholder
              return GestureDetector(
                onTap: () {
                  onTop(index);
                },
                child: ProfilePhotoCard(),
              );
            }
          },
        );
      }),
    );
  }
}
