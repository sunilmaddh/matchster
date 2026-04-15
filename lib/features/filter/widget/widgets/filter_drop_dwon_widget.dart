import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extentions.dart';
import 'package:matchster/core/widgets/fields/common_text.dart';
import 'package:matchster/features/filter/widget/widgets/common_dropdown_widget.dart';

class FilterDropDwonWidget extends StatelessWidget {
  const FilterDropDwonWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.list,
    required this.onChanged,
    required this.hintText,
    required this.value,
  });
  final String title;
  final String subtitle;
  final List<String> list;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: 5.horizontalPadding + 5.verticalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText.titleMedium(
              textAlign: TextAlign.center,
              title,
              fontWeight: FontWeight.w700,
            ),
            CommonText.labelLarge(subtitle, fontWeight: FontWeight.w500),
            20.hBox,
            CommonDropdownWidget(
              items: list,
              hintText: hintText,
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
