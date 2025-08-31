import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/widgets/logos.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget widget;

  const BackgroundContainer({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          getHeightSpace(65.h),
          SizedBox(
            width: getScreenSize(context).width,
            child: const VocationalAcademyHorizontalRegister(),
          ),
          getHeightSpace(10.h),
          Expanded(
            child: widget,
          ),
        ],
      ),
    );
  }
}
