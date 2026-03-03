import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SplashVideoService extends GetxService {
  late final Player player;
  late final VideoController controller;

  bool _isInitialized = false;
  bool _isDisposed = false;

  Future<SplashVideoService> init() async {
    player = Player();
    controller = VideoController(player);
    return this;
  }

  /// Open & play asset ONLY ONCE
  Future<void> playAsset(String asset) async {
    if (_isInitialized || _isDisposed) return; 
    _isInitialized = true;
    await player.open(Media('asset:///$asset'), play: false);

    player.setPlaylistMode(PlaylistMode.none);
    player.setVolume(0); 

    await player.play();

    // debugPrint("Video started once");
  }

  @override
  void onClose() {
    if (_isDisposed) return;
    _isDisposed = true;
    player.dispose();
    super.onClose();
  }
}
