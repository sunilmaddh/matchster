import 'package:flutter/material.dart';
import 'package:matchster/core/extentions/extentions.dart';

class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String hint;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  const CommonDropdown({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.value,
    this.hint = 'Select',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      icon: Icon(Icons.keyboard_arrow_down),
      value: value,
      isExpanded: true,
      hint: Text(hint),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
      items:
          items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(labelBuilder(item)),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
