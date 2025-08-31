import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/widgets/texts.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    this.boxShadow,
    this.border,
    this.onPressed,
    required this.textColor,
    required this.text,
    this.backgroundcolor,
    this.gradient,
    this.size,
    this.width,
  });
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final void Function()? onPressed;
  final Color textColor;
  final String text;
  final Color? backgroundcolor;
  final Gradient? gradient;
  final double? size;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width ?? 255.w,
        //width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: boxShadow,
          border: border,
          borderRadius: BorderRadius.circular(50.r),
          color: backgroundcolor,
        ),
        child: TextButton(
            onPressed: onPressed,
            child: getTitleText(
                text,
                color: textColor,
                weight: FontWeight.w700,
                size: size ?? 28.sp,
                context)),
      ),
    );
  }
}
