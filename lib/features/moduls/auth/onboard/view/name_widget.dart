import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/services/image_upload_services.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/common_bottom_sheet.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/moduls/auth/onboard/controller/onboard_controller.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/onboard/widgets/photo_card.dart';
import 'package:matchster/features/moduls/auth/onboard/view/photo_preview_screen.dart';
import 'package:matchster/features/moduls/auth/widgets/radio_widget.dart';
import 'package:matchster/features/moduls/auth/widgets/switch_widget.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LikeWidgetState createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  final TextEditingController controller = TextEditingController();
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.likeTitle,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),

          // 20.hBox,
          CommonText.text(
            maxLines: 4,
            AppConstants.likeDescr,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          20.hBox,
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children:
                OnboardHalper.likeList.map((v) {
                  final String value = v['value'];
                  final bool isSelected = selectedItems.contains(value);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedItems.remove(value);
                        } else {
                          selectedItems.add(value);
                        }
                      });
                    },
                    child: Container(
                      padding: 10.horizontalPadding + 4.verticalPadding,
                      decoration: BoxDecoration(
                        gradient:
                            isSelected
                                ? AppColors.gradiantPrimary
                                : AppColors.circleGradiantColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(v['image'], width: 24, height: 24),
                          5.wBox,
                          CommonText.text(
                            value,
                            color: AppColors.whiteColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Caros",
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class LanguageListWidget extends StatefulWidget {
  const LanguageListWidget({super.key});

  @override
  State<LanguageListWidget> createState() => _LanguageListWidgetState();
}

class _LanguageListWidgetState extends State<LanguageListWidget> {
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.languageTitle,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),

          // 20.hBox,
          CommonText.text(
            maxLines: 3,

            AppConstants.langDescr,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          20.hBox,
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children:
                OnboardHalper.languegeList.map((v) {
                  final bool isSelected = selectedItems.contains(v);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedItems.remove(v);
                        } else {
                          selectedItems.add(v);
                        }
                      });
                    },
                    child: Container(
                      padding: 10.horizontalPadding + 4.verticalPadding,
                      decoration: BoxDecoration(
                        gradient:
                            isSelected
                                ? AppColors.gradiantPrimary
                                : AppColors.circleGradiantColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CommonText.text(
                        v,
                        color: AppColors.whiteColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Caros",
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class ReligionWidget extends StatelessWidget {
  const ReligionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.religionTitle,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),

          // 10.hBox,
          CommonText.text(
            maxLines: 3,
            AppConstants.relegionDesc,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),

          20.hBox,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: OnboardHalper.religionList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: 5.verticalPadding,
                  child: RadioWidget(
                    text: OnboardHalper.religionList[index],
                    index: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

class AddPhotoWidget extends StatelessWidget {
  AddPhotoWidget({super.key});
  final _controller = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            maxLines: 2,
            "Show off your best photos and videos!",
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
          // 10.hBox,
          CommonText.text(
            maxLines: 3,
            "Upload 5-6 favorite photos or a video to let your personality shine. Make sure your uploads are clear and capture the real you!",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          20.hBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final file = _controller.fileList[index];

              return InkWell(
                onTap: () {
                  _controller.selectedImageIndex.value = index;
                  _controller.imageFile = _controller.fileList[index];

                  CustomBottomSheet.show(
                    borderRadius: 40.r,
                    backgroundColor: const Color(0xffF4F4F4),
                    padding: EdgeInsets.zero,
                    context: context,
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: 15.horizontalPadding + 30.verticalPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  OnboardHalper.addPhotoOption.map((v) {
                                    return InkWell(
                                      onTap: () async {
                                        File? selectedImage;

                                        if (v["text"] == "Camera") {
                                          selectedImage =
                                              await ImageUploadServices()
                                                  .getImageFromCamera();
                                        } else if (v["text"] == "File") {
                                          selectedImage =
                                              await ImageUploadServices()
                                                  .getImageFromGallery();
                                        }

                                        if (selectedImage != null) {
                                          _controller.updateFile(
                                            index,
                                            selectedImage,
                                          );
                                        }
                                        Get.back();
                                        Get.to(PhotoPreviewScreen());
                                        // Get.back();
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(v["image"]),
                                          CommonText.text(
                                            v["text"],
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                          const Divider(height: 1),
                          10.hBox,
                          TextButton(
                            onPressed: () => Get.back(),
                            child: CommonText.text(
                              "Cancel",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: PhotoCard(
                  image: file,
                  onDelete: () {
                    _controller.removeFile(index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScanningScreenState createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  CameraController? _controller;
  late List<CameraDescription> _cameras;

  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[1], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
          _isCameraInitialized
              ? Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_controller!),
                  ), // Camera feed
                  Positioned.fill(
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.faceDetector,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: FloatingActionButton(
                        onPressed: () async {},
                        child: Icon(Icons.camera),
                      ),
                    ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator()),
    );
  }
}
