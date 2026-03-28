import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/location_controller.dart';
import 'package:matchster/routes/app_routes.dart';

class HomeTownLocationScreen extends BaseView<LocationController> {
  const HomeTownLocationScreen({super.key});

  @override
  State<HomeTownLocationScreen> createState() => _HomeTownLocationScreenState();
}

class _HomeTownLocationScreenState
    extends BaseViewState<LocationController, HomeTownLocationScreen> {
  @override
  void onReady() {
    super.onReady();
    _loadData();
  }

  Future<void> _loadData() async {
    await controller.fetchCurrentLocation();
    if (!mounted) return;
    await _showAddressChangeBottomSheet();
  }

  Future<void> _showAddressChangeBottomSheet() async {
    await CustomBottomSheet.show(
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
              AppStrings.areYouSure,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: 30.horizontalPadding,
              child: CommonText.text(
                AppStrings.changeCurrentLocation,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            25.hBox,
            const Divider(height: 1),
            TextButton(
              onPressed: () async {
                Get.back();
                await controller.confirmCurrentLocationChange();
              },
              child: CommonText.text(
                AppStrings.confirm,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Divider(height: 1),
            TextButton(
              onPressed: Get.back,
              child: CommonText.text(
                AppStrings.dismiss,
                color: AppColors.textFieldColor,
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
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final lat = controller.latitude.value;
        final lng = controller.longitude.value;

        if (lat == 0.0 && lng == 0.0) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              buildingsEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 14.0,
              ),
            ),
            const Center(
              child: Icon(Icons.location_pin, size: 50, color: Colors.red),
            ),
            SafeArea(
              child: Padding(
                padding: 5.horizontalPadding + 20.verticalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: Get.back,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        CommonText.text(
                          AppStrings.currentLocation,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        controller.navigateTo(AppRoutes.searchLocationScreen);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
