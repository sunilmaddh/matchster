import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/card/circle_gradiant_card.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/auth/login/widgets/login_button.dart';
import 'package:matchster/features/moduls/home/widgets/match_card_widget.dart';

class GifAnimation extends StatefulWidget {
  const GifAnimation({super.key});

  @override
  State<GifAnimation> createState() => _GifAnimationState();
}

class _GifAnimationState extends State<GifAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _icon2HideController;
  late AnimationController _icond1NoHideController;
  late AnimationController _icon3HideController;
  late AnimationController _icon4HideController;
  late AnimationController _icon5HideController;

  late Animation<double> icon1;
  late Animation<double> icon2;
  late Animation<double> icon3;
  late Animation<double> icon4;
  late Animation<double> icon5;

  late Animation<double> icon2HideAnimation;
  late Animation<double> icon3HideAnimation;
  late Animation<double> icon4HideAnimation;
  late Animation<double> icon5HideAnimation;
  late Animation<double> noHideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _icon2HideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _icon3HideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _icon4HideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _icon5HideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _icond1NoHideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3600),
    );
    noHideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _icond1NoHideController, curve: Curves.easeOut),
    );
    icon2HideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _icon2HideController, curve: Curves.bounceOut),
    );
    icon3HideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _icon3HideController, curve: Curves.easeOut),
    );
    icon4HideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _icon4HideController, curve: Curves.easeOut),
    );
    icon5HideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _icon5HideController, curve: Curves.easeOut),
    );

    icon1 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.bounceIn),
    );
    icon2 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.55, curve: Curves.bounceInOut),
    );
    icon3 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.bounceOut),
    );
    icon4 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.85, curve: Curves.bounceIn),
    );
    icon5 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.bounceInOut),
    );

    _controller.forward();

    /// ⏱ Hide after 2 seconds
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) _icon2HideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _icon3HideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) _icon4HideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) _icon5HideController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),

      body: SafeArea(
        child: Column(
          children: [
            /// Top Match Card Section
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Image.asset(
                      AppAssets.loginAni,
                      width: double.infinity,
                    ),
                  ),

                  // Padding(
                  //   padding: 48.verticalPadding + 22.horizontalPadding,
                  //   child: MatchCardWidget(),
                  // ),
                  Stack(
                    children: [
                      FloatingMatchIcon(
                        animation: icon1,
                        hideAnimation: noHideAnimation,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 60.h, right: 30.w),
                        asset: AppAssets.loveMatchAssets,
                      ),
                      FloatingMatchIcon(
                        animation: icon2,
                        hideAnimation: icon2HideAnimation,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(bottom: 60.h, left: 110.w),
                        asset: AppAssets.rightLIkes,
                        staticRotation: 1,
                      ),
                      FloatingMatchIcon(
                        animation: icon3,
                        hideAnimation: icon3HideAnimation,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 200.h, left: 50.w),
                        asset: AppAssets.likeAssets,
                        staticRotation: 5.9,
                      ),
                      FloatingMatchIcon(
                        animation: icon4,
                        hideAnimation: icon4HideAnimation,
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(bottom: 50.h, left: 75.w),
                        asset: AppAssets.rightLIkes,
                        staticRotation: 5.9,
                      ),
                      FloatingMatchIcon(
                        animation: icon5,
                        hideAnimation: icon5HideAnimation,
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(bottom: 80.h, right: 60.w),
                        asset: AppAssets.likeAssets,
                        staticRotation: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            10.hBox,

            /// Description Text
          ],
        ),
      ),
    );
  }
}

class FloatingMatchIcon extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> hideAnimation;
  final Alignment alignment;
  final EdgeInsets padding;
  final String asset;
  final double staticRotation;

  const FloatingMatchIcon({
    super.key,
    required this.animation,
    required this.hideAnimation,
    required this.alignment,
    required this.padding,
    required this.asset,
    this.staticRotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: AnimatedBuilder(
          animation: Listenable.merge([animation, hideAnimation]),
          child: SvgPicture.asset(asset),
          builder: (_, child) {
            final opacity = animation.value * hideAnimation.value;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, (1 - animation.value) * 25),
                child: Transform.rotate(
                  angle: staticRotation + (1 - animation.value) * -0.3,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
