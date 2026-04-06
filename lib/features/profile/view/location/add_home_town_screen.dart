import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/buttons/circle_button_widget.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/core/widgets/fields/custom_form_field.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart';
import 'package:matchster/features/profile/view/location/location_search_screen.dart';

class AddHomeTownScreen extends StatefulWidget {
  const AddHomeTownScreen({super.key});

  @override
  State<AddHomeTownScreen> createState() => _AddHomeTownScreenState();
}

class _AddHomeTownScreenState extends State<AddHomeTownScreen> {
  final _controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _controller.getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => CircleButtonWidget(
          icon: Icons.check,
          isEnable: _controller.isEnable.value,
          onTap: () {
            _controller.addHomeLocation(
              city: _controller.cityController.text,
              state: _controller.selectedState.value,
              country: _controller.selectedCountry.value,
            );
          },
        ),
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Hometown",
        onTop: () => Get.back(),
      ),
      body: Padding(
        padding: 15.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hBox,
            CommonText.text(
              "Where are you from?",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),

            /// ---------------- COUNTRY ----------------
            20.hBox,
            CommonText.text("Country"),
            10.hBox,

            InkWell(
              onTap: () async {
                await _controller.getCountry();

                final result = await Get.to(
                  () => LocationSearchScreen(
                    title: "Select Country",
                    type: 'country',
                    selectedValue: _controller.selectedCountry.value,
                    dataList: _controller.countryList,
                  ),
                );

                if (result != null) {
                  _controller.selectedCountry.value = result;
                  _controller.selectedCountryCode.value =
                      _controller.countryIsoMap[result] ?? result;
                  _controller.selectedState.value = '';
                  _controller.selectedStateCode.value = '';
                  _controller.cityController.clear();
                  _controller.stateList.clear();
                  _controller.cityList.clear();

                  await _controller.getState(
                    country:
                        _controller.selectedCountryCode.value.toLowerCase(),
                  );
                }
              },
              child: Obx(
                () => _buildBox(
                  text:
                      _controller.selectedCountry.value.isNotEmpty
                          ? _controller.selectedCountry.value
                          : "Select your country",
                  isSelected: _controller.selectedCountry.value.isNotEmpty,
                ),
              ),
            ),

            /// ---------------- STATE ----------------
            20.hBox,
            CommonText.text("State"),
            10.hBox,

            InkWell(
              onTap: () async {
                if (_controller.selectedCountry.isEmpty) return;

                final result = await Get.to(
                  () => LocationSearchScreen(
                    title: "Select State",
                    type: 'state',
                    selectedValue: _controller.selectedState.value,
                    dataList: _controller.stateList,
                  ),
                );

                if (result != null) {
                  _controller.selectedState.value = result;
                  _controller.selectedStateCode.value =
                      _controller.stateIsoMap[result] ?? result;
                  _controller.cityController.clear();
                  _controller.cityList.clear();

                  await _controller.getCity(
                    country:
                        _controller.selectedCountryCode.value.toLowerCase(),
                    state: _controller.selectedStateCode.value,
                  );
                }
              },
              child: Obx(
                () => _buildBox(
                  text:
                      _controller.selectedState.value.isNotEmpty
                          ? _controller.selectedState.value
                          : "Select your state",
                  isSelected: _controller.selectedState.value.isNotEmpty,
                ),
              ),
            ),

            /// ---------------- CITY ----------------
            20.hBox,
            CommonText.text("City"),
            10.hBox,

            GestureDetector(
              onTap: () async {
                if (_controller.selectedState.isEmpty) return;

                final result = await Get.to(
                  () => LocationSearchScreen(
                    title: "Select City",
                    type: 'city',
                    selectedValue: _controller.cityController.text,
                    dataList: _controller.cityList, // ✅ FIX
                  ),
                );

                if (result != null) {
                  _controller.cityController.text = result;
                  _controller.isEnable.value = true;
                }
              },
              child: AbsorbPointer(
                child: CustomFormField(
                  hint: "Enter your city name",
                  controller: _controller.cityController,
                  enableBorder: _controller.isEnable,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  label: '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 Reusable Box Widget (clean UI)
  Widget _buildBox({required String text, required bool isSelected}) {
    return Container(
      padding: 15.horizontalPadding,
      height: 48.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 2,
          color:
              isSelected
                  ? AppColors.textFieldColor
                  : AppColors.blackColor.withAlpha(64),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.text(text),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
