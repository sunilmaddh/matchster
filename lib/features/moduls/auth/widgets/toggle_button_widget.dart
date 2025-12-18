import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleWithText extends StatefulWidget {
  const ToggleWithText({super.key, required this.onTop, required this.isFeet});
  final VoidCallback onTop;
  final RxBool isFeet;
  @override
  // ignore: library_private_types_in_public_api
  _ToggleWithTextState createState() => _ToggleWithTextState();
}

class _ToggleWithTextState extends State<ToggleWithText> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: widget.onTop,
        child: Container(
          width: 90,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Stack(
            children: [
              // Text
              Align(
                alignment:
                    widget.isFeet.isTrue
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.isFeet.isTrue ? "cm" : "feet",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Toggle Circle
              AnimatedAlign(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                alignment:
                    widget.isFeet.isTrue
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
