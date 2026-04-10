import 'package:get/get.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/features/profile/controller/profile_base_controller.dart';
import 'package:matchster/features/profile/controller/profile_controller.dart'
    show ProfileController;
import 'package:matchster/features/profile/repositories/location_repository.dart';
import 'package:matchster/routes/app_routes.dart';

class ProfileLocationController extends ProfileBaseController {
  ProfileLocationController(
    this.profileController, {
    required this.locationRepository,
  });
  final LocationRepository locationRepository;
  final ProfileController profileController;

  final RxList<String> countryList = <String>[].obs;
  final RxList<String> stateList = <String>[].obs;
  final RxList<String> cityList = <String>[].obs;

  final RxString selectedState = "".obs;
  final RxString selectedCity = "".obs;
  final RxString selectedCountry = "".obs;
  final RxString selectedCountryCode = "".obs;
  final RxString selectedStateCode = "".obs;

  final RxBool isEnable = false.obs;
  // Maps name -> isoCode for states
  final Map<String, String> stateIsoMap = {};

  // Maps country name -> isoCode
  final Map<String, String> countryIsoMap = {};

  Future<void> getCountry({String? search}) async {
    try {
      // isLoadingCountries(true);
      final response = await locationRepository.getCountries(
        query: search ?? "",
      );
      if (response.success && response.data != null) {
        countryIsoMap.clear();
        final names = <String>[];
        for (final item in response.data!) {
          final name = item['name'] ?? '';
          final iso = item['isoCode'] ?? '';
          if (name.isNotEmpty) {
            names.add(name);
            countryIsoMap[name] = iso;
          }
        }
        countryList.assignAll(names);
      }
      // isLoadingCountries(false);
    } catch (e) {
      // isLoadingCountries(false);

      setError("Error fetching countries: $e");
    }
  }

  Future<void> getState({required String country, String? search}) async {
    try {
      // isLoadingStates(true);
      final response = await locationRepository.getStates(
        country: country,
        query: search,
      );
      if (response.success && response.data != null) {
        stateIsoMap.clear();
        final names = <String>[];
        for (final item in response.data!) {
          final name = item['name'] ?? '';
          final iso = item['isoCode'] ?? '';
          if (name.isNotEmpty) {
            names.add(name);
            stateIsoMap[name] = iso;
          }
        }
        stateList.assignAll(names);
      }
      // isLoadingStates(false);
    } catch (e) {
      // isLoadingStates(false);
      // AppMethods.appPrint(message: e.toString());
      setError(e.toString());
    }
  }

  Future<void> getCities({
    required String country,
    required String state,
    String? search,
  }) async {
    try {
      // isLoadingCities(true);
      final response = await locationRepository.getCities(
        country: country,
        state: state,
        query: search ?? "",
      );
      if (response.success && response.data != null) {
        cityList.assignAll(
          response.data!
              .map((e) => e['name'] ?? "")
              .where((n) => n.isNotEmpty)
              .toList(),
        );
      }
      // isLoadingCities(false);
    } catch (e) {
      // isLoadingCities(false);

      setError(e.toString());
    }
  }

  Future<void> addHomeLocation({
    required String city,
    required String state,
    required String country,
    required String countryCode,
    required String stateCode,
  }) async {
    try {
      final response = await locationRepository.addHomeLocation(
        city: city,
        state: state,
        country: country,
        countryCode: selectedCountryCode.value,
        stateCode: selectedStateCode.value,
      );
      if (response.success) {
        await profileController.getMyProfile(false);
        navigateBack();
      }
    } catch (e) {
      setError(errorMessage.value.toString());
    }
  }

  Future<void> setLocationData({
    required String city,
    required String state,
    required String country,
    required String countryCode,
    required String stateCode,
  }) async {
    selectedCity.value = city;
    selectedState.value = state;
    selectedCountry.value = country;
    selectedCountryCode.value = countryCode;
    selectedStateCode.value = stateCode;
  }

  Future<void> onCountryTap() async {
    await getCountry();
    final result = await Get.toNamed(
      AppRoutes.locationSearchScreen,
      arguments: {
        "title": AppStrings.locationString.selectCountryTitle,
        "type": 'Country',
        "selectedValue": selectedCountry.value,
        "list": countryList,
      },
    );
    if (result != null) {
      selectedCountry.value = result;
      selectedCountryCode.value = countryIsoMap[result] ?? result;
      selectedState.value = '';
      selectedStateCode.value = '';
      selectedCity.value = "";
      stateList.clear();
      cityList.clear();
      isEnable.value = false;

      // await getState(country: selectedCountryCode.value.toLowerCase());
    }
  }

  Future<void> onStateTap() async {
    if (selectedCountry.value.isEmpty) return;
    await getState(country: selectedCountryCode.value.toLowerCase());
    final result = await Get.toNamed(
      AppRoutes.locationSearchScreen,
      arguments: {
        "title": AppStrings.locationString.selectStateTitle,
        "type": 'State',
        "selectedValue": selectedState.value,
        "list": stateList,
      },
    );

    if (result != null) {
      selectedState.value = result;
      selectedStateCode.value = stateIsoMap[result] ?? result;
      selectedCity.value = "";
      cityList.clear();
      isEnable.value = false;
    }
  }

  Future<void> onCityTap() async {
    if (selectedState.value.isEmpty) return;
    await getCities(
      country: selectedCountryCode.value.toLowerCase(),
      state: selectedStateCode.value,
    );
    final result = await Get.toNamed(
      AppRoutes.locationSearchScreen,
      arguments: {
        "title": AppStrings.locationString.selectCityTitle,
        "type": 'City',
        "selectedValue": selectedCity.value,
        "list": cityList,
      },
    );

    if (result != null) {
      selectedCity.value = result;
      isEnable.value = true;
    }
  }
}
