import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SplashVideoService extends GetxService {
  late final Player player;
  late final VideoController controller;

  bool _isInitialized = false;

  Future<SplashVideoService> init() async {
    player = Player();
    controller = VideoController(player);
    return this;
  }

  /// Open & play asset ONLY ONCE
  Future<void> playAsset(String asset) async {
    if (_isInitialized) return; // 🔒 prevents multiple plays
    _isInitialized = true;
    await player.open(Media('asset:///$asset'), play: false);

    player.setPlaylistMode(PlaylistMode.none);
    player.setVolume(0); // 🔇 background video

    await player.play();

    // debugPrint("Video started once");
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
