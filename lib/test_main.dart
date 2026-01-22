import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TinderSwiperPage(),
    );
  }
}

class ProfileDemo {
  final String name;
  final int age;
  final String image;

  ProfileDemo({required this.name, required this.age, required this.image});
}

class TinderSwiperPage extends StatefulWidget {
  const TinderSwiperPage({super.key});

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CardSwiper(
                controller: _controller,
                cardsCount: profiles.length,
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
                  return ProfileCard(profile: profiles[index]);
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
        ),
      ),
    );
  }

  final List<ProfileDemo> profiles = [
    ProfileDemo(
      name: "Emma",
      age: 24,
      image: "https://picsum.photos/400/600?1",
    ),
    ProfileDemo(
      name: "Sophia",
      age: 26,
      image: "https://picsum.photos/400/600?2",
    ),
    ProfileDemo(
      name: "Olivia",
      age: 23,
      image: "https://picsum.photos/400/600?3",
    ),
    ProfileDemo(name: "Ava", age: 25, image: "https://picsum.photos/400/600?4"),
  ];

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final profile = profiles[previousIndex];

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

  final ProfileDemo profile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(profile.image, fit: BoxFit.cover),

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
