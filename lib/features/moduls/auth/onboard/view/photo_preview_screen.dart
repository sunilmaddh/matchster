import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/buttons/app_button.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';

// ignore: must_be_immutable
class PhotoPreviewScreen extends StatelessWidget {
  PhotoPreviewScreen({super.key});
  RxBool isEnable = true.obs;

  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: 16.horizontalPadding + 16.verticalPadding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  name: "Upload",
                  onTop: () {
                    Get.back();
                  },
                  isEnable: _controller.isEnable.value,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                  60.hBox,
                  Image.file(
                    _controller.imageFile.value ?? File(""),
                    fit: BoxFit.cover,
                    // width: 167.w,
                    // height: 133.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
