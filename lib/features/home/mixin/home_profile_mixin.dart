import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/base/base_controller.dart';
import 'package:matchster/core/enum/enum.dart';
import 'package:matchster/core/extentions/gender_enum_ext.dart';
import 'package:matchster/core/extentions/height_enum_ext.dart';
import 'package:matchster/core/extentions/religion_level_ext.dart';
import 'package:matchster/core/extentions/zodiac_enum_ext.dart';
import 'package:matchster/core/utils/app_methods.dart';
import 'package:matchster/features/home/models/habit_option.dart';
import 'package:matchster/features/home/models/home_response.dart';
import 'package:matchster/features/home/models/inshort_list.dart';
import 'package:matchster/features/home/models/request/get_profile_request.dart';
import 'package:matchster/features/home/repositories/home_repository.dart';

mixin HomeProfileMixin on BaseController {
  HomeRepository get homeRepository;

  RxList<Profile> get profileList;
  RxList<InshortList> get inshortList;
  RxList<String> get swipedUserIds;
  RxInt get currentIndex;

  Profile? get currentProfile;

  Future<void> loadProfiles({
    String filterType = 'basic',
    int filter = 10,
    bool showLoader = true,
  }) async {
    try {
      if (profileList.isEmpty) {
        return null;
      }

      if (showLoader) {
        isLoading.value = true;
      }

      final request = GetProfileRequest(
        filterType: filterType,
        distance: filter,
      );

      final response = await homeRepository.getProfileList(request: request);

      clearProfileState();

      if (response.success && response.data?.profiles != null) {
        _setProfileData(response.data!.profiles!);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      AppMethods.appPrint(message: e.toString());
    } finally {
      if (showLoader) {
        isLoading.value = false;
      }
    }
  }

  Future<void> loadRetrieveProfiles({bool showLoader = true}) async {
    if (profileList.isEmpty) return null;
    try {
      if (showLoader) {
        isLoading.value = true;
      }
      final response = await homeRepository.getRetriveProfileList();
      clearProfileState();
      if (response.success && response.data?.profiles != null) {
        _setProfileData(response.data!.profiles!);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      AppMethods.appPrint(message: e.toString());
    } finally {
      if (showLoader) {
        isLoading.value = false;
      }
    }
  }

  void _setProfileData(List<Profile> profiles) {
    profileList.assignAll(profiles);
    swipedUserIds.clear();
    currentIndex.value = 0;
    updateInShort();
    preloadInitialCachedImages(profiles);
  }

  void clearProfileState() {
    profileList.clear();
    inshortList.clear();
    swipedUserIds.clear();
    currentIndex.value = 0;
  }

  void updateInShort() {
    final profile = currentProfile;

    inshortList.clear();

    if (profile == null) return;

    if ((profile.gender ?? '').trim().isNotEmpty) {
      final value = GenderEnumX.fromApi(profile.gender!);
      if (value != null) {
        inshortList.add(InshortList(text: profile.gender!, img: value.emoji));
      }
    }

    if ((profile.smoking ?? '').trim().isNotEmpty) {
      final freq = frequencyFromApi(profile.smoking!);
      if (freq != null) {
        final option = HabitOption(type: HabitTypeEnum.smoke, frequency: freq);
        inshortList.add(InshortList(text: option.label, img: option.emoji));
      }
    }

    if ((profile.drinking ?? '').trim().isNotEmpty) {
      final freq = frequencyFromApi(profile.drinking!);
      if (freq != null) {
        final option = HabitOption(
          type: HabitTypeEnum.drinking,
          frequency: freq,
        );
        inshortList.add(InshortList(text: option.label, img: option.emoji));
      }
    }

    if ((profile.religion ?? '').trim().isNotEmpty) {
      final value = ReligionEnumX.fromApi(profile.religion!);
      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }

    if ((profile.zodiacSign ?? '').trim().isNotEmpty) {
      final value = ZodiacEnumX.fromApi(profile.zodiacSign!);
      if (value != null) {
        inshortList.add(InshortList(text: value.label, img: value.emoji));
      }
    }

    if ((profile.height ?? '').trim().isNotEmpty) {
      final value = HeightEnumExt.fromApi(profile.height!);
      if (value != null) {
        inshortList.add(InshortList(text: profile.height!, img: value.emoji));
      }
    }
  }

  void preloadInitialCachedImages(List<Profile> profiles) {
    final validProfiles = profiles
        .where((profile) => (profile.mainPhoto ?? '').trim().isNotEmpty)
        .take(3);

    for (final profile in validProfiles) {
      CachedNetworkImageProvider(
        profile.mainPhoto!,
      ).resolve(const ImageConfiguration());
    }
  }

  Future<void> preloadInitialCards(
    BuildContext context,
    List<Profile> profiles,
  ) async {
    final validProfiles =
        profiles
            .where((profile) => (profile.mainPhoto ?? '').trim().isNotEmpty)
            .take(3)
            .toList();

    for (final profile in validProfiles) {
      await precacheImage(
        CachedNetworkImageProvider(profile.mainPhoto!),
        context,
      );
    }
  }

  List<HabitOption> buildHabitOptions(
    HabitTypeEnum type, {
    Set<FrequencyEnum>? exclude,
  }) {
    return FrequencyEnum.values
        .where((e) => exclude == null || !exclude.contains(e))
        .map((e) => HabitOption(type: type, frequency: e))
        .toList();
  }
}

FrequencyEnum? frequencyFromApi(String value) {
  final normalized = value.trim().toLowerCase();

  for (final item in FrequencyEnum.values) {
    if (item.name.toLowerCase() == normalized) {
      return item;
    }
  }

  return null;
}
