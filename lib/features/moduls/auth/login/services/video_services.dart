import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoService extends GetxService {
  late final Player player;
  late final VideoController controller;

  bool _isOpened = false;
  bool _isDisposed = false;

  Future<VideoService> init() async {
    player = Player();
    controller = VideoController(player);
    return this;
  }

  Future<void> preloadAsset(String assetPath) async {
    if (_isOpened || _isDisposed) return;
    _isOpened = true;

    try {
      await player.open(Media('asset:///$assetPath'), play: false);
      player.setVolume(0);
      player.setPlaylistMode(PlaylistMode.none);
    } catch (e) {
      _isOpened = false;
    }
  }

  void play() {
    if (_isDisposed || !_isOpened) return;
    try {
      player.seek(Duration.zero);
      player.play();
    } catch (e) {}
  }

  @override
  void onClose() async {
    if (_isDisposed) return;
    _isDisposed = true;
    try {
      await player.stop();
      await player.dispose();
    } catch (e) {}
    super.onClose();
  }
}

