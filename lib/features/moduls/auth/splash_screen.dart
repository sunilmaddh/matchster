import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/routes/app_routes.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    // Fade animation setup
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    // _fadeAnimation = CurvedAnimation(
    //   parent: _fadeController,
    //   curve: Curves.easeInOut,
    // );

    // Initialize video
    _controller = VideoPlayerController.asset(AppAssets.splashAsset)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(_checkVideoEnded);
      });
  }

  void _checkVideoEnded() {
    final bool isEnd = _controller.value.position >= _controller.value.duration;
    if (isEnd && mounted) {
      _controller.removeListener(_checkVideoEnded);
      _startFadeOutAndNavigate();
    }
  }

  void _startFadeOutAndNavigate() async {
    await _fadeController.forward(); // fade-out
    if (mounted) {
      Get.offAllNamed(AppRoutes.loginScreen); // navigate to login
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_checkVideoEnded);
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (_controller.value.isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
