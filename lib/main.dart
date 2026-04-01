import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matchster/core/bindings/app_binding.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/core/constants/app_constants.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/storage/matchster_local_storage.dart';
import 'package:matchster/features/auth/services/splash_video_service.dart';
import 'package:matchster/features/auth/services/video_services.dart';
import 'package:matchster/features/auth/views/splash_screen.dart';
import 'package:matchster/firebase_options.dart';
import 'package:matchster/routes/app_pages.dart';
import 'package:media_kit/media_kit.dart';

late List<CameraDescription> camerasList;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBinding().dependencies();
  MatchsterLocalStorage.instance.init();
  MediaKit.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  camerasList = await availableCameras();
  await Get.putAsync(
    () =>
        VideoService().init()
          ..then((service) => service.preloadAsset(AppAssets.loginBGAssets)),
  );
  await Get.putAsync(() => SplashVideoService().init());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //runApp(DevicePreview(builder: (context) => const MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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

          title: AppStrings.appTitle,
          home: SplashScreen(),
          getPages: AppPages.getPages,
        ),
      ),
    );
  }
}
