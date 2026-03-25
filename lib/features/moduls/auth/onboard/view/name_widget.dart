import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/onboard/halper/onboard_halper.dart';
import 'package:matchster/features/moduls/auth/widgets/radio_widget.dart';

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
