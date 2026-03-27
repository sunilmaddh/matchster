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
import 'package:matchster/features/modules/auth/auth_controllers/onboard_controller.dart';
import 'package:matchster/features/modules/profile/controller/profile_controller.dart';
import 'package:matchster/features/modules/profile/view/location/search_location_screen.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});
  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _profileController = Get.find<ProfileController>();
  final _controller = Get.find<OnboardController>();

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
              onPressed: () {
                _controller.addHomeLocation(
                  lat: _profileController.placeDetails.value.lat!,
                  lng: _profileController.placeDetails.value.lng!,
                  label:
                      _profileController
                          .placeDetails
                          .value
                          .placeDetails!
                          .label!,
                  city:
                      _profileController.placeDetails.value.placeDetails!.city!,
                  state:
                      _profileController
                          .placeDetails
                          .value
                          .placeDetails!
                          .state!,
                  country:
                      _profileController
                          .placeDetails
                          .value
                          .placeDetails!
                          .country!,
                );
              },
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

  // @override
  // void dispose() {
  //   homeAddressController.dispose();
  //   apartmentAreaController.dispose();
  //   bottomSheetScrollController.dispose();
  //   searchController.dispose();
  //   super.dispose();
  // }

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
              final lat = _profileController.placeDetails.value.lat;
              final lng = _profileController.placeDetails.value.lng;
              return GoogleMap(
                zoomControlsEnabled: true,
                buildingsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: (controller) {
                  // if (!_controllerCompleter.isCompleted) {
                  //   _controllerCompleter.complete(controller);
                  // }
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 14.0,
                ),

                // markers: provider.marker,
                // polylines: provider.polyline,
                // initialCameraPosition: CameraPosition(
                //   target: provider.currentLocation,

                //)
              );
            }),

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
                    SizedBox(
                      width: 156.w,
                      child: CommonText.text(
                        maxLines: 3,
                        _profileController
                            .placeDetails
                            .value
                            .placeDetails!
                            .label!,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Consumer<MapProvider>(
            //   builder: (context, provider, _) {
            //     return AddressBottomSheet(
            //       scrollController: bottomSheetScrollController,
            //       currentAddress: provider.currentAddress,
            //       homeAddressController: homeAddressController,
            //       apartmentAreaController: apartmentAreaController,
            //       initialChildSize: 0.25,
            //       minChildSize: 0.1,
            //       maxChildSize: 0.6,
            //     );
            //   },
            // ),
            // Positioned(
            //   top: 40,
            //   left: 16,
            //   right: 16,
            //   child: Material(
            //     elevation: 8,
            //     borderRadius: BorderRadius.circular(8),
            //     child: Consumer<MapProvider>(
            //       builder: (context, provider, _) {
            //         return TypeAheadField<dynamic>(
            //           controller: searchController,
            //           focusNode: FocusNode(),
            //           suggestionsCallback: (pattern) async {
            //             await provider.fetchSuggestions(pattern);
            //             return provider.placeSuggestions;
            //           },
            //           itemBuilder: (context, dynamic suggestion) {
            //             return ListTile(
            //               title: BrandText(data: suggestion['description']),
            //             );
            //           },
            //           onSelected: (dynamic suggestion) {
            //             provider.onSuggestionSelected(suggestion);
            //           },
            //           hideOnEmpty: true,
            //           emptyBuilder: (context) => Padding(
            //             padding: EdgeInsets.all(8),
            //             child: BrandText(data: context.loc.no_location_found),
            //           ),
            //           builder:
            //               (
            //                 context,
            //                 TextEditingController controller,
            //                 FocusNode focusNode,
            //               ) {
            //                 return BrandTextField(
            //                   controller: controller,
            //                   focusNode: focusNode,
            //                   decoration: InputDecoration(
            //                     hintText: context.loc.search_location,
            //                     border: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                       borderSide: BorderSide.none,
            //                     ),
            //                     prefixIcon: const Icon(Icons.search),
            //                     filled: true,
            //                     fillColor: Colors.white,
            //                     contentPadding: const EdgeInsets.symmetric(
            //                       horizontal: 16,
            //                       vertical: 0,
            //                     ),
            //                   ),
            //                 );
            //               },
            //         );
            //       },
            //     ),
            //   ),
            // ),
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

        // floatingActionButton: Consumer<MapProvider>(
        //   builder: (context, provider, _) {
        //     return FloatingActionButton(
        //       backgroundColor: AppColors.greyC7,
        //       onPressed: () async {
        //         await provider.updateCurrentLocation();
        //         final controller = await _controllerCompleter.future;
        //         await controller.animateCamera(
        //           CameraUpdate.newCameraPosition(
        //             CameraPosition(
        //               target: provider.currentLocation,
        //               zoom: provider.zoom,
        //             ),
        //           ),
        //         );
        //       },
        //       child: const Icon(Icons.my_location, color: AppColors.primary),
        //     );
        //   },
        // ),
      ),
    );
  }
}
