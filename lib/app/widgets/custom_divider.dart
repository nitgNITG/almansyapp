import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/widgets/texts.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: const Color(0xffE6E6E6).withOpacity(.9),
              height: 0.5,
              //  width: ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: getTitleText(
                text,
                weight: FontWeight.w700,
                size: 16.sp,
                color: Colors.black,
                context),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffE6E6E6).withOpacity(.9),
              height: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
