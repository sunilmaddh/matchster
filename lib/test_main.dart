import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:matchster/features/moduls/profile/services/face_detector_service.dart';

void main() async {
  await initCamera();
  runApp(const MyApp());
}

late List<CameraDescription> cameras;

Future<void> initCamera() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FaceDetectorScreen(),
    );
  }
}

class FaceDetectorScreen extends StatefulWidget {
  const FaceDetectorScreen({super.key});

  @override
  State<FaceDetectorScreen> createState() => _FaceDetectorScreenState();
}

class _FaceDetectorScreenState extends State<FaceDetectorScreen> {
  late CameraController _controller;
  final FaceDetectorService _faceService = FaceDetectorService();

  bool _isDetecting = false;
  Face? _detectedFace;
  Size? _imageSize;

  CameraDescription getFrontCamera() {
    return cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
  }

  @override
  void initState() {
    super.initState();

    final frontCamera = getFrontCamera();

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420, // ✅ REQUIRED
    );

    _controller.initialize().then((_) {
      _controller.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  void _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    debugPrint("Face detected called");

    try {
      _imageSize = Size(image.width.toDouble(), image.height.toDouble());

      debugPrint("Face detected 1");

      final inputImage = inputImageFromCameraImage(
        image,
        _controller.description,
      );

      debugPrint("Face detected 2");

      final faces = await _faceService.detectFaces(inputImage);

      debugPrint("Face detected 3: ${faces.length}");

      if (faces.isNotEmpty) {
        setState(() {
          _detectedFace = faces.first;
        });
      } else {
        setState(() {
          _detectedFace = null;
        });
      }
    } catch (e) {
      debugPrint("Face detection error: $e");
    } finally {
      _isDetecting = false; // ✅ ALWAYS reset here
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),

          if (_detectedFace != null && _imageSize != null)
            CustomPaint(
              painter: FaceOverlayPainter(
                scaleRect(
                  rect: _detectedFace!.boundingBox,
                  imageSize: _imageSize!,
                  widgetSize: MediaQuery.of(context).size,
                ),
              ),
              size: Size.infinite,
            ),
        ],
      ),
    );
  }
}

InputImage inputImageFromCameraImage(
  CameraImage image,
  CameraDescription camera,
) {
  return InputImage.fromBytes(
    bytes: yuv420ToNv21(image),
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: InputImageRotation.rotation270deg, // 🔥 FORCE THIS
      format: InputImageFormat.nv21,
      bytesPerRow: image.width,
    ),
  );
}

Uint8List yuv420ToNv21(CameraImage image) {
  final yPlane = image.planes[0].bytes;
  final uPlane = image.planes[1].bytes;
  final vPlane = image.planes[2].bytes;

  final nv21 = Uint8List(yPlane.length + uPlane.length + vPlane.length);

  nv21.setRange(0, yPlane.length, yPlane);

  int index = yPlane.length;
  for (int i = 0; i < uPlane.length; i++) {
    nv21[index++] = uPlane[i]; // 🔄 swapped
    nv21[index++] = vPlane[i];
  }

  return nv21;
}

Rect scaleRect({
  required Rect rect,
  required Size imageSize,
  required Size widgetSize,
}) {
  final scaleX = widgetSize.width / imageSize.width;
  final scaleY = widgetSize.height / imageSize.height;

  return Rect.fromLTRB(
    rect.left * scaleX,
    rect.top * scaleY,
    rect.right * scaleX,
    rect.bottom * scaleY,
  );
}

class FaceOverlayPainter extends CustomPainter {
  final Rect faceRect;

  FaceOverlayPainter(this.faceRect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    canvas.drawRect(faceRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TinderSwiperPage extends StatefulWidget {
  const TinderSwiperPage({super.key, required this.profiles});
  final List<Profile> profiles;

  @override
  State<TinderSwiperPage> createState() => _TinderSwiperPageState();
}

class _TinderSwiperPageState extends State<TinderSwiperPage> {
  final CardSwiperController _controller = CardSwiperController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CardSwiper(
            controller: _controller,
            cardsCount: widget.profiles.length,
            numberOfCardsDisplayed: 3,
            backCardOffset: const Offset(20, 20),
            padding: const EdgeInsets.all(16),
            onSwipe: _onSwipe,
            cardBuilder: (
              context,
              index,
              horizontalThresholdPercentage,
              verticalThresholdPercentage,
            ) {
              return ProfileCard(profile: widget.profiles[index]);
            },
          ),
        ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(
                icon: Icons.close,
                color: Colors.red,
                onTap: () => _controller.swipe(CardSwiperDirection.left),
              ),
              _actionButton(
                icon: Icons.favorite,
                color: Colors.green,
                onTap: () => _controller.swipe(CardSwiperDirection.right),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // final List<ProfileDemo> profiles = [
  //   ProfileDemo(
  //     name: "Emma",
  //     age: 24,
  //     image: "https://picsum.photos/400/600?1",
  //   ),
  //   ProfileDemo(
  //     name: "Sophia",
  //     age: 26,
  //     image: "https://picsum.photos/400/600?2",
  //   ),
  //   ProfileDemo(
  //     name: "Olivia",
  //     age: 23,
  //     image: "https://picsum.photos/400/600?3",
  //   ),
  //   ProfileDemo(name: "Ava", age: 25, image: "https://picsum.photos/400/600?4"),
  // ];

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final profile = widget.profiles[previousIndex];

    if (direction == CardSwiperDirection.right) {
      debugPrint("Liked ${profile.name}");
    } else if (direction == CardSwiperDirection.left) {
      debugPrint("Disliked ${profile.name}");
    }

    return true;
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onTap,
      child: Icon(icon, color: color, size: 30),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(profile.mainPhoto!, fit: BoxFit.cover),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),

          // Profile info
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Text(
              "${profile.name}, ${profile.age}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
