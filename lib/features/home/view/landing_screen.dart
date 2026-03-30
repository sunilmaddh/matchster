import 'package:flutter/material.dart';
import 'package:matchster/features/auth/views/onboarding/work_inprogress.dart';
import 'package:matchster/features/home/view/home_screen.dart';
import 'package:matchster/features/home/widgets/custom_bottom_sheet_navigation_bar.dart';
import 'package:matchster/features/profile/view/profile/profile_screen.dart';

class LandingScreen extends StatelessWidget {
  final int index;
  const LandingScreen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      // initialIndex: index,
      pageList: [
        HomeScreen(),
        MaintenceScreen(),
        MaintenceScreen(),
        //  GifAnimation(),
        MaintenceScreen(),

        // LikesScreen(),
        // PremiumScreen(),
        //   // ChatListMetchesScreen(),
        ProfileScreen(),
      ],
    );
  }
}
