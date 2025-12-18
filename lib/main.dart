import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:matchster/core/bindings/app_binding.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/utils/navigation_halper.dart';
import 'package:matchster/features/moduls/auth/splash_screen.dart';
import 'package:matchster/routes/app_pages.dart';

void main() {
  AppBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.deviceSize,
      minTextAdapt: true,
      ensureScreenSize: true,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
          ),
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          initialBinding: AppBinding(),
          title: 'Matchster',
          navigatorKey: NavigationHelper.navigatorKey,
          home: SplashScreen(),
          getPages: AppPages.getPages,
        ),
      ),
    );
  }
}
