import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:matchster/features/moduls/profile/data/repositories/location_services.dart';
import 'package:matchster/features/moduls/profile/presentation/widgets/location_card.dart';

class ProfileController extends GetxController {
  final LocationService _locationService = LocationService();
  RxBool isSelected = false.obs;
  RxList<String> selectedItems = <String>[].obs;
  RxInt selectedIndex = 1.obs;
  RxDouble lattitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  Future<void> fetchLocation() async {
    try {
      Position? position = await _locationService.getCurrentLocation();
      lattitude.value = position!.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
