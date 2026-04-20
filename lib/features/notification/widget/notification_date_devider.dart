import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';

class NotificationDateDevider extends StatelessWidget {
  const NotificationDateDevider({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 25,
      children: [
        CommonText.labelMedium(date, color: AppColors.notificationGreyColor),
        Expanded(
          child: Divider(height: 1, color: AppColors.notificationDividerColor),
        ),
      ],
    );
  }
}
