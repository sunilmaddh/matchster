import 'package:flutter/material.dart';
import 'package:matchster/features/moduls/auth/onboard/view/work_inprogress.dart';
import 'package:matchster/features/moduls/home/view/home_screen.dart';
import 'package:matchster/features/moduls/home/widgets/custom_bottom_sheet_navigation_bar.dart';
import 'package:matchster/features/moduls/profile/view/profile/profile_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
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
