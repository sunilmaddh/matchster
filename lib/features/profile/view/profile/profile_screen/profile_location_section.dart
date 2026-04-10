import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/widgets/location_card.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileLocationSection extends StatelessWidget {
  const ProfileLocationSection({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 15.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.hBox,
          CommonText.text(
            AppStrings.location,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Caros",
          ),
          5.hBox,
          InkWell(
            onTap: () {
              AppNavigation.to(AppRoutes.currentLocation);
            },
            child: Obx(
              () => LocationCard(
                title: AppStrings.currentLocation,
                subTitle:
                    controller.currentLocations.value.address?.label ?? "",
              ),
            ),
          ),
          15.hBox,
          InkWell(
            onTap: () {
              final data = controller.hometLocations.value;
              controller.navigateTo(
                AppRoutes.addHomeTownScreen,
                arguments: {
                  "city": data.city,
                  "state": data.state,
                  "country": data.country,
                  "country_code": data.countryCode,
                  "state_code": data.stateCode,
                },
              );
            },
            child: Obx(
              () => LocationCard(
                title: AppStrings.homeTown,
                subTitle:
                    controller.hometLocations.value.city != null
                        ? "${controller.hometLocations.value.city!.capitalize} ${controller.hometLocations.value.state!} ${controller.hometLocations.value.country!}"
                        : "",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
