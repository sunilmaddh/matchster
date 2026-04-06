import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/auth/model/response/reverse_geocode_response.dart';
import 'package:matchster/features/auth/repositories/onboard_repository.dart';
import 'package:matchster/features/profile/services/location_services.dart'
    show LocationService;
import 'package:matchster/routes/app_routes.dart';

class OnboardLocationController extends BaseController {
  OnboardLocationController({required this.onboardingRepository});

  final OnboardingRepository onboardingRepository;
  final LocationService _locationService = LocationService();

  Placemark place = Placemark();

  Future<Position?> fetchLocation() async {
    try {
      return await _locationService.getCurrentLocation();
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError('Unable to fetch location');
      return null;
    }
  }

  Future<Address?> getAddress({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await onboardingRepository.getAddress(
        lat: lat,
        lng: lng,
      );

      if (!response.success) {
        setError(response.message ?? 'Unable to fetch address');
        return null;
      }

      return response.data?.address;
    } catch (e) {
      AppMethods.appPrint(message: e.toString());
      setError('Unable to fetch address');
      return null;
    }
  }

  Future<bool> saveCurrentLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      showLoading(true);
      clearError();

      final response = await onboardingRepository.addCurrentLocation(
        lat: lat,
        lng: lng,
        label: label,
        city: city,
        state: state,
        country: country,
      );

      if (!response.success) {
        setError(response.message ?? 'Failed to save current location');
        return false;
      }

      return true;
    } catch (e) {
      setError('Failed to save current location');
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> saveHomeLocation({
    required double lat,
    required double lng,
    required String label,
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      showLoading(true);
      clearError();

      final response = await onboardingRepository.addHomeLocation(
        lat: lat,
        lng: lng,
        label: label,
        city: city,
        state: state,
        country: country,
      );

      if (!response.success) {
        setError(response.message ?? 'Failed to save home location');
        return false;
      }

      return true;
    } catch (e) {
      setError('Failed to save home location');
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<void> completeOnboarding() async {
    await MatchsterLocalStorage.instance.saveUserOnboard(true);

    final position = await fetchLocation();
    if (position == null) return;

    final address = await getAddress(
      lat: position.latitude,
      lng: position.longitude,
    );
    if (address == null) return;

    final isSuccess = await saveCurrentLocation(
      lat: address.lat ?? 0.0,
      lng: address.lng ?? 0.0,
      label: address.placeDetails?.label ?? '',
      city: address.placeDetails?.city ?? '',
      state: address.placeDetails?.state ?? '',
      country: address.placeDetails?.country ?? '',
    );

    if (isSuccess) {
      navigateOffAll(AppRoutes.landingScreen);
    }
  }
}
