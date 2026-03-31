import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/common_assets.dart';
import 'package:matchster/core/extentions/extentions.dart';

class PhotoCard extends StatelessWidget {
  final String image;
  final VoidCallback? onDelete;

  const PhotoCard({super.key, required this.image, this.onDelete});

  @override
  Widget build(BuildContext context) {
    debugPrint(image);

    // base content for empty or non-empty state
    final Widget content =
        image.isEmpty
            ? DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(20.r),
                dashPattern: const [4, 5],
              ),
              child: Center(
                child: Card(
                  color: AppColors.progressDissableColor,
                  child: const Icon(Icons.add),
                ),
              ),
            )
            : Container(
              padding: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.grey, // border color
                  width: 1, // border width
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CommonAssets.networkImage(image),
              ),
            );

    return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: [
          Positioned.fill(child: content),
          if (image.isNotEmpty && onDelete != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
