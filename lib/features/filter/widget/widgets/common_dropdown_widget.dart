import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_colors.dart' show AppColors;

class CommonDropdownWidget extends StatelessWidget {
  const CommonDropdownWidget({
    super.key,
    required this.items,
    required this.hintText,
    required this.value,
    required this.onChanged,
  });

  final List<String> items;
  final String hintText;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      padding: EdgeInsets.zero,
      dropdownColor: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(20),
      value: value,
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xffA4A4A4).withOpacity(0.15)),
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xffA4A4A4).withOpacity(0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xffA4A4A4).withOpacity(0.15)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      items: List.generate(items.length, (index) {
        return DropdownMenuItem<String>(
          value: items[index],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(items[index]),
              // if (index != items.length - 1)
              //   const SizedBox(
              //     width: double.infinity,
              //     child: Divider(height: 1, thickness: 1),
              //   ),
            ],
          ),
        );
      }),
      onChanged: onChanged,
    );
  }
}
