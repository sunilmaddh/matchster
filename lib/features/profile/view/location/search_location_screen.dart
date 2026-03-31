import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_view.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/profile/controller/location_controller.dart';

class SearchLocationScreen extends BaseView<LocationController> {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState
    extends BaseViewState<LocationController, SearchLocationScreen> {
  late final TextEditingController _searchController;

  @override
  void onInit() {
    super.onInit();
    _searchController = TextEditingController();
  }

  @override
  void onDispose() {
    _searchController.dispose();
    super.onDispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.searchLocationTitle,
        onTop: Get.back,
      ),
      body: Padding(
        padding: 10.horizontalPadding,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.searchFieldBgColor,
                border: Border.all(
                  color: AppColors.searchFieldBorderColor,
                  width: 1.w,
                ),
              ),
              child: TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: AppStrings.searchLocationHint,
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  final value = text.trim();

                  if (value.length >= 3) {
                    controller.autoCompleteLocation(query: value);
                  } else {
                    controller.autoCompleteResponse.clear();
                  }
                },
              ),
            ),
            10.hBox,
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.autoCompleteResponse.length,
                  itemBuilder: (context, index) {
                    final item = controller.autoCompleteResponse[index];
                    final description = item.description ?? '';
                    final placeId = item.placeId ?? '';

                    return Padding(
                      padding: 15.horizontalPadding,
                      child: InkWell(
                        onTap:
                            placeId.isEmpty
                                ? null
                                : () {
                                  controller.placeDetailsLocation(
                                    placeId: placeId,
                                  );
                                },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AppAssets.locations,
                              color: AppColors.blackColor,
                            ),
                            10.wBox,
                            Expanded(
                              child: CommonText.titleMedium(
                                description,
                                maxLines: 3,
                                color: Colors.black.withAlpha(156),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: 15.verticalPadding,
                      child: const Divider(height: 1),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
