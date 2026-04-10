import 'package:geolocator/geolocator.dart';
import 'package:matchster/core/network/base_response.dart';
import 'package:matchster/core/network/base_service.dart';
import 'package:matchster/core/utils/api_endpoints.dart';
import 'package:matchster/features/auth/model/response/add_date_with_response.dart';

class LocationService {
  LocationService({required this.baseService});
  final BaseService baseService;

  /// Checks permission and returns the current position.
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return Future.error(
        'Location permissions are permanently denied, cannot request permissions.',
      );
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<BaseResponse<List<Map<String, String>>>> getCountries({
    String? search,
  }) async {
    return await baseService.getRequest<List<Map<String, String>>>(
      path:
          "${ApiEndpoints.cscCountry}${search != null ? '?search=$search' : ''}",
      fromJsonT:
          (json) =>
              (json as List)
                  .map(
                    (e) => {
                      'name': (e['name'] ?? '').toString(),
                      'isoCode': (e['isoCode'] ?? '').toString(),
                    },
                  )
                  .toList(),
    );
  }

  /// Returns list of maps with 'name' and 'isoCode'
  Future<BaseResponse<List<Map<String, String>>>> getStates({
    required String country,
    String? search,
  }) async {
    return await baseService.getRequest<List<Map<String, String>>>(
      path:
          "${ApiEndpoints.cscState}?country=$country${search != null ? '&search=$search' : ''}",
      fromJsonT:
          (json) =>
              (json as List)
                  .map(
                    (e) => {
                      'name': (e['name'] ?? '').toString(),
                      'isoCode': (e['isoCode'] ?? '').toString(),
                    },
                  )
                  .toList(),
    );
  }

  /// Returns list of maps with 'name'
  Future<BaseResponse<List<Map<String, String>>>> getCities({
    required String country,
    required String state,
    required String search,
  }) async {
    return await baseService.getRequest<List<Map<String, String>>>(
      path:
          "${ApiEndpoints.cscCity}?country=$country&state=$state${search != null ? '&search=$search' : ''}",
      fromJsonT:
          (json) =>
              (json as List)
                  .map((e) => {'name': (e['name'] ?? '').toString()})
                  .toList(),
    );
  }

  Future<BaseResponse<AddDateWithResponse>> addHomeLocation({
    required String city,
    required String state,
    required String country,
    required String countryCode,
    required String stateCode,
  }) async {
    return baseService.postRequest<AddDateWithResponse>(
      path: ApiEndpoints.addHomeTownLocation,
      data: {
        "homeTown": {
          "city": city,
          "state": state,
          "country": country,
          "stateCode": stateCode,
          "countryCode": countryCode,
        },
      },
    );
  }
}
