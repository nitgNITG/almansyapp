import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step/app/core/data/shared_preferences/helper_funcs.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/modules/home/main_app_controller.dart';
import 'package:step/app/widgets/custom_copy_right_text.dart';
import 'package:step/app/widgets/texts.dart';

import '../core/themes/colors.dart';
import '../utils/helper_funcs.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({
    super.key,
    required this.controller1,
  });

  final MainAppController controller1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getNormalText(
          "Contact Us",
          context,
          weight: FontWeight.w700,
          size: 16.sp,
          color: kPrimary1Color,
        ),

        /// contact us كلمه
        getHeightSpace(5.h),
        Center(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
            width: 35.3.w,
            child: SvgPicture.asset("assets/images/whatsapp_ic.svg"),
          ),
        ).onTap(() {
          /// فانكشن الواتساب
          contactUsWhatsapp(controller1.phone);
        }),
        getHeightSpace(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 68.w),
          child: const CustomCopyRightText(),
        ),
        getHeightSpace(20),
      ],
    );
  }
}
