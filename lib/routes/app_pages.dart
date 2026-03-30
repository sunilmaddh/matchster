import 'package:get/route_manager.dart';
import 'package:matchster/features/auth/binding/auth_binding.dart';
import 'package:matchster/features/auth/views/login/country_list_screen.dart';
import 'package:matchster/features/auth/views/login/login_screen.dart';
import 'package:matchster/features/auth/views/login/otp_screen.dart';
import 'package:matchster/features/auth/views/onboarding/onboard_screen.dart';
import 'package:matchster/features/auth/views/login/login_field_with_button_view.dart';
import 'package:matchster/features/home/binding/landing_binding.dart';
import 'package:matchster/features/home/view/landing_screen.dart';
import 'package:matchster/features/posture/face_screen.dart';
import 'package:matchster/features/profile/view/interest/alcohal_screen.dart';
import 'package:matchster/features/profile/view/interest/interest_screen.dart';
import 'package:matchster/features/profile/view/interest/languages_screen.dart';
import 'package:matchster/features/profile/view/interest/religion_screen.dart';
import 'package:matchster/features/profile/view/interest/smoke_screen.dart';
import 'package:matchster/features/profile/view/interest/visibility_screen.dart';
import 'package:matchster/features/profile/view/interest/workout_screen.dart';
import 'package:matchster/features/profile/view/interest/zodiac_screen.dart';
import 'package:matchster/features/profile/view/location/add_home_town_screen.dart';
import 'package:matchster/features/profile/view/location/current_location.dart';
import 'package:matchster/features/profile/view/location/search_location_screen.dart';
import 'package:matchster/features/profile/view/profile/education_screen.dart';
import 'package:matchster/features/profile/view/profile/height_screen.dart';
import 'package:matchster/features/profile/view/profile/profile_photo_preview_screen.dart';
import 'package:matchster/features/profile/view/profile/profile_preview_screen.dart';
import 'package:matchster/features/profile/view/profile/work_screen.dart';
import 'package:matchster/features/profile/view/verify_email_otp_screen.dart';
import 'package:matchster/routes/app_routes.dart';

class AppPages {
  AppPages._();
  static List<GetPage> getPages = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.onboardScreen,
      page: () => OnboardScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.landingScreen,
      page: () => const LandingScreen(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePhotoPreviewScreen,
      page: () => ProfilePhotoPreviewScreen(),
    ),
    GetPage(name: AppRoutes.countryListScreen, page: () => CountryListScreen()),

    GetPage(name: AppRoutes.otpScreen, page: () => OtpScreen()),
    GetPage(
      name: AppRoutes.loginFieldWitButton,
      page: () => LoginFieldWithButtonView(),
    ),
    GetPage(
      name: AppRoutes.searchLocationScreen,
      page: () => SearchLocationScreen(),
    ),
    GetPage(name: AppRoutes.addHomeTownScreen, page: () => AddHomeTownScreen()),
    GetPage(name: AppRoutes.zodiacScreen, page: () => ZodiacScreen()),
    GetPage(name: AppRoutes.religionScreen, page: () => ReligionScreen()),
    GetPage(name: AppRoutes.height, page: () => HeightScreen()),
    GetPage(name: AppRoutes.education, page: () => EducationScreen()),
    GetPage(name: AppRoutes.work, page: () => WorkScreen()),
    GetPage(name: AppRoutes.faceCamera, page: () => FaceCameraScreen()),
    GetPage(name: AppRoutes.workout, page: () => WorkoutScreen()),
    GetPage(name: AppRoutes.smoke, page: () => SmokeScreen()),
    GetPage(name: AppRoutes.alcohol, page: () => AlcohalScreen()),
    GetPage(name: AppRoutes.interest, page: () => InterestScreen()),
    GetPage(name: AppRoutes.languages, page: () => LanguagesScreen()),
    GetPage(
      name: AppRoutes.currentLocationScreen,
      page: () => CurrentLocationScreen(),
    ),
    GetPage(name: AppRoutes.visibilityScreen, page: () => VisibilityScreen()),
    GetPage(
      name: AppRoutes.profilePreviewScreen,
      page: () => ProfilePreviewScreen(),
    ),
    GetPage(
      name: AppRoutes.verifyEmailOtpScreen,
      page: () => VerifyEmailOtpScreen(),
    ),
  ];
}
