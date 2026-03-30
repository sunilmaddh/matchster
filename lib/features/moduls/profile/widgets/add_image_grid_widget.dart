import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/features/moduls/profile/models/my_profile_response.dart';
import 'package:matchster/features/moduls/profile/widgets/profile_photo_card.dart';

class AddImageGrid extends StatelessWidget {
  const AddImageGrid({
    super.key,
    required this.imageList,
    required this.onTop,
    required this.onTopRemove,
    required this.onSwap,
  });

  final RxList<HallOfFame> imageList;
  final Function(int index) onTop;
  final Function(String id) onTopRemove;
  final Function(int position1, int position2) onSwap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        final count = imageList.length;

        return ReorderableGridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count == 6 ? 6 : count + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),

          onReorder: (oldIndex, newIndex) {
            if (oldIndex >= count || newIndex >= count) return;
            if (oldIndex < newIndex) newIndex -= 1;

            final pos1 = imageList[oldIndex].position ?? (oldIndex + 1);
            final pos2 = imageList[newIndex].position ?? (newIndex + 1);

            final item = imageList.removeAt(oldIndex);
            imageList.insert(newIndex, item);
            imageList.refresh();

            onSwap(pos1, pos2);
          },

          itemBuilder: (context, index) {
            if (index < count) {
              final item = imageList[index];
              return Container(
                key: ValueKey(item.id),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CommonAssets.networkImage(
                          item.url!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (index != 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => onTopRemove(item.id!),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close, size: 18),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }

            return Container(
              key: ValueKey("empty_$index"),
              child: GestureDetector(
                onTap: () => onTop(index),
                child: const ProfilePhotoCard(),
              ),
            );
          },
        );
      }),
    );
  }
}
