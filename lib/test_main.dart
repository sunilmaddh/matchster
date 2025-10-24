import 'package:flutter/material.dart';
import 'package:matchster/features/moduls/auth/widgets/radio_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // CustomFormField(
            //   label: "",
            //   hint: "Please enter mobile number",
            //   controller: controller,
            // ),

            // CircleButtonWidget(),

            // SizedBox(height: 20),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: AppButton(name: "Log out", onTop: () {}),
            // ),

            // LoginButton(name: 'Continue with Mobile Number', onTop: () {}),
            // RadioWidget(),
          ],
        ),
      ),
    );
  }
}
