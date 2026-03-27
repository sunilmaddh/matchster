import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/features/modules/auth/services/splash_video_service.dart';
import 'package:matchster/routes/app_navigation.dart';
import 'package:matchster/routes/app_routes.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashVideoService _splashVideoService = Get.find<SplashVideoService>();
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _splashVideoService.playAsset(AppAssets.splashAsset);

    _navigationTimer = Timer(const Duration(seconds: 6), () {
      if (!mounted) return;
      AppNavigation.off(AppRoutes.loginScreen);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: width * 9.0 / 16,
          child: IgnorePointer(
            child: Video(
              controller: _splashVideoService.controller,
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
