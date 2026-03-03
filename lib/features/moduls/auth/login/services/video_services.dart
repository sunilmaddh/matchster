
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

    await player.open(Media('asset:///$assetPath'), play: false);
    player.setVolume(0);
    player.setPlaylistMode(PlaylistMode.none);
  }

  void play() {
    if (_isDisposed) return;
    player.seek(Duration.zero);
    player.play();
  }

  @override
  void onClose() async {
    if (_isDisposed) return;
    _isDisposed = true;
    await player.stop();
    await player.dispose();
    super.onClose();
  }
}

