import 'package:get/route_manager.dart';
import 'package:matchster/features/auth/bindings/login_binding.dart';
import 'package:matchster/features/auth/view/login/login_field_screen.dart';
import 'package:matchster/features/auth/view/login/login_screen.dart';
import 'package:matchster/features/auth/view/onboard/current_loading_screen.dart';
import 'package:matchster/features/auth/view/onboard/onboard_screen.dart';
import 'package:matchster/features/filter/bindings/filter_binding.dart';
import 'package:matchster/features/filter/view/filter_screen.dart';
import 'package:matchster/features/landing/view/landing_screen.dart';
import 'package:matchster/features/landing/bindings/landing_banding.dart';
import 'package:matchster/features/notification/bindings/notification_binding.dart';
import 'package:matchster/features/notification/view/notification_screen.dart';
import 'package:matchster/features/posture/view/face_gender_screen.dart';
import 'package:matchster/features/posture/view/hand_tracker_screen.dart';
import 'package:matchster/features/posture/view/posture_gesture_screen.dart';
import 'package:matchster/features/profile/bindings/email_binding.dart';
import 'package:matchster/features/profile/bindings/location_binding.dart';
import 'package:matchster/features/posture/bindings/posture_bindings.dart';
import 'package:matchster/features/profile/view/interest/alcohal_screen.dart';
import 'package:matchster/features/profile/view/interest/interest_screen.dart';
import 'package:matchster/features/profile/view/interest/languages_screen.dart';
import 'package:matchster/features/profile/view/interest/looking_screen.dart';
import 'package:matchster/features/profile/view/interest/religion_screen.dart';
import 'package:matchster/features/profile/view/interest/smoke_screen.dart';
import 'package:matchster/features/profile/view/interest/visibility_screen.dart';
import 'package:matchster/features/profile/view/interest/workout_screen.dart';
import 'package:matchster/features/profile/view/interest/zodiac_screen.dart';
import 'package:matchster/features/profile/view/location/add_home_town_screen.dart';
import 'package:matchster/features/profile/view/location/current_location.dart';
import 'package:matchster/features/profile/view/location/location_search_screen.dart';
import 'package:matchster/features/profile/view/profile/education_screen.dart';
import 'package:matchster/features/profile/view/profile/height_screen.dart';
import 'package:matchster/features/profile/view/profile/profile_screen/profile_preview_screen.dart';
import 'package:matchster/features/setting/bindings/setting_binding.dart';
import 'package:matchster/features/setting/view/setting_screen.dart';
import 'package:matchster/features/profile/view/profile/work_screen.dart';
import 'package:matchster/features/profile/view/email/verify_email_otp_screen.dart';
import 'package:matchster/features/profile/view/email/verify_email_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.onboardScreen, page: () => OnboardScreen()),
    GetPage(
      name: AppRoutes.landingScreen,
      page: () => LandingScreen(),
      binding: LandingBanding(),
    ),

    GetPage(
      name: AppRoutes.currentLoadingScreen,
      page: () => CurrentLoadingScreen(),
    ),
    GetPage(
      name: AppRoutes.profilePreviewScreen,
      page: () => ProfilePreviewScreen(),
    ),
    GetPage(
      name: AppRoutes.verifyEmailScreen,
      page: () => VerifyEmailScreen(),
      binding: EmailBinding(),
    ),
    GetPage(name: AppRoutes.currentLocation, page: () => CurrentLocation()),
    GetPage(
      name: AppRoutes.addHomeTownScreen,
      page: () => AddHomeTownScreen(),
      binding: LocationBinding(),
    ),

    GetPage(
      name: AppRoutes.verifyEmailOtpScreen,
      page: () => VerifyEmailOtpScreen(),
    ),
    GetPage(
      name: AppRoutes.locationSearchScreen,
      page: () => LocationSearchScreen(),
    ),
    GetPage(name: AppRoutes.heightScreen, page: () => HeightScreen()),
    GetPage(name: AppRoutes.educationScreen, page: () => EducationScreen()),
    GetPage(name: AppRoutes.workScreen, page: () => WorkScreen()),
    GetPage(name: AppRoutes.zodiacScreen, page: () => ZodiacScreen()),
    GetPage(name: AppRoutes.religionScreen, page: () => ReligionScreen()),
    GetPage(name: AppRoutes.visibilityScreen, page: () => VisibilityScreen()),
    GetPage(name: AppRoutes.lookingScreen, page: () => LookingScreen()),
    GetPage(name: AppRoutes.workoutScreen, page: () => WorkoutScreen()),
    GetPage(name: AppRoutes.smokeScreen, page: () => SmokeScreen()),
    GetPage(name: AppRoutes.alcohalScreen, page: () => AlcohalScreen()),
    GetPage(name: AppRoutes.interestScreen, page: () => InterestScreen()),
    GetPage(name: AppRoutes.languagesScreen, page: () => LanguagesScreen()),
    GetPage(name: AppRoutes.loginFieldScreen, page: () => LoginFieldScreen()),
    GetPage(name: AppRoutes.handTrackerScreen, page: () => HandTrackerScreen()),
    GetPage(name: AppRoutes.faceGenderScreen, page: () => FaceGenderScreen()),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.filterScreen,
      page: () => FilterScreen(),
      binding: FilterBinding(),
    ),

    GetPage(
      name: AppRoutes.postureGestureScreen,
      page: () => PostureGestureScreen(),
      binding: PostureBinding(),
    ),
    GetPage(
      name: AppRoutes.settingScreen,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
  ];
}
