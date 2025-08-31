import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/helper_funcs.dart';

class MinistryLogoHorizontalWithName extends StatelessWidget {
  const MinistryLogoHorizontalWithName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getWidthSpace(5),
        // Image.asset(
        //   "assets/images/app_logo.png",
        //   width: 50,
        //   height: 50,
        //   fit: BoxFit.fill,
        // ),
        getWidthSpace(5),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getHeightSpace(5),
            Text(
              getL10(context).ministryOfManpower,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  height: 0.8),
            ),
            Text(
              getL10(context).vocationalTrainingAcademy,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
            ),
          ],
        )
      ],
    );
  }
}

class VocationalAcademyHorizontalRegister extends StatelessWidget {
  const VocationalAcademyHorizontalRegister({
    super.key,
    this.heightPercent = 0.15,
  });
  final double heightPercent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: getScreenHeight(context) * heightPercent,
      width: getScreenWidth(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/images/arrow_back_icon.svg'),
              ),
            ),
            // Center(
            //   child: Image.asset(
            //     "assets/images/app_logo.png",
            //     //width: 0.5.sw,
            //     width: 190.w,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Container()
          ],
        ),
      ),
    );
  }
}
