import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lottie/lottie.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';

class FaceOverlayWidget extends StatelessWidget {
  final Face? face;
  final Size? imageSize;
  final double maxW;
  final double maxH;

  const FaceOverlayWidget({
    super.key,
    required this.face,
    required this.imageSize,
    required this.maxW,
    required this.maxH,
  });

  @override
  Widget build(BuildContext context) {
    // if (face == null) {
    //   // Show centered face detector when no face is detected
    //   return Center(
    //     child: LottieBuilder.asset(
    //       AppAssets.scanning,
    //       width: 150,
    //       height: 150,
    //       repeat: true,
    //       reverse: false,
    //       animate: true,
    //     ),
    //   );
    // }

    final rect = face!.boundingBox;

    if (imageSize == null) {
      // Fallback positioning
      final left = rect.left.clamp(0.0, maxW).toDouble();
      final top = rect.top.clamp(0.0, maxH).toDouble();
      final width = rect.width.clamp(50.0, maxW - left).toDouble();
      final height = rect.height.clamp(50.0, maxH - top).toDouble();

      return Positioned(
        left: left,
        top: top,
        width: width,
        height: height,
        child: Center(
          child: LottieBuilder.asset(
            'assets/animations/loading.json',
            width: 150,
            height: 150,
            repeat: true,
            reverse: false,
            animate: true,
          ),
        ),
      );
    }

    // 🔹 CORRECTED BoxFit.contain mapping
    final imgW = imageSize!.width;
    final imgH = imageSize!.height;

    // Calculate scale to fit image within container
    final scaleX = maxW / imgW;
    final scaleY = maxH / imgH;
    final scale =
        scaleX < scaleY ? scaleX : scaleY; // Use smaller scale (contain)

    // Calculate actual displayed image dimensions
    final displayW = imgW * scale;
    final displayH = imgH * scale;

    // Calculate offset to center the image
    final offsetX = (maxW - displayW) / 2;
    final offsetY = (maxH - displayH) / 2;

    // Map face coordinates to display coordinates
    final left = offsetX + (rect.left * scale);
    final top = offsetY + (rect.top * scale);
    final width = rect.width * scale;
    final height = rect.height * scale;

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Center(
        child: LottieBuilder.asset(
          fit: BoxFit.cover,
          AppAssets.scanning,

          repeat: true,
          reverse: false,
          animate: true,
        ),
      ),
    );
  }
}
