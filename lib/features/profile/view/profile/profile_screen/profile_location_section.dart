import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/location_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/location_card.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileLocationSection extends StatelessWidget {
  const ProfileLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final locationController = Get.find<LocationController>();

    final currentAddress =
        profileController.currentLocation?.address?.label ?? '';
    final homeData = profileController.homeTown;

    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.titleMedium(AppStrings.location),
          5.hBox,
          InkWell(
            onTap: () {
              profileController.navigateTo(AppRoutes.currentLocationScreen);
            },
            child: LocationCard(
              title: AppStrings.currentLocation,
              subTitle: currentAddress,
            ),
          ),
          15.hBox,
          InkWell(
            onTap: () {
              locationController.cityController.text = homeData?.city ?? '';
              locationController.selectedState.value = homeData?.state ?? '';
              profileController.navigateTo(AppRoutes.addHomeTownScreen);
            },
            child: LocationCard(
              title: AppStrings.homeTown,
              subTitle: _formatHomeTown(
                city: homeData?.city,
                state: homeData?.state,
                country: homeData?.country,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatHomeTown({
    required String? city,
    required String? state,
    required String? country,
  }) {
    final values =
        [city, state, country]
            .where((e) => e != null && e.trim().isNotEmpty)
            .map((e) => e!.capitalize!)
            .toList();

    return values.join(', ');
  }
}
