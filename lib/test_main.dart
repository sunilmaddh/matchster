import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:matchster/core/constants/app_assets.dart';
import 'package:matchster/features/moduls/home/models/home_response.dart';
import 'package:matchster/features/moduls/home/view/match_screen.dart';
import 'package:matchster/features/moduls/home/widgets/match_card_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginBgWidget(),
    );
  }
}

class LoginBgWidget extends StatefulWidget {
  const LoginBgWidget({super.key});

  @override
  State<LoginBgWidget> createState() => _LoginBgWidgetState();
}

class _LoginBgWidgetState extends State<LoginBgWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
