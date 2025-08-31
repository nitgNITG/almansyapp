import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'texts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.controller,
    this.onPressed,
    required this.text,
  });

  // final LoginController controller;
  final BaseController controller;
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (context, state, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 34.w,
            ),
            child: Center(
              child: Container(
                // height: 55.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: TextButton(
                  onPressed: onPressed,
                  child: state == AppViewState.busy
                      ? SizedBox(
                          height: 30.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : getNormalText(text, context,
                          color: Colors.white,
                          weight: FontWeight.w700,
                          size: 18.sp),
                ),
              ),
            ),
          );
        });
  }
}
