import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNav(),
      body: Stack(
        children: [
          /// Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 190),
            child: Column(
              children: const [ProfileImages(), SizedBox(height: 24)],
            ),
          ),

          /// Fixed bottom card
          BottomProfileCard(controller: controller),
        ],
      ),
    );
  }
}

class ProfileImages extends StatelessWidget {
  const ProfileImages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView(
        children: [
          Image.asset("assets/user1.jpg", fit: BoxFit.cover),
          Image.asset("assets/user2.jpg", fit: BoxFit.cover),
          Image.asset("assets/user3.jpg", fit: BoxFit.cover),
        ],
      ),
    );
  }
}

class BottomProfileCard extends StatelessWidget {
  final ProfileController controller;

  const BottomProfileCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Name + Age + Distance
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.name.value}, ${controller.age.value}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(controller.distance.value),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// Interests
              Obx(
                () => Wrap(
                  spacing: 8,
                  children:
                      controller.interests
                          .map((e) => Chip(label: Text(e)))
                          .toList(),
                ),
              ),

              const SizedBox(height: 16),

              /// Action Buttons
              ActionButtons(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final ProfileController controller;

  const ActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _circleButton(
          icon: Icons.close,
          color: Colors.red,
          onTap: controller.dislike,
        ),
        _circleButton(
          icon: Icons.favorite,
          color: Colors.blue,
          onTap: controller.like,
        ),
      ],
    );
  }

  Widget _circleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: color.withOpacity(0.12),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}

class ProfileController extends GetxController {
  final name = "Ryle Sharma".obs;
  final age = 28.obs;
  final distance = "4 km away".obs;

  final interests = ["Travel", "Music"].obs;

  void like() {
    // TODO: swipe right / API call
    print("Liked");
  }

  void dislike() {
    // TODO: swipe left / API call
    print("Disliked");
  }
}

class MyBottomNav extends StatelessWidget {
  const MyBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.08)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _NavItem(icon: Icons.home, index: 0),
            _NavItem(icon: Icons.favorite, index: 1),
            _NavItem(icon: Icons.star, index: 2),
            _NavItem(icon: Icons.chat, index: 3),
            _NavItem(icon: Icons.person, index: 4),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;

  const _NavItem({required this.icon, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    return Obx(() {
      final isActive = controller.selectedIndex.value == index;

      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26, color: isActive ? Colors.blue : Colors.grey),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 4,
              width: isActive ? 16 : 0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class BottomNavController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
