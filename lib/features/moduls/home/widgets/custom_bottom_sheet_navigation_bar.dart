import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/moduls/home/controller/home_controller.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.pageList});

  final List<Widget> pageList;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final _controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.pageController = PageController(
      initialPage: _controller.selectedIndex.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.01),
      body: PageView(
        controller: _controller.pageController,
        onPageChanged: (index) {
          _controller.selectedIndex.value = index;
        },
        children: widget.pageList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            // gradient: LinearGradient(
            //   begin: AlignmentGeometry.topCenter,
            //   end: AlignmentGeometry.bottomCenter,
            //   // colors: [
            //   //   Color(0xFF7A96F8).withOpacity(0.0),
            //   //   Color(0xFF587DFF).withOpacity(0.50),
            //   //   Color(0xFF5174FF).withOpacity(0.75),
            //   //   Color(0xFF3F66FF).withOpacity(0.87),
            //   //   Color(0xFF1D48EF).withOpacity(0.0),
            //   // ],
            // ),
          ),
          child: BottomAppBar(
            // padding: EdgeInsets.only(top: 18.0),
            shape: CircularNotchedRectangle(),
            color: Colors.grey.withOpacity(0.0),
            elevation: 8,
            child: Container(
              height: 70.h,
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 4,
                  ),
                ],
                border: Border.all(color: Color(0xffE6E6E6)),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _controller.onTabTapped(0);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.homeAssets,
                          color:
                              _controller.selectedIndex.value == 0
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),

                        CommonText.text(
                          "Home",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Caros",
                          color:
                              _controller.selectedIndex.value == 0
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _controller.onTabTapped(1);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.likesAssets,
                          color:
                              _controller.selectedIndex.value == 1
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                        CommonText.text(
                          "Likes",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Caros",
                          color:
                              _controller.selectedIndex.value == 1
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      _controller.onTabTapped(2);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.premuimAssets,
                          color:
                              _controller.selectedIndex.value == 2
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                        CommonText.text(
                          "Premium",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Caros",
                          color:
                              _controller.selectedIndex.value == 2
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _controller.onTabTapped(3);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.chatAssets,
                          color:
                              _controller.selectedIndex.value == 3
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                        CommonText.text(
                          "Chats",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Caros",
                          color:
                              _controller.selectedIndex.value == 3
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _controller.onTabTapped(4);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.profileAssets,
                          color:
                              _controller.selectedIndex.value == 4
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                        CommonText.text(
                          "Profile",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Caros",
                          color:
                              _controller.selectedIndex.value == 4
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
