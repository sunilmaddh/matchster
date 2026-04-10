import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/features/auth/model/response/add_date_with_response.dart';
import 'package:matchster/features/profile/services/location_services.dart';

class LocationRepository {
  LocationRepository({required this.locationService});
  final LocationService locationService;

  Future<BaseResponse<List<Map<String, dynamic>>>> getCountries({
    required String query,
  }) async {
    return locationService.getCountries(search: query);
  }

  Future<BaseResponse<List<Map<String, String>>>> getStates({
    required String country,
    String? query,
  }) async {
    return locationService.getStates(country: country, search: query);
  }

  Future<BaseResponse<List<Map<String, String>>>> getCities({
    required String country,
    required String state,
    required String query,
  }) async {
    return locationService.getCities(
      country: country,
      state: state,
      search: query,
    );
  }

  Future<BaseResponse<AddDateWithResponse>> addHomeLocation({
    required String city,
    required String state,
    required String country,
    required String countryCode,
    required String stateCode,
  }) async {
    return await locationService.addHomeLocation(
      city: city,
      state: state,
      country: country,
      countryCode: countryCode,
      stateCode: stateCode,
    );
  }
}
