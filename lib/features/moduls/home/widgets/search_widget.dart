import 'package:flutter/material.dart';
import 'package:matchster/core/utils/extensions.dart';

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
          prefixIcon: Icon(Icons.search, color: Color(0xff939393)),
          hintText: "Search partners",
          hintStyle: TextStyle(
            color: Color(0xff939393),
            fontFamily: "Caros",
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
          ),
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
