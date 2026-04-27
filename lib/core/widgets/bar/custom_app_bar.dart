import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Widget? leading;
  final bool isCenterTitle;
  final Color textColor;
  final VoidCallback onTop;
  final bool isLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.leading,
    this.isLeading = true,

    required this.onTop,
    this.isCenterTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          isLeading
              ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: onTop ?? () => Get.back(),
                  icon: Icon(Icons.arrow_back),
                ),
              )
              : SizedBox.shrink(),
      title: CommonText.titleMedium(title, color: textColor),
      centerTitle: isCenterTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
