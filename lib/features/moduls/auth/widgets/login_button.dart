import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.name, required this.onTop});
  final String name;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          color: Color(0xff161E3E),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CommonText.text(name, color: AppColors.whiteColor),
      ),
    );
  }
}
