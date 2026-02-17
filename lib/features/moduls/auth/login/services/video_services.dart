import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoService extends GetxService {
  late final Player player;
  late final VideoController controller;

  bool _isOpened = false; // ensures single preload

  Future<VideoService> init() async {
    // Create player and controller
    player = Player();
    controller = VideoController(player);
    return this;
  }

  /// Preload video (do NOT play yet)
  Future<void> preloadAsset(String assetPath) async {
    if (_isOpened) return; // already opened
    _isOpened = true;

    await player.open(Media('asset:///$assetPath'), play: false);

    // Optional: mute background video
    player.setVolume(0);

    // Ensure no looping
    player.setPlaylistMode(PlaylistMode.none);
  }

  /// Play video after UI surface is attached
  void play() {
    player.seek(Duration.zero);
    player.play();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
