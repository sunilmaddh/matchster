import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
import 'package:matchster/features/moduls/auth/widgets/photo_card.dart';
import 'package:matchster/features/moduls/auth/widgets/radio_widget.dart';
import 'package:matchster/features/moduls/auth/widgets/switch_widget.dart';
import 'package:matchster/features/moduls/auth/widgets/toggle_button_widget.dart';

class NameWidget extends StatelessWidget {
  NameWidget({super.key});
  final TextEditingController nameController = TextEditingController();
  final _onboardController = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.text(
            AppConstants.whatYourname,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),
          10.hBox,
          CustomFormField(
            label: "",
            hint: "Enter first name",
            controller: nameController,
            onChanged: (name) {
              if (name != null && name.isNotEmpty) {
                _onboardController.isEnable.value = true;
              }
            },
          ),
          10.hBox,
          Obx(
            () =>
                _onboardController.isEnable.isTrue
                    ? RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Caros",
                        ),
                        text: "${AppConstants.nameDiscription} ",
                        children: [
                          TextSpan(
                            text: AppConstants.nameDisSpan,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Caros",
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.whatYourGender,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),
          20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.genderDiscription,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          40.hBox,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: OnboardHalper.radioList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: 5.verticalPadding,
                child: RadioWidget(
                  text: OnboardHalper.radioList[index],
                  index: index,
                ),
              );
            },
          ),
          10.hBox,

          SwitchWidget(),
          20.hBox,
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Caros",
              ),
              text: "Note: ",
              children: [
                TextSpan(
                  text: AppConstants.genderNote,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Caros",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DobWidget extends StatelessWidget {
  DobWidget({super.key});
  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.whatYourDob,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),

          20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.dobDiscription,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          40.hBox,
          InkWell(
            onTap: () {
              CustomBottomSheet.show(
                context: context,
                child: SizedBox(
                  height: 300.h,

                  child: CupertinoDatePicker(
                    itemExtent: 50,
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: DateTime.now(),
                    minimumDate: DateTime(1925),
                    maximumDate: DateTime(2050),
                    // DateTime(
                    //   DateTime.now().year - 18,
                    //   DateTime.now().month,
                    //   DateTime.now().day,
                    // ),
                    onDateTimeChanged: (DateTime newDate) {
                      final formattedDate = DateFormat(
                        'dd/MM/yyyy',
                      ).format(newDate);
                      _controller.dobController.text = formattedDate;
                      // if (isNotDob == false) {
                      //   if (newDate.isAfter(initialDate)) {
                      //     AppSnackbar.show(
                      //       isError: true,
                      //       title: "Error",
                      //       message: "You must be at least 18 years old",
                      //     );
                      //     isFutureDate = true;
                      //   } else {
                      //     isFutureDate = false;
                      //     selectedDate = newDate;
                      //   }
                      // } else {
                      //   selectedDate = newDate;
                      // }
                    },
                  ),
                ),
              );
            },
            child: CustomFormField(
              enable: false,
              label: "",
              hint: AppConstants.hintDob,
              controller: _controller.dobController,
            ),
          ),
          10.hBox,
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Caros",
              ),
              text: "Note: ",
              children: [
                TextSpan(
                  text: AppConstants.dobNote1,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Caros",
                  ),
                ),
                TextSpan(
                  text: AppConstants.dobNote2,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Caros",
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: AppConstants.dobNote3,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Caros",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LikeWidget extends StatefulWidget {
  const LikeWidget({super.key});

  @override
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

          20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.likeDescr,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          40.hBox,
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

class YourHeightWidget extends StatelessWidget {
  YourHeightWidget({super.key});

  final _controller = Get.find<OnboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.text(
            AppConstants.whatYourHeight,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Caros",
          ),
          20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.dobDiscription,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          40.hBox,
          Align(
            alignment: Alignment.topRight,
            child: ToggleWithText(
              onTop: () {
                if (_controller.isNotFeet.isTrue) {
                  _controller.isNotFeet.value = false;
                } else {
                  _controller.isNotFeet.value = true;
                }
              },
              isFeet: _controller.isNotFeet,
            ),
          ),
          10.hBox,
          InkWell(
            onTap: () {
              CommonBottomSheet.showFullWidthCupertinoPicker(
                isNotFeet: _controller.isNotFeet,
                context: context,

                listInch:
                    _controller.isNotFeet.isTrue
                        ? OnboardHalper.heightListCmDecimal
                        : OnboardHalper.heightListInch,

                listFeet:
                    _controller.isNotFeet.isTrue
                        ? OnboardHalper.heightListCm
                        : OnboardHalper.heightListFeet,
                onSelected: (String feet, String inch) {
                  _controller.heightController.text = feet;
                },
                defaultFeet: '',
                defaultInch: '',
              );
            },
            child: CustomFormField(
              enable: false,
              label: "",
              hint: AppConstants.hintHeight,
              controller: _controller.heightController,
            ),
          ),
          10.hBox,
          Obx(
            () => RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Caros",
                ),
                text: "Note: ",
                children: [
                  TextSpan(
                    text: AppConstants.heightNote1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Caros",
                    ),
                  ),
                  TextSpan(
                    text:
                        _controller.isNotFeet.isTrue
                            ? AppConstants.heightNote2
                            : AppConstants.heightNote5,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Caros",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: AppConstants.heightNote3,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Caros",
                    ),
                  ),
                  TextSpan(
                    text:
                        _controller.isNotFeet.isTrue
                            ? AppConstants.heightNote4
                            : AppConstants.heightNote6,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Caros",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
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

          20.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.langDescr,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),
          40.hBox,
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
                      //  Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     SvgPicture.asset(v['image'], width: 24, height: 24),
                      //     5.wBox,
                      //     CommonText.text(
                      //       value,
                      //       color: AppColors.whiteColor,
                      //       fontSize: 17.sp,
                      //       fontWeight: FontWeight.w600,
                      //       fontFamily: "Caros",
                      //     ),
                      //   ],
                      // ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
    ;
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

          10.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.relegionDesc,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),

          30.hBox,
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

class DateWidget extends StatelessWidget {
  DateWidget({super.key});
  final _controller = Get.find<OnboardController>();
  int selectedIndex = 0;
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

          10.hBox,
          CommonText.text(
            maxLines: 2,
            AppConstants.relegionDesc,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Caros",
          ),

          30.hBox,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: OnboardHalper.dateList.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => Padding(
                    padding: 5.verticalPadding,
                    child: InkWell(
                      onTap: () {
                        _controller.selectedIndexDate.value = index;
                        if (_controller.isDateSelected.isTrue) {
                          _controller.isDateSelected.value = false;
                        } else {
                          _controller.isDateSelected.value = true;
                        }
                      },
                      child: Container(
                        padding: 10.horizontalPadding + 8.verticalPadding,
                        decoration: BoxDecoration(
                          gradient:
                              _controller.selectedIndexDate.value == index
                                  ? AppColors.gradiantPrimary
                                  : LinearGradient(
                                    colors: [
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                    ],
                                  ),

                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: CommonText.text(
                          color:
                              _controller.selectedIndexDate.value == index
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                          OnboardHalper.dateList[index],
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
            "Add Photos",
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
          10.hBox,
          CommonText.text(
            "Select 4 photos to complete your profile",
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          30.hBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final file = _controller.fileList[index];

              return InkWell(
                onTap: () {
                  _controller.selectedImageIndex.value = index;

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
                        onPressed: () async {
                          final image = await _controller!.takePicture();
                          print("Image Path: ${image.path}");
                        },
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
