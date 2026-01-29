import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/routes/app_routes.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _hideVideo = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _videoController = VideoPlayerController.asset(AppAssets.splashAsset);

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _videoController.initialize();
    if (!mounted) return;

    setState(() {});
    _videoController
      ..setVolume(0.0)
      ..setLooping(false)
      ..play();

    _videoController.addListener(_videoListener);
  }

  void _videoListener() {
    if (_hasNavigated) return;

    final value = _videoController.value;

    if (!value.isInitialized ||
        !value.isPlaying ||
        value.position == Duration.zero) {
      return;
    }

    // 🔑 Hide video BEFORE it ends (prevents flash)
    if (value.position >= value.duration - const Duration(milliseconds: 150)) {
      _hasNavigated = true;
      _hideVideo = true;
      _videoController.removeListener(_videoListener);

      setState(() {});
      _startFadeAndNavigate();
    }
  }

  Future<void> _startFadeAndNavigate() async {
    await _fadeController.forward();
    if (!mounted) return;
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  @override
  void dispose() {
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ALWAYS WHITE
      body: Stack(
        fit: StackFit.expand,
        children: [
          // White background layer
          Container(
            color: Colors.white,

            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),

          // Video layer
          if (_videoController.value.isInitialized && !_hideVideo)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.scale(
                scale: 1.02, // 🔑 hides 1–2px black line
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
