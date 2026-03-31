import 'package:flutter/material.dart';
import 'package:matchster/core/constants/app_strings.dart';
import 'package:matchster/core/extentions/extentions.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.onChanged});

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.black12, width: 1.w),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: const Color(0xff939393)),
          hintText: AppStrings.searchPartners,
          hintStyle: TextStyle(
            color: const Color(0xff939393),
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
