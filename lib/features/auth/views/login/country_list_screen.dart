import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/features/common/widgets/bar/custom_app_bar.dart';
import 'package:matchster/features/common/widgets/fields/common_text.dart';
import 'package:matchster/features/auth/auth_controllers/country_controller.dart';
import 'package:matchster/features/home/widgets/search_widget.dart';
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
        title: AppStrings.countryCodes,
        onTop: AppNavigation.back,
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
      child: SearchWidget(onChanged: controller.search),
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
          return Center(
            child: CommonText.bodyMedium(AppStrings.noCountriesFound),
          );
        }

        return ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(),
          itemBuilder: (_, index) {
            final country = list[index];

            return ListTile(
              leading: CommonText.displayLarge(country.flagEmoji),
              title: CommonText.titleMedium(
                _formatCountry(country.name, country.phoneCode),
                fontWeight: FontWeight.w400,
              ),
              onTap: () => Get.back(result: country),
            );
          },
        );
      }),
    );
  }

  String _formatCountry(String name, String code) {
    return '$name +$code';
  }
}
