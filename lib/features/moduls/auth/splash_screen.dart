import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/features/moduls/auth/login/services/splash_video_service.dart';
import 'package:matchster/routes/app_routes.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Get.find<SplashVideoService>().playAsset(AppAssets.splashAsset);

    _checkTokenAndNavigate();
    super.initState();
  }

  Future<void> _checkTokenAndNavigate() async {
    await Future.delayed(const Duration(seconds: 6));

    final token = await MatchsterLocalStorage.instance.getAccessToken();

    if (token.isNotEmpty) {
      // Token exists, navigate to home
      Get.offAllNamed(AppRoutes.landingScreen);
    } else {
      // No token, navigate to login
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16,
          child: IgnorePointer(
            child: Video(
              controller: Get.find<SplashVideoService>().controller,
              controls: NoVideoControls,
              fill: Colors.white,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
