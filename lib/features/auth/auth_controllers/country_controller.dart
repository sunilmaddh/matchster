import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final RxList<Country> allCountries = <Country>[].obs;
  final RxList<Country> filteredCountries = <Country>[].obs;
  Rx<Country?> selectedCountry = Rx<Country?>(null);

  void search(String query) {
    if (query.isEmpty) {
      filteredCountries.assignAll(allCountries);
      return;
    }
    final q = query.toLowerCase();
    filteredCountries.assignAll(
      allCountries.where(
        (c) =>
            c.name.toLowerCase().contains(q) ||
            c.phoneCode.contains(q) ||
            c.countryCode.toLowerCase().contains(q),
      ),
    );
  }
}
