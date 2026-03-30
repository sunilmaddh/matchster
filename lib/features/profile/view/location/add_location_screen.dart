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
import 'package:matchster/features/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class AddLocationScreen extends BaseView<ProfileController> {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState
    extends BaseViewState<ProfileController, AddLocationScreen> {
  late final OnboardController _onboardController;

  @override
  void onInit() {
    super.onInit();
    _onboardController = Get.find<OnboardController>();
  }

  @override
  void onReady() {
    super.onReady();
    _showAddressChangeBottomSheet();
  }

  Future<void> _showAddressChangeBottomSheet() async {
    final placeDetails = controller.placeDetails.value;
    final details = placeDetails?.placeDetails;

    if (placeDetails?.lat == null ||
        placeDetails?.lng == null ||
        details == null ||
        details.label == null ||
        details.city == null ||
        details.state == null ||
        details.country == null) {
      return;
    }

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
            CommonText.displaySmall(
              AppStrings.areYouSure,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: 30.horizontalPadding,
              child: CommonText.headlineSmall(
                AppStrings.changeCurrentLocation,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
            25.hBox,
            const Divider(height: 1),
            TextButton(
              onPressed: () {
                _onboardController.addHomeLocation(
                  lat: placeDetails?.lat ?? 0.0,
                  lng: placeDetails?.lng ?? 0.0,
                  label: details.label!,
                  city: details.city!,
                  state: details.state!,
                  country: details.country!,
                );
              },
              child: CommonText.headlineSmall(
                AppStrings.confirm,

                fontWeight: FontWeight.w400,
              ),
            ),
            const Divider(height: 1),
            TextButton(
              onPressed: AppNavigation.back,
              child: CommonText.headlineSmall(
                AppStrings.dismiss,
                color: AppColors.textFieldColor,

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
        final placeDetails = controller.placeDetails.value;
        final details = placeDetails?.placeDetails;
        final lat = placeDetails?.lat;
        final lng = placeDetails?.lng;

        if (lat == null || lng == null) {
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
            if (details?.label != null)
              Center(
                child: Container(
                  width: 200.w,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.locations,
                        color: AppColors.primary,
                      ),
                      10.wBox,
                      Expanded(
                        child: CommonText.text(
                          details!.label!,
                          maxLines: 3,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
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
                        CommonText.titleMedium(
                          AppStrings.currentLocation,
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
