import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/bar/custom_app_bar.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/controller/country_controller.dart';
import 'package:matchster/features/moduls/home/widgets/search_widget.dart';
import 'package:matchster/routes/app_navigation.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final controller = Get.put(CountryController());

  @override
  void initState() {
    final list = CountryService().getAll();
    controller.allCountries.assignAll(list);
    controller.filteredCountries.assignAll(list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Country Codes",
        onTop: () {
          AppNavigation.back();
        },
        isCenterTitle: false,
      ),
      body: Column(
        children: [
          _SearchField(controller: controller),
          const SizedBox(height: 8),
          _CountryList(controller: controller),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final CountryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SearchWidget(
        onChanged: (String value) {
          controller.search(value);
        },
      ),
    );
  }
}

class _CountryList extends StatelessWidget {
  const _CountryList({required this.controller});

  final CountryController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final list = controller.filteredCountries;

        if (list.isEmpty) {
          return const Center(child: Text("No countries found"));
        }

        return ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) => SizedBox(),
          itemBuilder: (_, index) {
            final country = list[index];

            return ListTile(
              leading: CommonText.text(country.flagEmoji, fontSize: 35.sp),
              title: CommonText.text(
                "${country.name} +${country.phoneCode}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),

              onTap: () => Get.back(result: country),
            );
          },
        );
      }),
    );
  }
}
