// Copyright (c) 2025, Indo-Sakura Software Pvt Ltd. All rights reserved.
// Created By Adwaith c, 16/10/2025

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/location/search_location_screen.dart';

class HomeTownLocationScreen extends StatefulWidget {
  const HomeTownLocationScreen({super.key});
  @override
  State<HomeTownLocationScreen> createState() => _HomeTownLocationScreenState();
}

class _HomeTownLocationScreenState extends State<HomeTownLocationScreen> {
  final _profileController = Get.find<ProfileController>();

  late final TextEditingController homeAddressController;
  late final TextEditingController apartmentAreaController;
  late final ScrollController bottomSheetScrollController;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await bottomSheetAddressChange();
    });
  }

  Future<void> bottomSheetAddressChange() {
    return CustomBottomSheet.show(
      padding: 0.horizontalPadding + 20.verticalPadding,
      borderRadius: 40.r,

      child: SizedBox(
        height: 300.h,
        width: MediaQuery.of(context).size.width,

        child: Column(
          children: [
            10.hBox,
            SvgPicture.asset(AppAssets.loctionMarker),
            10.hBox,
            CommonText.text(
              "Are yuo sure?",
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),

            Padding(
              padding: 30.horizontalPadding,
              child: CommonText.text(
                maxLines: 2,
                textAlign: TextAlign.center,
                "Do you want to change your current location?",
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            25.hBox,
            Divider(height: 1),
            TextButton(
              onPressed: () {},
              child: CommonText.text(
                "Confirm",
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(height: 1),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: CommonText.text(
                color: AppColors.textFieldColor,
                "Dismis",
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  CommonText.text("Current Location"),
                ],
              ),
            ),
            Obx(() {
              final lat = _profileController.lattitude;
              final lng = _profileController.longitude;
              return GoogleMap(
                zoomControlsEnabled: true,
                buildingsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: (controller) {},
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat.value, lng.value),
                  zoom: 14.0,
                ),
              );
            }),

            const Center(
              child: Icon(Icons.location_pin, size: 50, color: Colors.red),
            ),

            SafeArea(
              child: Padding(
                padding: 5.horizontalPadding + 20.verticalPadding,
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.arrow_back),
                          ),
                          10.wBox,
                          CommonText.text(
                            "Current Location",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(SearchLocationScreen());
                        },
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
